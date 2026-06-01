#!/usr/bin/env bash
set -euo pipefail

root="${1:-.}"

echo "# Test folders"
find "$root" \
  \( -path "*/.git/*" -o -path "*/.build/*" -o -path "*/DerivedData/*" -o -path "*/Pods/*" -o -path "*/Carthage/*" \) -prune \
  -o -type d \( -name "Tests" -o -name "*Tests" -o -name "*UITests" \) -print | sort

echo
echo "# Swift test files"
find "$root" \
  \( -path "*/.git/*" -o -path "*/.build/*" -o -path "*/DerivedData/*" -o -path "*/Pods/*" -o -path "*/Carthage/*" \) -prune \
  -o -name "*.swift" -type f -print |
while IFS= read -r file; do
  if grep -Eq 'import XCTest|import Testing|XCTestCase|@Test' "$file"; then
    echo "$file"
  fi
done
