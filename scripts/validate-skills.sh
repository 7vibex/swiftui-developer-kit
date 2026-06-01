#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$repo_root"

fail() {
  echo "error: $*" >&2
  exit 1
}

require_file() {
  [[ -f "$1" ]] || fail "missing required file: $1"
}

require_dir() {
  [[ -d "$1" ]] || fail "missing required directory: $1"
}

require_file README.md
require_file AGENTS.md
require_file CONTRIBUTING.md
require_file CODE_OF_CONDUCT.md
require_file LICENSE
require_dir .agents/skills
require_dir docs
require_dir examples

skill_count=0

for skill_dir in .agents/skills/*; do
  [[ -d "$skill_dir" ]] || continue
  skill_count=$((skill_count + 1))
  skill_name="$(basename "$skill_dir")"
  skill_file="$skill_dir/SKILL.md"

  require_file "$skill_file"

  ruby - "$skill_file" <<'RUBY'
require "yaml"

path = ARGV.fetch(0)
content = File.read(path)
match = content.match(/\A---\n(.*?)\n---\n/m)
abort("error: missing YAML frontmatter in #{path}") unless match

frontmatter = YAML.safe_load(match[1])
unless frontmatter.is_a?(Hash)
  abort("error: frontmatter is not a map in #{path}")
end

keys = frontmatter.keys.sort
unless keys == ["description", "name"]
  abort("error: frontmatter must contain only description and name in #{path}; got #{keys.inspect}")
end

if frontmatter["name"].to_s.strip.empty?
  abort("error: empty skill name in #{path}")
end

if frontmatter["description"].to_s.strip.empty?
  abort("error: empty skill description in #{path}")
end

body = content.sub(/\A---\n.*?\n---\n/m, "").strip
if body.length < 300
  abort("error: skill body is too thin in #{path}")
end
RUBY

  if [[ "$skill_name" != "swiftui-project-router" ]]; then
    require_dir "$skill_dir/references"
    require_file "$skill_dir/references/output-contract.md"
  fi

  grep -q "$skill_name" README.md || fail "README does not mention $skill_name"
  grep -q "$skill_name" docs/skill-index.md || fail "docs/skill-index.md does not mention $skill_name"
done

[[ "$skill_count" -eq 11 ]] || fail "expected 11 skills, found $skill_count"

while IFS= read -r script; do
  head -n 1 "$script" | grep -qx '#!/usr/bin/env bash' || fail "$script missing bash shebang"
  sed -n '2p' "$script" | grep -qx 'set -euo pipefail' || fail "$script missing set -euo pipefail"
  bash -n "$script"
done < <(find .agents/skills scripts -name "*.sh" -type f | sort)

if grep -RInE --exclude validate-skills.sh '\b(rm -rf|git reset|git checkout --|simctl boot|simctl launch|xcodebuild .* clean|xcodebuild .* build|open -a)\b' .agents/skills scripts; then
  fail "potentially destructive or side-effectful script command found"
fi

grep -q -- "--approved" .agents/skills/liquid-glass-placement-auditor/scripts/capture-simulator-screenshot.sh || fail "Liquid Glass screenshot script lacks approval flag"
grep -q -- "--approved" .agents/skills/simulator-screenshot-reviewer/scripts/capture-simulator-screenshot.sh || fail "Simulator screenshot script lacks approval flag"
grep -q "Do not capture" .agents/skills/liquid-glass-placement-auditor/SKILL.md || fail "Liquid Glass skill lacks capture consent language"
grep -q "Do not capture" .agents/skills/simulator-screenshot-reviewer/SKILL.md || fail "Screenshot skill lacks capture consent language"

for example in \
  studyos-liquid-glass-audit.md \
  simulator-screenshot-review-example.md \
  swiftui-architecture-audit-example.md \
  swiftdata-audit-example.md \
  accessibility-audit-example.md \
  appstore-release-review-example.md \
  xcode-build-debug-example.md \
  test-coverage-plan-example.md \
  pr-summary-example.md \
  full-project-router-example.md; do
  require_file "examples/$example"
done

grep -q "developer.apple.com" docs/apple-doc-links.md || fail "Apple docs file lacks official Apple links"
grep -q "developers.openai.com" docs/openai-codex-doc-links.md || fail "OpenAI docs file lacks official OpenAI links"

if grep -RInE --exclude validate-skills.sh '\b(TBD|TODO|FIXME|placeholder)\b' README.md AGENTS.md CONTRIBUTING.md docs .agents examples scripts; then
  fail "placeholder text found"
fi

echo "Validated $skill_count skills, shell scripts, docs, and examples."
