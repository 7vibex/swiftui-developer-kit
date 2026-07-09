#!/usr/bin/env bash
set -euo pipefail

screenshots_dir="${1:-swiftui-developer-kit-audit/screenshots}"
inventory="${2:-$screenshots_dir/inventory.md}"

mkdir -p "$screenshots_dir"

{
  echo "# Screenshot Inventory"
  echo
  echo "| File | Screen | Notes |"
  echo "| --- | --- | --- |"
  find "$screenshots_dir" -maxdepth 1 -type f \( -name "*.png" -o -name "*.jpg" -o -name "*.jpeg" \) -print | sort |
  while IFS= read -r file; do
    name="$(basename "$file")"
    echo "| $name |  |  |"
  done
} > "$inventory"

echo "$inventory"
