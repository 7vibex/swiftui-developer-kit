#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$repo_root"

write_results=0
case "${1:-}" in
  "")
    ;;
  --write-results)
    write_results=1
    ;;
  *)
    echo "Usage: scripts/validate-benchmarks.sh [--write-results]" >&2
    exit 2
    ;;
esac

SWIFTUI_KIT_WRITE_BENCHMARK_RESULTS="$write_results" ruby -rdate -rjson -rpathname -rset <<'RUBY'
root = Pathname.pwd
rubric = JSON.parse((root / "benchmarks/rubric.json").read)
required_fields = rubric.fetch("required_fields")
forbidden_phrases = rubric.fetch("forbidden_phrases")
write_results = ENV.fetch("SWIFTUI_KIT_WRITE_BENCHMARK_RESULTS") == "1"

def evaluate(path, root, required_fields, forbidden_phrases, require_contract:, required_terms:, required_sections:)
  text = path.read
  errors = []
  score = 0

  required_fields.each do |field|
    present = text.include?(field)
    score += 1 if present
    errors << "missing #{field}" if require_contract && !present
  end

  references = text.scan(/`([^`]+?\.(?:swift|json|md|yml))(?:\:\d+)?`/).flatten
  references.each do |reference|
    if (root / reference).file?
      score += 1
    else
      errors << "hallucinated path #{reference}"
    end
  end
  errors << "missing local evidence reference" if require_contract && references.empty?

  required_terms.each do |term|
    present = text.downcase.include?(term.downcase)
    errors << "missing task-specific term #{term.inspect}" if require_contract && !present
  end

  headings = text.each_line.each_with_object([]) do |line, values|
    match = line.match(/^\#{1,6}\s+(.+?)\s*$/)
    values << match[1].downcase if match
  end
  required_sections.each do |section|
    present = headings.include?(section.downcase)
    errors << "missing task-specific section #{section.inspect}" if require_contract && !present
  end

  forbidden_phrases.each do |phrase|
    errors << "forbidden claim #{phrase}" if text.downcase.include?(phrase.downcase)
  end

  [score, errors]
end

task_paths = Dir[root.join("benchmarks/tasks/*.json")].sort.map { |path| Pathname(path) }
minimum = rubric.fetch("minimum_tasks")
abort("expected at least #{minimum} benchmark tasks") if task_paths.length < minimum
skill_names = Dir[root.join(".agents/skills/*/SKILL.md")]
  .map { |path| File.basename(File.dirname(path)) }
  .sort
abort("no skill folders found for benchmark coverage") if skill_names.empty?

task_ids = Set.new
task_skills = Set.new

baseline_total = 0
with_skill_total = 0

task_paths.each do |task_path|
  task = JSON.parse(task_path.read)
  id = task.fetch("id")
  abort("duplicate task id #{id}") unless task_ids.add?(id)
  skill = task.fetch("skill")
  abort("#{id} names unknown skill #{skill}") unless skill_names.include?(skill)
  task_skills << skill
  artifact = root / task.fetch("artifact")
  abort("#{id} artifact does not exist: #{artifact}") unless artifact.file?

  required_terms = task.fetch("required_terms")
  unless required_terms.is_a?(Array) && !required_terms.empty? && required_terms.all? { |term| term.is_a?(String) && !term.strip.empty? }
    abort("#{id} must define a non-empty required_terms array")
  end
  required_sections = task.fetch("required_sections", [])
  unless required_sections.is_a?(Array) && required_sections.all? { |section| section.is_a?(String) && !section.strip.empty? }
    abort("#{id} required_sections must be an array of non-empty strings")
  end

  baseline_path = root / "benchmarks/outputs/baseline/#{id}.md"
  skill_path = root / "benchmarks/outputs/with-skill/#{id}.md"
  abort("missing baseline output for #{id}") unless baseline_path.file?
  abort("missing skill-guided output for #{id}") unless skill_path.file?

  baseline_score, baseline_errors = evaluate(
    baseline_path,
    root,
    required_fields,
    forbidden_phrases,
    require_contract: false,
    required_terms: [],
    required_sections: []
  )
  skill_score, skill_errors = evaluate(
    skill_path,
    root,
    required_fields,
    forbidden_phrases,
    require_contract: true,
    required_terms: required_terms,
    required_sections: required_sections
  )

  abort("#{id} baseline contains invalid claims: #{baseline_errors.join(", ")}") unless baseline_errors.empty?
  abort("#{id} skill output invalid: #{skill_errors.join(", ")}") unless skill_errors.empty?
  abort("#{id} skill output omitted expected finding") unless skill_path.read.include?(task.fetch("expected_finding"))
  abort("#{id} skill output did not outperform baseline") unless skill_score > baseline_score

  baseline_total += baseline_score
  with_skill_total += skill_score
end

missing_skill_coverage = skill_names - task_skills.to_a
abort("benchmark tasks do not cover skills: #{missing_skill_coverage.join(", ")}") unless missing_skill_coverage.empty?

routing_path = root / "benchmarks/routing-cases.json"
abort("missing routing regression matrix: #{routing_path}") unless routing_path.file?
routing = JSON.parse(routing_path.read)
abort("routing regression matrix version mismatch") unless routing["version"] == "1.0.0"
purpose = routing.fetch("purpose")
abort("routing regression matrix must reject live-model claims") unless purpose.match?(/not\s+be\s+presented\s+as\s+live\s+model/i)
routing_cases = routing.fetch("cases")
abort("routing regression matrix must contain an array of cases") unless routing_cases.is_a?(Array)
abort("routing regression matrix must contain at least four cases") unless routing_cases.length >= 4

routing_ids = Set.new
routing_pairs = Set.new
routing_skills = Set.new
routing_cases.each do |routing_case|
  %w[id prompt expected_skill not_skill reason].each do |field|
    value = routing_case.fetch(field)
    abort("routing case #{routing_case.inspect} has an empty #{field}") unless value.is_a?(String) && !value.strip.empty?
  end
  id = routing_case.fetch("id")
  abort("duplicate routing case id #{id}") unless routing_ids.add?(id)
  prompt = routing_case.fetch("prompt")
  abort("routing case #{id} prompt is too thin") if prompt.strip.length < 20
  expected_skill = routing_case.fetch("expected_skill")
  not_skill = routing_case.fetch("not_skill")
  abort("routing case #{id} names unknown expected skill #{expected_skill}") unless skill_names.include?(expected_skill)
  abort("routing case #{id} names unknown excluded skill #{not_skill}") unless skill_names.include?(not_skill)
  abort("routing case #{id} must distinguish expected and excluded skills") if expected_skill == not_skill

  routing_pairs << [expected_skill, not_skill]
  routing_skills << expected_skill
end

required_routing_skills = %w[
  swiftui-feature-builder
  swiftui-ui-patterns
  swiftui-localization-auditor
  apple-app-security-privacy-auditor
]
missing_routing_skills = required_routing_skills - routing_skills.to_a
abort("routing regression matrix lacks expected routes for: #{missing_routing_skills.join(", ")}") unless missing_routing_skills.empty?

[
  %w[swiftui-feature-builder swiftui-ui-patterns],
  %w[swiftui-ui-patterns swiftui-feature-builder]
].each do |pair|
  abort("routing regression matrix lacks the #{pair.join(" over ")} distinction") unless routing_pairs.include?(pair)
end

invalid_paths = Dir[root.join("benchmarks/invalid/*.md")].sort.map { |path| Pathname(path) }
abort("expected at least three invalid benchmark fixtures") unless invalid_paths.length >= 3
invalid_paths.each do |path|
  _, errors = evaluate(
    path,
    root,
    required_fields,
    forbidden_phrases,
    require_contract: true,
    required_terms: [],
    required_sections: []
  )
  abort("#{path} was expected to fail") if errors.empty?
end

results_path = root / "benchmarks/results.json"
results = JSON.parse(results_path.read)
generated_results = {
  "evaluated_on" => Date.today.iso8601,
  "method" => "deterministic fixture evaluation",
  "live_model_claim" => false,
  "task_count" => task_paths.length,
  "baseline_total" => baseline_total,
  "with_skill_total" => with_skill_total,
  "invalid_fixtures_rejected" => invalid_paths.length
}

if write_results
  results_path.write(JSON.pretty_generate(generated_results) + "\n")
  (root / "benchmarks/results.md").write(<<~MARKDOWN)
    # Benchmark Fixture Results

    Evaluated: #{generated_results.fetch("evaluated_on")}

    | Measure | Baseline | Skill-guided |
    | --- | ---: | ---: |
    | Tasks | #{task_paths.length} | #{task_paths.length} |
    | Required-field and evidence score | #{baseline_total} | #{with_skill_total} |
    | Hallucinated local paths accepted | 0 | 0 |
    | Unsafe capture claims accepted | 0 | 0 |

    #{invalid_paths.length} invalid fixtures are rejected: hallucinated path, missing evidence field, and unsafe screenshot capture.

    These numbers describe checked-in deterministic fixtures only. They are not a live model benchmark or a claim about model accuracy.
  MARKDOWN
  results = generated_results
else
  %w[task_count baseline_total with_skill_total invalid_fixtures_rejected].each do |field|
    abort("result #{field} drift") unless results[field] == generated_results[field]
  end
end

abort("results must not claim live model measurement") unless results["live_model_claim"] == false
abort("results must identify deterministic fixtures") unless results["method"] == "deterministic fixture evaluation"
results_markdown = (root / "benchmarks/results.md").read
abort("results Markdown task count drift") unless results_markdown.include?("| Tasks | #{task_paths.length} | #{task_paths.length} |")
abort("results Markdown score drift") unless results_markdown.include?("| Required-field and evidence score | #{baseline_total} | #{with_skill_total} |")

puts "Behavior benchmark validation passed: #{task_paths.length} tasks across #{task_skills.length} skills, #{routing_cases.length} routing cases, #{with_skill_total} skill score."
RUBY
