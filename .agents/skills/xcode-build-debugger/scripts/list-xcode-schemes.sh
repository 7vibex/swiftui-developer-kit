#!/usr/bin/env bash
set -euo pipefail

target="${1:-}"

if ! command -v xcodebuild >/dev/null 2>&1; then
  echo "xcodebuild not found." >&2
  exit 1
fi

if [[ -n "$target" ]]; then
  case "$target" in
    *.xcworkspace) xcodebuild -list -workspace "$target" ;;
    *.xcodeproj) xcodebuild -list -project "$target" ;;
    *) echo "Provide a .xcworkspace or .xcodeproj path." >&2; exit 2 ;;
  esac
  exit 0
fi

workspace="$(find . -maxdepth 3 -name "*.xcworkspace" -type d | sort | head -n 1)"
project="$(find . -maxdepth 3 -name "*.xcodeproj" -type d | sort | head -n 1)"

if [[ -n "$workspace" ]]; then
  xcodebuild -list -workspace "$workspace"
elif [[ -n "$project" ]]; then
  xcodebuild -list -project "$project"
else
  echo "No .xcworkspace or .xcodeproj found." >&2
  exit 1
fi
