#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$repo_root"

ruby <<'RUBY'
require "find"
require "uri"

skip_prefixes = [
  "./.git/",
  "./.tmp/",
  "./dist/",
  "./tmp/",
  "./temp/",
  "./node_modules/"
]

files = []
Find.find(".") do |path|
  next if skip_prefixes.any? { |prefix| path.start_with?(prefix) }
  next unless path.end_with?(".md")
  files << path
end

errors = []

files.sort.each do |file|
  text = File.read(file)
  dir = File.dirname(file)

  text.scan(/!?\[[^\]\n]*\]\(([^)\n]+)\)/).each do |match|
    raw_target = match.fetch(0).strip
    target = raw_target.sub(/\s+["'][^"']*["']\z/, "")
    target = target[1...-1] if target.start_with?("<") && target.end_with?(">")

    next if target.empty?
    next if target.start_with?("#")
    next if target.match?(/\A[a-z][a-z0-9+.-]*:/i)

    path = target.split("#", 2).first.to_s.split("?", 2).first.to_s
    next if path.empty?

    begin
      path = URI.decode_www_form_component(path)
    rescue ArgumentError
      errors << "#{file}: invalid URL encoding in #{raw_target}"
      next
    end

    resolved = File.expand_path(path, File.expand_path(dir))
    unless File.exist?(resolved)
      errors << "#{file}: missing link target #{raw_target}"
    end
  end
end

if errors.any?
  warn errors.join("\n")
  exit 1
end

puts "Markdown link checks passed: #{files.length} files checked."
RUBY
