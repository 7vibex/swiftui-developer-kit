#!/usr/bin/env ruby
# frozen_string_literal: true

require "json"

begin
  require "json_schemer"
rescue LoadError
  abort "error: missing json_schemer. Use Ruby 3.3 with Bundler 2.4.22 (install it with `gem install --user-install bundler -v 2.4.22`), run `bundle _2.4.22_ config set --local path .bundle && bundle _2.4.22_ install` from the repository root, then retry."
end

expect_invalid = ARGV.delete("--expect-invalid")

if ARGV.length < 2
  abort <<~USAGE
    Usage: scripts/validate-json-schema.rb [--expect-invalid] SCHEMA INSTANCE [INSTANCE ...]

    Validates JSON instances with the pinned json_schemer dependency. Pass
    --expect-invalid when every instance is expected to fail validation.
  USAGE
end

schema_path, *instance_paths = ARGV
schema = JSON.parse(File.read(schema_path))
schemer = JSONSchemer.schema(schema)
errors = []

instance_paths.each do |instance_path|
  instance = JSON.parse(File.read(instance_path))
  validation_errors = schemer.validate(instance).to_a
  valid = validation_errors.empty?

  if expect_invalid ? valid : !valid
    expectation = expect_invalid ? "invalid" : "valid"
    details = validation_errors.first(3).map do |error|
      pointer = error.fetch("data_pointer", "#")
      type = error.fetch("type", "validation")
      "#{pointer}: #{type}"
    end
    errors << "#{instance_path} was expected to be #{expectation}" + (details.empty? ? "" : " (#{details.join(", ")})")
  end
end

abort("error: #{errors.join("\nerror: ")}") unless errors.empty?

state = expect_invalid ? "invalid" : "valid"
puts "JSON Schema validation passed: #{instance_paths.length} #{state} instance(s)."
