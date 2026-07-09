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

require_command() {
  command -v "$1" >/dev/null 2>&1 || fail "missing required command: $1"
}

require_command rg

require_file README.md
require_file AGENTS.md
require_file CLAUDE.md
require_file CONTRIBUTING.md
require_file CODE_OF_CONDUCT.md
require_file LICENSE
require_file SECURITY.md
require_file CHANGELOG.md
require_file .github/pull_request_template.md
require_file .github/ISSUE_TEMPLATE/bug_report.yml
require_file .github/ISSUE_TEMPLATE/docs_bug.yml
require_file .github/ISSUE_TEMPLATE/scanner_rule.yml
require_file .github/ISSUE_TEMPLATE/skill_improvement.yml
require_file docs/claude-code-usage.md
require_file docs/commands.md
require_file docs/demo-roadmap.md
require_file docs/demo-site/index.html
require_file docs/detector-roadmap.md
require_file docs/threat-model.md
require_file docs/compatibility.md
require_file docs/sdk-verification.md
require_file docs/skill-quality-standard.md
require_file docs/trust-roadmap.md
require_file docs/issue-backlog.md
require_file docs/releases/v0.3.0.md
require_file docs/releases/v0.4.0.md
require_file docs/releases/v0.5.0.md
require_file docs/releases/v0.6.0.md
require_file docs/releases/v1.0.0.md
require_file scripts/check-links.sh
require_file scripts/check-doc-freshness.sh
require_file scripts/check-apple-api-inventory.sh
require_file scripts/validate-diagnostic-schema.sh
require_file scripts/validate-benchmarks.sh
require_file scripts/check-structured-scanner.sh
require_file scripts/run-structured-scanner.sh
require_file schemas/scanner-output.schema.json
require_file benchmarks/rubric.json
require_file benchmarks/results.json
require_file schemas/diagnostic-report.schema.json
require_file examples/diagnostic-report.sample.json
require_file scripts/detect-instruction-conflicts.sh
require_file scripts/lint-skills.sh
require_dir .agents/skills
require_dir docs
require_dir examples
require_dir tests

required_skills=(
  accessibility-auditor
  appstore-release-reviewer
  canvas-engine-auditor
  liquid-glass-placement-auditor
  pr-draft-generator
  simulator-screenshot-reviewer
  swiftdata-persistence-auditor
  swiftui-architecture-auditor
  swiftui-diagnostics-builder
  swiftui-design-system-auditor
  swiftui-feature-builder
  swiftui-project-router
  swiftui-ui-patterns
  test-coverage-improver
  xcode-build-debugger
)

for skill_name in "${required_skills[@]}"; do
  require_file ".agents/skills/$skill_name/SKILL.md"
done

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

expected_skill_count="${#required_skills[@]}"
[[ "$skill_count" -eq "$expected_skill_count" ]] || fail "expected $expected_skill_count skills, found $skill_count"

while IFS= read -r script; do
  head -n 1 "$script" | grep -qx '#!/usr/bin/env bash' || fail "$script missing bash shebang"
  sed -n '2p' "$script" | grep -qx 'set -euo pipefail' || fail "$script missing set -euo pipefail"
  bash -n "$script"
done < <(find .agents/skills scripts tests -name "*.sh" -type f | sort)

if grep -RInE --exclude validate-skills.sh '\b(rm -rf|git reset|git checkout --|simctl boot|simctl launch|xcodebuild .* clean|xcodebuild .* build|open -a)\b' .agents/skills scripts; then
  fail "potentially destructive or side-effectful script command found"
fi

grep -q -- "--approved" .agents/skills/liquid-glass-placement-auditor/scripts/capture-simulator-screenshot.sh || fail "Liquid Glass screenshot script lacks approval flag"
grep -q -- "--approved" .agents/skills/simulator-screenshot-reviewer/scripts/capture-simulator-screenshot.sh || fail "Simulator screenshot script lacks approval flag"
grep -q "Do not capture" .agents/skills/liquid-glass-placement-auditor/SKILL.md || fail "Liquid Glass skill lacks capture consent language"
grep -q "Do not capture" .agents/skills/simulator-screenshot-reviewer/SKILL.md || fail "Screenshot skill lacks capture consent language"

for example in \
  studyos-liquid-glass-audit.md \
  studyos-liquid-glass-before-after.md \
  studyos-screenshot-inventory.md \
  studyos-swiftui-code-findings.md \
  full-studyos-design-audit.md \
  simulator-screenshot-review-example.md \
  claude-prompts.md \
  swiftui-ui-patterns-example.md \
  swiftui-architecture-audit-example.md \
  swiftdata-audit-example.md \
  accessibility-audit-example.md \
  appstore-release-review-example.md \
  canvas-engine-auditor-example.md \
  xcode-build-debug-example.md \
  detect-risks-example.md \
  swiftui-diagnostics-example.md \
  test-coverage-plan-example.md \
  pr-summary-example.md \
  full-project-router-example.md; do
  require_file "examples/$example"
done

grep -q "developer.apple.com" docs/apple-doc-links.md || fail "Apple docs file lacks official Apple links"
grep -q "developers.openai.com" docs/openai-codex-doc-links.md || fail "OpenAI docs file lacks official OpenAI links"
grep -q "detect-risks" docs/commands.md || fail "Command docs lack detect-risks"
grep -q "diagnostics" docs/commands.md || fail "Command docs lack diagnostics"
grep -q "canvas-audit" docs/commands.md || fail "Command docs lack canvas-audit"
grep -q "review-screenshots" .agents/skills/swiftui-project-router/SKILL.md || fail "Router lacks command vocabulary"
grep -q "canvas-engine-auditor" CLAUDE.md || fail "CLAUDE.md lacks canvas-engine-auditor prompt"
grep -q "swiftui-design-system-auditor" README.md || fail "README lacks design-system auditor"
grep -q "swiftui-design-system-auditor" CLAUDE.md || fail "CLAUDE.md lacks design-system auditor prompt"
grep -q "Do not capture" SECURITY.md || fail "SECURITY.md lacks capture safety language"
grep -q "Pass / Fail Criteria" .agents/skills/liquid-glass-placement-auditor/references/output-contract.md || fail "Liquid Glass output contract lacks pass/fail criteria"
grep -q "implementation-recipes.md" .agents/skills/liquid-glass-placement-auditor/SKILL.md || fail "Liquid Glass skill lacks implementation recipe reference"
grep -q "platform-version-matrix.md" .agents/skills/liquid-glass-placement-auditor/SKILL.md || fail "Liquid Glass skill lacks platform version matrix reference"
grep -q "API Verification Required" .agents/skills/liquid-glass-placement-auditor/references/swiftui-liquid-glass-recipes.md || fail "Liquid Glass recipes lack API verification workflow"
grep -qi "multiple booleans" docs/detector-roadmap.md || fail "Detector roadmap lacks sheet boolean candidate"
grep -q "synthetic audit fixtures" docs/demo-roadmap.md || fail "Demo roadmap lacks public synthetic fixture plan"

if grep -RInE --exclude validate-skills.sh '\b(TBD|TODO|FIXME|placeholder)\b' README.md AGENTS.md CONTRIBUTING.md docs .agents examples scripts; then
  fail "placeholder text found"
fi

scripts/lint-skills.sh
scripts/detect-instruction-conflicts.sh
scripts/check-links.sh
scripts/check-doc-freshness.sh
scripts/check-apple-api-inventory.sh
scripts/validate-diagnostic-schema.sh
scripts/validate-benchmarks.sh
scripts/check-structured-scanner.sh

bash tests/run-tests.sh

echo "Validated $skill_count skills, shell scripts, docs, and examples."
