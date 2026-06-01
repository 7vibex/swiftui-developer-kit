#!/usr/bin/env bash
set -euo pipefail

root="${1:-.}"

find "$root" \
  \( -path "*/.git/*" -o -path "*/.build/*" -o -path "*/DerivedData/*" -o -path "*/Pods/*" -o -path "*/Carthage/*" \) -prune \
  -o -name "*.swift" -type f -print |
while IFS= read -r file; do
  if grep -Eq 'import SwiftData|@Model|ModelContext|@Query|FetchDescriptor' "$file"; then
    echo "$file"
  fi
done
