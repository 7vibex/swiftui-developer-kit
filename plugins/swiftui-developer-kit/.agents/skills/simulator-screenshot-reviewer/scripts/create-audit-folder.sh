#!/usr/bin/env bash
set -euo pipefail

root="${1:-swiftui-developer-kit-audit}"

mkdir -p "$root/screenshots" "$root/reports" "$root/notes"

inventory="$root/screenshots/inventory.md"
if [[ ! -f "$inventory" ]]; then
  {
    echo "# Screenshot Inventory"
    echo
    echo "| File | Screen | Notes |"
    echo "| --- | --- | --- |"
  } > "$inventory"
fi

echo "$root"
