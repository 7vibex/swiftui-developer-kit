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

echo "Skill lint passed: $skill_count skills checked."
