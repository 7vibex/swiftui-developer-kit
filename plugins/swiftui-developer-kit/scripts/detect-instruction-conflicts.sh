#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$repo_root"

fail() {
  echo "error: $*" >&2
  exit 1
}

ruby - <<'RUBY'
paths = ["AGENTS.md", *Dir[".agents/skills/**/*.md"].sort]
approval_terms = /\b(?:approv(?:al|ed)|confirm(?:ation|ed)?|consent|permission|explicit(?:ly)?\s+(?:user\s+)?request(?:ed)?|user\s+(?:has\s+)?request(?:ed)?|host\s+(?:project|repository))\b/i
action_terms = /\b(?:build(?:\/run|\s+and\s+run)?|run|launch|boot)\b/i
app_context = /\b(?:app|application|project|simulator|device|xcodebuild)\b/i
requirement_terms = /\b(?:must|always|required|expected)\b|after\s+(?:every\s+)?code\s+changes?|before\s+(?:reporting\s+)?completion/i

violations = []

paths.each do |path|
  File.foreach(path).with_index(1) do |line, line_number|
    next unless line.match?(action_terms)
    next unless line.match?(app_context) || line.match?(/build\s*\/\s*run/i)
    next unless line.match?(requirement_terms)
    next if line.match?(approval_terms)
    next if line.match?(/\bdo not\b/i)

    violations << "#{path}:#{line_number}: unconditional Apple app build/run/launch requirement: #{line.strip}"
  end
end

if File.read("AGENTS.md").match?(/standing\s+approval/i)
  violations << "AGENTS.md: broad standing approval is not allowed for external app build/run workflows"
end

abort("error: #{violations.join("\nerror: ")}") unless violations.empty?
RUBY

auto_invoke_matches="$(
  rg -n -i "automatically invokes?|automatically calls?" README.md docs .agents/skills \
    | rg -v -i "do not|does not|instead of claiming|without claiming|not claim" || true
)"
if [[ -n "$auto_invoke_matches" ]]; then
  printf '%s\n' "$auto_invoke_matches" >&2
  fail "found claims that skills automatically invoke or call other skills"
fi

while IFS= read -r script; do
  grep -q -- "--approved" "$script" || fail "$script captures screenshots without an approval flag"
done < <(
  find .agents/skills scripts -name "*.sh" -type f -print0 |
    xargs -0 rg -l "simctl io .*screenshot|screencapture" || true
)

echo "Instruction conflict checks passed."
