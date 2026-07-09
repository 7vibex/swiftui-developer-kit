#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'USAGE'
Usage: scripts/install-local.sh [--copy] [--refresh] [--target DIR]

Installs all skills from .agents/skills into the local Codex user skills directory.

Default target:
  $HOME/.agents/skills

Default mode:
  symlink each skill folder so git pulls update the installed skills.

Options:
  --copy        Copy skill folders instead of creating symlinks.
  --refresh     Replace existing skill entries safely.
  --target DIR  Install into a specific skills directory.
  -h, --help    Show this help.

By default, this script is non-destructive. If a target skill already exists,
it is skipped.

With --refresh, existing symlinks are unlinked and recreated. Existing files or
directories are moved to a backup path next to the target before replacement.
USAGE
}

mode="symlink"
refresh=0
target_dir="$HOME/.agents/skills"

while [[ $# -gt 0 ]]; do
  case "$1" in
    --copy)
      mode="copy"
      shift
      ;;
    --refresh)
      refresh=1
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

resolved_source_dir="$(cd "$source_dir" && pwd)"
resolved_target_dir="$(cd "$target_dir" && pwd)"

if [[ "$resolved_target_dir" == "$resolved_source_dir" ]]; then
  echo "Refusing to install into the source skills directory: $source_dir" >&2
  exit 1
fi

installed=0
refreshed=0
skipped=0
backed_up=0

backup_existing_target() {
  local target="$1"
  local backup_base="$target.backup-$(date +%Y%m%d%H%M%S)"
  local backup="$backup_base"
  local counter=1

  while [[ -e "$backup" || -L "$backup" ]]; do
    backup="$backup_base-$counter"
    counter=$((counter + 1))
  done

  mv "$target" "$backup"
  echo "$backup"
}

for skill_dir in "$source_dir"/*; do
  [[ -d "$skill_dir" ]] || continue
  name="$(basename "$skill_dir")"
  target="$target_dir/$name"

  if [[ -e "$target" || -L "$target" ]]; then
    if [[ "$refresh" != "1" ]]; then
      echo "skip: $name already exists at $target"
      skipped=$((skipped + 1))
      continue
    fi

    if [[ -L "$target" ]]; then
      unlink "$target"
      echo "refresh-link: $name"
    else
      backup_path="$(backup_existing_target "$target")"
      echo "backup: $name -> $backup_path"
      backed_up=$((backed_up + 1))
    fi
    refreshed=$((refreshed + 1))
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
echo "Refreshed: $refreshed"
echo "Skipped: $skipped"
echo "Backed up: $backed_up"
echo "Target: $target_dir"
echo
echo "Restart Codex, then prompt with a skill name such as:"
echo "Use the swiftui-project-router skill. I want to audit my SwiftUI app."
