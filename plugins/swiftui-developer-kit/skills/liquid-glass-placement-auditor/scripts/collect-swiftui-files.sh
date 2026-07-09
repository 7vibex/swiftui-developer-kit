#!/usr/bin/env bash
set -euo pipefail

root="${1:-.}"

find "$root" \
  \( -path "*/.git/*" -o -path "*/.build/*" -o -path "*/DerivedData/*" -o -path "*/Pods/*" -o -path "*/Carthage/*" \) -prune \
  -o -name "*.swift" -type f -print |
while IFS= read -r file; do
  if grep -Eq 'import SwiftUI|NavigationStack|NavigationSplitView|TabView|\.toolbar|\.sheet|\.popover|\.inspector|safeAreaInset|@State|@Binding|@Observable|@Environment' "$file"; then
    echo "$file"
  fi
done
