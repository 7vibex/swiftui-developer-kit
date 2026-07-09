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

if [[ -e "$output_dir" || -L "$output_dir" ]]; then
  echo "Target already exists: $output_dir" >&2
  echo "Choose a fresh --output directory for a new bundle build." >&2
  exit 1
fi

output_parent="$(dirname "$output_dir")"
mkdir -p "$output_parent"
output_parent="$(cd "$output_parent" && pwd)"
output_dir="$output_parent/$(basename "$output_dir")"
staging_dir="$(mktemp -d "$output_parent/.swiftui-kit-provider-bundle.XXXXXX")"
bundle_dir="$staging_dir/bundle"

cleanup() {
  /bin/rm -r "$staging_dir"
}
trap cleanup EXIT

mkdir -p "$bundle_dir"

providers=(.agents .claude .cursor .gemini .github .opencode)

for shared_dir in docs examples scripts schemas; do
  [[ -d "$repo_root/$shared_dir" ]] || {
    echo "Missing shared bundle directory: $repo_root/$shared_dir" >&2
    exit 1
  }
  cp -R "$repo_root/$shared_dir" "$bundle_dir/$shared_dir"
done

for shared_file in Gemfile Gemfile.lock; do
  [[ -f "$repo_root/$shared_file" ]] || continue
  cp "$repo_root/$shared_file" "$bundle_dir/$shared_file"
done

for provider in "${providers[@]}"; do
  provider_root="$bundle_dir/$provider"
  target="$provider_root/skills"
  mkdir -p "$target"
  cp -R "$source_dir/." "$target/"
  echo "bundle: $provider -> $output_dir/$provider/skills"
done

if [[ -f "$repo_root/CLAUDE.md" ]]; then
  cp "$repo_root/CLAUDE.md" "$bundle_dir/.claude/CLAUDE.md"
fi

if [[ -d "$repo_root/.claude/commands" ]]; then
  mkdir -p "$bundle_dir/.claude/commands"
  cp -R "$repo_root/.claude/commands/." "$bundle_dir/.claude/commands/"
fi

bash "$repo_root/scripts/validate-packaged-skill-closure.sh" \
  --root "$bundle_dir" \
  --label "provider bundles"

mv "$bundle_dir" "$output_dir"
rmdir "$staging_dir"
trap - EXIT

echo "Generated provider bundles in $output_dir"
