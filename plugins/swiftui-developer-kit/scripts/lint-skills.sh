#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$repo_root"

fail() {
  echo "error: $*" >&2
  exit 1
}

max_description_length=240
max_skill_lines=120
max_reference_lines=400
skill_count=0

for skill_file in .agents/skills/*/SKILL.md; do
  [[ -f "$skill_file" ]] || continue

  skill_count=$((skill_count + 1))
  skill_dir="$(dirname "$skill_file")"
  skill_name="$(basename "$skill_dir")"
  description="$(
    ruby - "$skill_file" <<'RUBY'
require "yaml"

path = ARGV.fetch(0)
content = File.read(path)
match = content.match(/\A---\n(.*?)\n---\n/m)
abort("missing YAML frontmatter") unless match

frontmatter = YAML.safe_load(match[1])
abort("frontmatter is not a map") unless frontmatter.is_a?(Hash)

keys = frontmatter.keys.sort
abort("frontmatter must contain only description and name") unless keys == ["description", "name"]

puts frontmatter.fetch("description").to_s
RUBY
  )" || fail "invalid frontmatter in $skill_file"

  if [[ ${#description} -gt $max_description_length ]]; then
    fail "$skill_file description is ${#description} characters; limit is $max_description_length"
  fi

  if [[ ! "$description" =~ ^(Audit|Build|Diagnose|Generate|Improve|Review|Route|Plan|Create|Draft) ]]; then
    fail "$skill_file description must start with a concrete trigger verb"
  fi

  line_count="$(wc -l < "$skill_file" | tr -d ' ')"
  if [[ "$line_count" -gt "$max_skill_lines" ]]; then
    fail "$skill_file has $line_count lines; move detailed guidance into references"
  fi

  grep -q "## Do Not Use When" "$skill_file" || fail "$skill_name lacks Do Not Use When"
  grep -q "## Done When" "$skill_file" || fail "$skill_name lacks Done When"
  grep -q "skill-quality-standard.md" "$skill_file" || fail "$skill_name lacks the shared evidence and safety standard"

  [[ -d "$skill_dir/references" ]] || fail "$skill_name lacks references directory"
  output_contract="$skill_dir/references/output-contract.md"
  [[ -s "$output_contract" ]] || fail "$skill_name lacks a useful output contract"
  grep -q "output-contract.md" "$skill_file" || fail "$skill_name does not route users to its output contract"

  for field in severity evidence impact verification confidence "missing evidence"; do
    grep -qi "$field" "$output_contract" || fail "$skill_name output contract lacks $field"
  done
  grep -Eqi 'safety|privacy|approval' "$output_contract" || fail "$skill_name output contract lacks a safety or approval boundary"

  bad_example="examples/skill-outputs/$skill_name-bad-output.md"
  good_example="examples/skill-outputs/$skill_name-good-output.md"
  [[ -s "$bad_example" ]] || fail "$skill_name lacks a bad-output example"
  [[ -s "$good_example" ]] || fail "$skill_name lacks a good-output example"
  grep -q "$skill_name-bad-output.md" "$skill_file" || fail "$skill_name does not route to its bad-output example"
  grep -q "$skill_name-good-output.md" "$skill_file" || fail "$skill_name does not route to its good-output example"

  while IFS= read -r reference; do
    [[ -s "$reference" ]] || fail "$reference is empty"
    reference_lines="$(wc -l < "$reference" | tr -d ' ')"
    if [[ "$reference_lines" -gt "$max_reference_lines" ]]; then
      fail "$reference has $reference_lines lines; split oversized reference guidance"
    fi
  done < <(find "$skill_dir/references" -type f -name '*.md' | sort)
done

[[ "$skill_count" -gt 0 ]] || fail "no skills found"

ruby - <<'RUBY'
require "set"

def normalized_heading(value)
  value.downcase.gsub(/[`*_]/, "").gsub(/[^a-z0-9]+/, " ").strip
end

def headings(text)
  text.each_line.each_with_object([]) do |line, result|
    match = line.match(/^(\#{1,6})\s+(.+?)\s*$/)
    next unless match

    result << [match[1].length, normalized_heading(match[2])]
  end
end

def required_sections(skill_name, contract, output)
  contract_lines = contract.lines

  if skill_name == "canvas-engine-auditor"
    required = []
    collecting = false
    contract_lines.each do |line|
      collecting = true if line.match?(/^##\s+Required Output\s*$/i)
      break if collecting && line.match?(/^##\s+/) && !line.match?(/^##\s+Required Output\s*$/i)

      match = line.match(/^\s*\d+\.\s+\*\*(.+?)\*\*/)
      required << normalized_heading(match[1]) if collecting && match
    end
    return required
  end

  if contract.match?(/^##\s+For Implementation\s*$/i) && contract.match?(/^##\s+For Review Or Planning\s*$/i)
    output_title = headings(output).find { |level, _| level == 1 }&.last
    title_indexes = contract_lines.each_index.select { |index| contract_lines[index].match?(/^#\s+(?!.*Output Contract)(.+)$/i) }
    matching_index = title_indexes.find do |index|
      title = normalized_heading(contract_lines[index].sub(/^#\s+/, ""))
      title == output_title
    end

    return [] unless matching_index

    contract_lines[(matching_index + 1)..].to_a.take_while { |line| !line.match?(/^#\s+/) }
      .each_with_object([]) do |line, sections|
        match = line.match(/^##\s+(.+?)\s*$/)
        sections << normalized_heading(match[1]) if match
      end
  else
    ignored = Set.new([
      "required output",
      "required quality fields",
      "severity standards",
      "pass fail criteria",
      "for implementation",
      "for review or planning"
    ])
    headings(contract).each_with_object([]) do |(level, heading), sections|
      next unless level == 2
      next if ignored.include?(heading)

      sections << heading
    end
  end
end

non_finding_skills = Set.new(["pr-draft-generator", "swiftui-project-router"])
errors = []

Dir[".agents/skills/*/references/output-contract.md"].sort.each do |contract_path|
  skill_name = File.basename(File.dirname(File.dirname(contract_path)))
  output_path = "examples/skill-outputs/#{skill_name}-good-output.md"
  next unless File.file?(output_path)

  contract = File.read(contract_path)
  output = File.read(output_path)
  expected = required_sections(skill_name, contract, output).uniq
  actual = headings(output).map(&:last).to_set

  if expected.length < 3
    errors << "#{skill_name} output contract does not expose enough report sections for good-output validation"
    next
  end

  missing_sections = expected.reject { |section| actual.include?(section) }
  unless missing_sections.empty?
    errors << "#{skill_name} good output omits contract sections: #{missing_sections.join(", ")}"
  end

  universal_fields = {
    "evidence" => /\bevidence\b/i,
    "verification" => /\bverification\b/i,
    "confidence" => /\bconfidence\b/i,
    "missing evidence" => /\bmissing\s+evidence\b/i,
    "safety boundary" => /\b(?:safety|privacy|approval|consent|not inspected)\b/i
  }
  universal_fields.each do |label, pattern|
    errors << "#{skill_name} good output lacks #{label}" unless output.match?(pattern)
  end

  requires_severity = contract.match?(/\bseverity\b/i) && !non_finding_skills.include?(skill_name)
  if requires_severity && !output.match?(/\bseverity\b/i)
    errors << "#{skill_name} good output lacks severity for a findings or audit contract"
  end
end

abort("error: #{errors.join("\nerror: ")}") unless errors.empty?
RUBY

echo "Skill lint passed: $skill_count skills checked."
