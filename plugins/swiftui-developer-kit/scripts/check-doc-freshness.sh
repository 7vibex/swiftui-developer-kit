#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$repo_root"

fail() {
  echo "error: $*" >&2
  exit 1
}

dated_docs=(
  docs/compatibility.md
  docs/sdk-verification.md
  docs/trust-roadmap.md
  docs/openai-codex-doc-links.md
  docs/apple-api-inventory.md
)

for file in "${dated_docs[@]}"; do
  [[ -f "$file" ]] || fail "missing freshness-tracked document: $file"
  verified="$(sed -nE 's/^(Last verified|Last updated): ([0-9]{4}-[0-9]{2}-[0-9]{2})$/\2/p' "$file" | head -n 1)"
  [[ -n "$verified" ]] || fail "$file lacks a YYYY-MM-DD verification date"
  ruby -rdate -e 'checked=Date.parse(ARGV.fetch(0)); now=Date.today; abort("future verification date") if checked > now; abort("verification older than 180 days") if (now-checked).to_i > 180' "$verified" || fail "$file has a stale or invalid verification date"
done

required_codex_links=(
  'https://developers.openai.com/codex/skills/'
  'https://developers.openai.com/codex/plugins/build/'
  'https://developers.openai.com/codex/agent-configuration/agents-md/'
  'https://developers.openai.com/codex/agent-approvals-security/'
  'https://developers.openai.com/codex/learn/best-practices/'
  'https://developers.openai.com/codex/appshots/'
  'https://developers.openai.com/codex/app/computer-use/'
)

for link in "${required_codex_links[@]}"; do
  grep -Fq "$link" docs/openai-codex-doc-links.md || fail "missing exact Codex documentation link: $link"
done

unfinished_pattern='\b(T[B]D|T[O]DO|F[I]XME|place[h]older)\b'
scan_paths=(README.md AGENTS.md CONTRIBUTING.md docs .agents examples scripts)
for optional_path in schemas benchmarks scanner plugins; do
  [[ ! -e "$optional_path" ]] || scan_paths+=("$optional_path")
done

if rg -n --glob '!validate-skills.sh' --glob '!check-doc-freshness.sh' "$unfinished_pattern" "${scan_paths[@]}"; then
  fail "unfinished-content marker found"
fi

echo "Documentation freshness checks passed: ${#dated_docs[@]} dated documents."
