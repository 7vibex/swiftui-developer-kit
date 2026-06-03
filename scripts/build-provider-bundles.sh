#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'USAGE'
Usage: scripts/build-provider-bundles.sh [--output DIR]

Generates read-only provider install bundles from .agents/skills.
Default output is dist/providers.

Generated bundles:
  .agents/skills   Codex and generic agents
  .claude/skills   Claude Code
  .cursor/skills   Cursor
  .gemini/skills   Gemini CLI
  .github/skills   GitHub Copilot
  .opencode/skills OpenCode

Options:
  --output DIR  Output directory.
  -h, --help    Show this help.
USAGE
}

output_dir="dist/providers"

while [[ $# -gt 0 ]]; do
  case "$1" in
    --output)
      if [[ $# -lt 2 ]]; then
        echo "--output requires a directory." >&2
        exit 2
      fi
      output_dir="$2"
      shift 2
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "Unknown option: $1" >&2
      usage >&2
      exit 2
      ;;
  esac
done

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source_dir="$repo_root/.agents/skills"

if [[ ! -d "$source_dir" ]]; then
  echo "Missing skills source directory: $source_dir" >&2
  exit 1
fi

mkdir -p "$output_dir"

providers=(.agents .claude .cursor .gemini .github .opencode)

for provider in "${providers[@]}"; do
  target="$output_dir/$provider/skills"
  mkdir -p "$target"
  for skill_dir in "$source_dir"/*; do
    [[ -d "$skill_dir" ]] || continue
    name="$(basename "$skill_dir")"
    skill_target="$target/$name"
    if [[ -e "$skill_target" || -L "$skill_target" ]]; then
      echo "Target already exists: $skill_target" >&2
      echo "Choose a fresh --output directory for a new bundle build." >&2
      exit 1
    fi
    cp -R "$skill_dir" "$skill_target"
  done
  echo "bundle: $provider -> $target"
done

echo "Generated provider bundles in $output_dir"
