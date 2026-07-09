#!/usr/bin/env bash
set -euo pipefail

# This check is intentionally separate from the deterministic repository gate.
# Run it from the scheduled CI job to catch retired or redirected official
# OpenAI documentation URLs without making pull requests depend on the network.

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$repo_root"

command -v curl >/dev/null 2>&1 || {
  echo "error: missing required command: curl" >&2
  exit 1
}

urls_file="docs/openai-codex-doc-links.md"
[[ -f "$urls_file" ]] || {
  echo "error: missing official documentation link inventory: $urls_file" >&2
  exit 1
}

checked=0
failed=0

while IFS= read -r url; do
  [[ -n "$url" ]] || continue
  checked=$((checked + 1))

  if response="$(curl --fail --silent --show-error --location --max-redirs 8 --connect-timeout 10 --max-time 30 --retry 2 --retry-delay 1 --output /dev/null --write-out '%{http_code} %{url_effective}' "$url")"; then
    status_code="${response%% *}"
    final_url="${response#* }"
    case "$final_url" in
      https://developers.openai.com/*|https://learn.chatgpt.com/*)
        ;;
      *)
        printf 'error: official documentation link redirected outside the approved OpenAI documentation hosts: %s -> %s\n' "$url" "$final_url" >&2
        failed=$((failed + 1))
        continue
        ;;
    esac

    if [[ "$final_url" == "$url" ]]; then
      printf 'ok: %s (%s)\n' "$url" "$status_code"
    else
      printf 'redirect: %s -> %s (%s)\n' "$url" "$final_url" "$status_code"
    fi
  else
    printf 'error: official documentation link failed: %s\n' "$url" >&2
    failed=$((failed + 1))
  fi
done < <(rg --no-filename -oN 'https://developers\.openai\.com/[^<>()[:space:]]+' "$urls_file" | sort -u)

[[ "$checked" -gt 0 ]] || {
  echo "error: no official OpenAI documentation links found in $urls_file" >&2
  exit 1
}

[[ "$failed" -eq 0 ]] || exit 1
echo "Official documentation link checks passed: $checked URLs followed."
