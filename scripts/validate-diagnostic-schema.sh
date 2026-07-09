#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$repo_root"

ruby -rjson - schemas/diagnostic-report.schema.json examples/diagnostic-report.sample.json <<'RUBY'
schema_path, sample_path = ARGV
schema = JSON.parse(File.read(schema_path))
sample = JSON.parse(File.read(sample_path))

abort("schema root must describe an object") unless schema["type"] == "object"
missing = schema.fetch("required").reject { |key| sample.key?(key) }
abort("sample missing required fields: #{missing.join(", ")}") unless missing.empty?

extra = sample.keys - schema.fetch("properties").keys
abort("sample has unknown fields: #{extra.join(", ")}") unless extra.empty?
abort("unsupported schema version") unless sample["schema_version"] == "1.0.0"

%w[app_version build_number device_family os_version screen].each do |field|
  abort("#{field} must be a non-empty string") unless sample[field].is_a?(String) && !sample[field].empty?
end
%w[breadcrumbs logs redactions user_attached_files].each do |field|
  abort("#{field} must be an array") unless sample[field].is_a?(Array)
end
abort("state_snapshot must be an object") unless sample["state_snapshot"].is_a?(Hash)

privacy = sample.fetch("privacy_review")
%w[contains_user_content contains_tokens contains_screenshots].each do |field|
  abort("privacy review must set #{field} to false") unless privacy[field] == false
end

serialized = JSON.generate(sample)
abort("sample contains a token-shaped value") if serialized.match?(/(api[_-]?key|bearer\s+[a-z0-9._-]{12,}|sk-[a-z0-9]{12,})/i)
puts "Diagnostic schema validation passed."
RUBY
