#!/usr/bin/env bash
set -euo pipefail

if [[ $# -lt 3 || "${3:-}" != "--approved" ]]; then
  echo "Usage: $0 <output-dir> <screenshot-name> --approved" >&2
  echo "Refusing to capture without explicit user approval." >&2
  exit 2
fi

output_dir="$1"
screenshot_name="$2"

if ! command -v xcrun >/dev/null 2>&1; then
  echo "xcrun not found. Install Xcode command line tools." >&2
  exit 1
fi

if ! xcrun simctl list devices booted | grep -q "(Booted)"; then
  echo "No booted Simulator found." >&2
  exit 1
fi

mkdir -p "$output_dir"
output_path="${output_dir%/}/$screenshot_name"

xcrun simctl io booted screenshot "$output_path"
echo "$output_path"
