#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$repo_root"

usage() {
  cat <<'USAGE'
Usage: scripts/swiftui-kit.sh <command> [options]

Commands:
  list       List included skills.
  install    Install skills locally. Passes options to scripts/install-local.sh.
  validate   Run repository validation, including local tests.
  doctor     Check local skill-pack structure without changing files.
  detect     Scan SwiftUI files for deterministic anti-patterns.
  bundle     Generate provider install bundles.
  help       Show this help.
USAGE
}

command="${1:-help}"
if [[ $# -gt 0 ]]; then
  shift
fi

case "$command" in
  help|-h|--help)
    usage
    ;;
  list)
    for skill_file in .agents/skills/*/SKILL.md; do
      [[ -f "$skill_file" ]] || continue
      name="$(awk -F': ' '/^name:/ { print $2; exit }' "$skill_file")"
      description="$(awk -F': ' '/^description:/ { print $2; exit }' "$skill_file")"
      printf '%-34s %s\n' "$name" "$description"
    done
    ;;
  install)
    scripts/install-local.sh "$@"
    ;;
  validate)
    scripts/validate-skills.sh
    ;;
  doctor)
    [[ -d .agents/skills ]] || { echo "missing .agents/skills" >&2; exit 1; }
    [[ -f README.md ]] || { echo "missing README.md" >&2; exit 1; }
    [[ -f docs/skill-index.md ]] || { echo "missing docs/skill-index.md" >&2; exit 1; }
    find scripts .agents/skills -name '*.sh' -type f -print0 | while IFS= read -r -d '' script; do
      bash -n "$script"
    done
    echo "Doctor checks passed."
    ;;
  detect)
    scripts/detect-swiftui-antipatterns.sh "$@"
    ;;
  bundle)
    scripts/build-provider-bundles.sh "$@"
    ;;
  *)
    echo "Unknown command: $command" >&2
    usage >&2
    exit 2
    ;;
esac
