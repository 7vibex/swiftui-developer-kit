#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'USAGE'
Usage: scripts/build-codex-plugin-package.sh [--output DIR]

Builds a fresh, self-contained Codex plugin package from the canonical
repository sources. The `skills/` directory is the Codex activation source;
the complete `.agents/skills` tree and validation/runtime dependencies are
also included so the package can reproduce the repository validation flow.
The default output is dist/codex-plugin/swiftui-developer-kit.

The output directory must not already exist. To refresh the tracked plugin
artifact, remove only plugins/swiftui-developer-kit and run this command with
--output plugins/swiftui-developer-kit.
USAGE
}

output_dir="dist/codex-plugin/swiftui-developer-kit"

while [[ $# -gt 0 ]]; do
  case "$1" in
    --output)
      [[ $# -ge 2 ]] || { echo "--output requires a directory." >&2; exit 2; }
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
manifest="$repo_root/plugins/swiftui-developer-kit.plugin.json"

[[ -d "$source_dir" ]] || { echo "Missing skills source directory: $source_dir" >&2; exit 1; }
[[ -f "$manifest" ]] || { echo "Missing plugin manifest template: $manifest" >&2; exit 1; }
[[ ! -e "$output_dir" && ! -L "$output_dir" ]] || {
  echo "Target already exists: $output_dir" >&2
  echo "Choose a fresh --output directory for a new plugin package build." >&2
  exit 1
}

output_parent="$(dirname "$output_dir")"
mkdir -p "$output_parent"
output_parent="$(cd "$output_parent" && pwd)"
output_dir="$output_parent/$(basename "$output_dir")"
staging_dir="$(mktemp -d "$output_parent/.swiftui-kit-plugin-package.XXXXXX")"
package_dir="$staging_dir/package"

cleanup() {
  /bin/rm -r "$staging_dir"
}
trap cleanup EXIT

mkdir -p "$package_dir/.codex-plugin" "$package_dir/.agents" "$package_dir/skills"
cp "$manifest" "$package_dir/.codex-plugin/plugin.json"
cp -R "$source_dir" "$package_dir/.agents/skills"
cp -R "$source_dir/." "$package_dir/skills/"

for runtime_dir in .claude .github benchmarks docs examples schemas tests; do
  [[ -d "$repo_root/$runtime_dir" ]] || { echo "Missing runtime directory: $repo_root/$runtime_dir" >&2; exit 1; }
  cp -R "$repo_root/$runtime_dir" "$package_dir/$runtime_dir"
done

mkdir -p "$package_dir/scripts"
for runtime_script in "$repo_root/scripts"/*; do
  [[ -f "$runtime_script" ]] || continue
  case "$(basename "$runtime_script")" in
    build-codex-plugin-package.sh|validate-codex-plugin-package.sh)
      continue
      ;;
  esac
  cp "$runtime_script" "$package_dir/scripts/"
done

for runtime_file in \
  .gitignore \
  AGENTS.md \
  CHANGELOG.md \
  CLAUDE.md \
  CODE_OF_CONDUCT.md \
  CONTRIBUTING.md \
  Gemfile \
  Gemfile.lock \
  LICENSE \
  README.md \
  SECURITY.md; do
  [[ -f "$repo_root/$runtime_file" ]] || { echo "Missing runtime file: $repo_root/$runtime_file" >&2; exit 1; }
  cp "$repo_root/$runtime_file" "$package_dir/$runtime_file"
done

mkdir -p "$package_dir/scanner"
for scanner_file in Package.swift Package.resolved; do
  [[ -f "$repo_root/scanner/$scanner_file" ]] || { echo "Missing scanner file: $repo_root/scanner/$scanner_file" >&2; exit 1; }
  cp "$repo_root/scanner/$scanner_file" "$package_dir/scanner/$scanner_file"
done
for scanner_dir in Fixtures Sources Tests; do
  [[ -d "$repo_root/scanner/$scanner_dir" ]] || { echo "Missing scanner directory: $repo_root/scanner/$scanner_dir" >&2; exit 1; }
  cp -R "$repo_root/scanner/$scanner_dir" "$package_dir/scanner/$scanner_dir"
done

for source_file in "$package_dir/.agents/skills"/*/SKILL.md; do
  [[ -f "$source_file" ]] || { echo "Plugin package is missing a canonical skill source." >&2; exit 1; }
done

while IFS= read -r -d '' markdown_file; do
  ruby -pi -e 'gsub(%r{(?<![A-Za-z0-9_.-])(?:\.\./)+(?=(?:docs|examples|scripts|schemas)/)}) { |path| path.sub(%r{\A\.\./}, "") }' "$markdown_file"
done < <(find "$package_dir/skills" -name '*.md' -type f -print0)

bash "$repo_root/scripts/validate-packaged-skill-closure.sh" \
  --root "$package_dir" \
  --label "Codex plugin package"

mv "$package_dir" "$output_dir"
rmdir "$staging_dir"
trap - EXIT

echo "Generated Codex plugin package in $output_dir"
