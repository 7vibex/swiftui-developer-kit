#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$repo_root"

fail() {
  echo "error: $*" >&2
  exit 1
}

if grep -qi "standing approval" AGENTS.md; then
  fail "AGENTS.md must not grant broad standing approval for external app build/run workflows"
fi

if grep -qi "build the latest app version before reporting completion" AGENTS.md; then
  fail "AGENTS.md conflicts with approval-first build guidance"
fi

if grep -qi "run the latest build in Simulator" AGENTS.md; then
  fail "AGENTS.md conflicts with approval-first Simulator launch guidance"
fi

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
