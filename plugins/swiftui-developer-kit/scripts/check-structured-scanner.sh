#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$repo_root"

fail() {
  echo "error: $*" >&2
  exit 1
}

required_files=(
  scanner/Package.swift
  scanner/Sources/SwiftUIScannerCore/Models.swift
  scanner/Sources/SwiftUIScannerCore/Scanner.swift
  scanner/Sources/SwiftUIScannerCLI/main.swift
  scanner/Tests/SwiftUIScannerCoreTests/ScannerTests.swift
  scanner/Fixtures/Positive.swift
  scanner/Fixtures/Negative.swift
  scanner/Fixtures/Suppressed.swift
  scanner/Fixtures/baseline.json
  schemas/scanner-output.schema.json
  scripts/validate-json-schema.rb
)

for file in "${required_files[@]}"; do
  [[ -s "$file" ]] || fail "missing structured scanner file: $file"
done

grep -Fq 'swift-syntax.git' scanner/Package.swift || fail "scanner package lacks official SwiftSyntax dependency"
grep -Fq '603.0.0' scanner/Package.swift || fail "scanner package is not pinned to the Swift 6.3 line"

rule_count="$(rg -o 'ruleID: "[a-z0-9-]+"' scanner/Sources/SwiftUIScannerCore/Scanner.swift | sort -u | wc -l | tr -d ' ')"
[[ "$rule_count" -ge 10 ]] || fail "structured scanner has only $rule_count rules"

ruby -rjson - schemas/scanner-output.schema.json scanner/Fixtures/baseline.json <<'RUBY'
schema = JSON.parse(File.read(ARGV.fetch(0)))
baseline = JSON.parse(File.read(ARGV.fetch(1)))
abort("scanner schema must be an object") unless schema["type"] == "object"
%w[schema_version scanner_version scanned_files findings].each do |field|
  abort("scanner schema missing #{field}") unless schema.fetch("required").include?(field)
end
abort("baseline schema version mismatch") unless baseline["schema_version"] == "2.0.0"
abort("baseline fingerprints must be an array") unless baseline["fingerprints"].is_a?(Array)
abort("baseline fingerprints must be unique and sorted") unless baseline["fingerprints"] == baseline["fingerprints"].uniq.sort
abort("baseline contains an invalid fingerprint") unless baseline["fingerprints"].all? { |fingerprint| fingerprint.match?(/\A[0-9a-f]{16}\z/) }
RUBY

grep -Fq 'swiftui-kit:disable' scanner/Fixtures/Suppressed.swift || fail "scanner suppression fixture lacks marker"
grep -Fq -- '--baseline' scanner/Sources/SwiftUIScannerCLI/main.swift || fail "scanner CLI lacks baseline support"
grep -Fq -- '--ci' scanner/Sources/SwiftUIScannerCLI/main.swift || fail "scanner CLI lacks CI mode"
grep -Fq 'String(line)' scanner/Sources/SwiftUIScannerCore/Models.swift || fail "scanner fingerprints do not include line granularity"
grep -Fq 'String(column)' scanner/Sources/SwiftUIScannerCore/Models.swift || fail "scanner fingerprints do not include column granularity"
grep -Fq 'testRepeatedFindingsAtDifferentLocationsHaveDistinctFingerprints' scanner/Tests/SwiftUIScannerCoreTests/ScannerTests.swift || fail "scanner lacks repeated-finding fingerprint regression coverage"
grep -Fq 'testLegacyBaselineSchemaIsRejectedWithRegenerationGuidance' scanner/Tests/SwiftUIScannerCoreTests/ScannerTests.swift || fail "scanner lacks legacy baseline migration coverage"

echo "Structured scanner checks passed: $rule_count rules."
