#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'USAGE'
Usage: scripts/install-local.sh [--copy] [--target DIR]

Installs all skills from .agents/skills into the local Codex skills directory.

Default target:
  ${CODEX_HOME:-$HOME/.codex}/skills

Default mode:
  symlink each skill folder so git pulls update the installed skills.

Options:
  --copy        Copy skill folders instead of creating symlinks.
  --target DIR Install into a specific skills directory.
  -h, --help    Show this help.

This script is non-destructive. If a target skill already exists, it is skipped.
USAGE
}

mode="symlink"
target_dir="${CODEX_HOME:-$HOME/.codex}/skills"

while [[ $# -gt 0 ]]; do
  case "$1" in
    --copy)
      mode="copy"
      shift
      ;;
    --target)
      if [[ $# -lt 2 ]]; then
        echo "--target requires a directory." >&2
        exit 2
      fi
      target_dir="$2"
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

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
repo_root="$(cd "$script_dir/.." && pwd)"
source_dir="$repo_root/.agents/skills"

if [[ ! -d "$source_dir" ]]; then
  echo "Could not find skills directory: $source_dir" >&2
  exit 1
fi

mkdir -p "$target_dir"

installed=0
skipped=0

for skill_dir in "$source_dir"/*; do
  [[ -d "$skill_dir" ]] || continue
  name="$(basename "$skill_dir")"
  target="$target_dir/$name"

  if [[ -e "$target" || -L "$target" ]]; then
    echo "skip: $name already exists at $target"
    skipped=$((skipped + 1))
    continue
  fi

  if [[ "$mode" == "copy" ]]; then
    cp -R "$skill_dir" "$target"
    echo "copy: $name -> $target"
  else
    ln -s "$skill_dir" "$target"
    echo "link: $name -> $target"
  fi
  installed=$((installed + 1))
done

echo
echo "Installed: $installed"
echo "Skipped: $skipped"
echo "Target: $target_dir"
echo
echo "Restart Codex, then prompt with a skill name such as:"
echo "Use the swiftui-project-router skill. I want to audit my SwiftUI app."
