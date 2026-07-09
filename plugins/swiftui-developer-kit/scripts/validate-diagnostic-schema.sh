#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$repo_root"

if ! bundle check >/dev/null 2>&1; then
  echo "error: JSON Schema validation dependencies are unavailable. Use Ruby 3.3 with Bundler 2.4.22 (install with \`gem install --user-install bundler -v 2.4.22\` and add its bin directory to PATH), then run \`bundle _2.4.22_ config set --local path .bundle && bundle _2.4.22_ install\` from the repository root and retry." >&2
  exit 1
fi

schema="schemas/diagnostic-report.schema.json"
sample="examples/diagnostic-report.sample.json"
invalid_fixtures=(
  schemas/fixtures/diagnostic-report.invalid-breadcrumb-extra.json
  schemas/fixtures/diagnostic-report.invalid-log-level.json
  schemas/fixtures/diagnostic-report.invalid-privacy-review.json
)

bundle exec ruby scripts/validate-json-schema.rb "$schema" "$sample"
bundle exec ruby scripts/validate-json-schema.rb --expect-invalid "$schema" "${invalid_fixtures[@]}"

bundle exec ruby -rjson - "$sample" <<'RUBY'
sample = JSON.parse(File.read(ARGV.fetch(0)))
serialized = JSON.generate(sample)
abort("sample contains a token-shaped value") if serialized.match?(/(api[_-]?key|bearer\s+[a-z0-9._-]{12,}|sk-[a-z0-9]{12,})/i)
RUBY

echo "Diagnostic schema validation passed."
