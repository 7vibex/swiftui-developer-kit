#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$repo_root"

fail() {
  echo "behavior check failed: $*" >&2
  exit 1
}

require_contains() {
  local file="$1"
  local pattern="$2"
  grep -q "$pattern" "$file" || fail "$file does not contain $pattern"
}

router=".agents/skills/swiftui-project-router/SKILL.md"
commands="docs/commands.md"

[[ -f "$router" ]] || fail "missing router skill"
[[ -f "$commands" ]] || fail "missing command docs"

for command in audit fix-build review-screenshots prepare-release modernize-ui improve-tests draft-pr detect-risks; do
  require_contains "$router" "$command"
  require_contains "$commands" "$command"
done

require_contains "$router" "Do not claim to automatically call another skill"
require_contains "$router" "Selected Command"
require_contains "$commands" "scripts/swiftui-kit.sh detect"

echo "Behavior checks passed."
