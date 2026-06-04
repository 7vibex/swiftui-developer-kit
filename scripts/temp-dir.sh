#!/usr/bin/env bash
set -euo pipefail

swiftui_kit_mktemp_dir() {
  local repo_root="$1"
  local prefix="$2"
  local parent=""
  local temp_dir=""

  if [[ -n "${TMPDIR:-}" && -d "${TMPDIR:-}" && -w "${TMPDIR:-}" ]]; then
    parent="${TMPDIR%/}"
    if temp_dir="$(mktemp -d "$parent/$prefix.XXXXXX" 2>/dev/null)"; then
      printf '%s\n' "$temp_dir"
      return 0
    fi
  fi

  parent="$repo_root/.tmp"
  mkdir -p "$parent"
  temp_dir="$(mktemp -d "$parent/$prefix.XXXXXX")"
  printf '%s\n' "$temp_dir"
}
