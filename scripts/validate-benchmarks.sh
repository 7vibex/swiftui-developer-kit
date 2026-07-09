#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$repo_root"

ruby -rjson -rpathname <<'RUBY'
root = Pathname.pwd
rubric = JSON.parse((root / "benchmarks/rubric.json").read)
required_fields = rubric.fetch("required_fields")
forbidden_phrases = rubric.fetch("forbidden_phrases")

def evaluate(path, root, required_fields, forbidden_phrases, require_contract:)
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

  forbidden_phrases.each do |phrase|
    errors << "forbidden claim #{phrase}" if text.downcase.include?(phrase.downcase)
  end

  [score, errors]
end

task_paths = Dir[root.join("benchmarks/tasks/*.json")].sort.map { |path| Pathname(path) }
minimum = rubric.fetch("minimum_tasks")
abort("expected at least #{minimum} benchmark tasks") if task_paths.length < minimum

baseline_total = 0
with_skill_total = 0

task_paths.each do |task_path|
  task = JSON.parse(task_path.read)
  id = task.fetch("id")
  artifact = root / task.fetch("artifact")
  abort("#{id} artifact does not exist: #{artifact}") unless artifact.file?

  baseline_path = root / "benchmarks/outputs/baseline/#{id}.md"
  skill_path = root / "benchmarks/outputs/with-skill/#{id}.md"
  abort("missing baseline output for #{id}") unless baseline_path.file?
  abort("missing skill-guided output for #{id}") unless skill_path.file?

  baseline_score, baseline_errors = evaluate(
    baseline_path, root, required_fields, forbidden_phrases, require_contract: false
  )
  skill_score, skill_errors = evaluate(
    skill_path, root, required_fields, forbidden_phrases, require_contract: true
  )

  abort("#{id} baseline contains invalid claims: #{baseline_errors.join(", ")}") unless baseline_errors.empty?
  abort("#{id} skill output invalid: #{skill_errors.join(", ")}") unless skill_errors.empty?
  abort("#{id} skill output omitted expected finding") unless skill_path.read.include?(task.fetch("expected_finding"))
  abort("#{id} skill output did not outperform baseline") unless skill_score > baseline_score

  baseline_total += baseline_score
  with_skill_total += skill_score
end

invalid_paths = Dir[root.join("benchmarks/invalid/*.md")].sort.map { |path| Pathname(path) }
abort("expected three invalid benchmark fixtures") unless invalid_paths.length == 3
invalid_paths.each do |path|
  _, errors = evaluate(path, root, required_fields, forbidden_phrases, require_contract: true)
  abort("#{path} was expected to fail") if errors.empty?
end

results = JSON.parse((root / "benchmarks/results.json").read)
abort("result task count drift") unless results["task_count"] == task_paths.length
abort("baseline score drift") unless results["baseline_total"] == baseline_total
abort("skill score drift") unless results["with_skill_total"] == with_skill_total
abort("invalid fixture result drift") unless results["invalid_fixtures_rejected"] == invalid_paths.length
abort("results must not claim live model measurement") unless results["live_model_claim"] == false

puts "Behavior benchmark validation passed: #{task_paths.length} tasks, #{with_skill_total} skill score."
RUBY
