#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'USAGE'
Usage: scripts/validate-packaged-skill-closure.sh --root DIR [--label LABEL]

Validates that shared docs, examples, scripts, and schemas referenced by every
packaged skill Markdown file resolve inside a generated package or provider
bundle.
USAGE
}

root=""
label="package"

while [[ $# -gt 0 ]]; do
  case "$1" in
    --root)
      [[ $# -ge 2 ]] || { echo "--root requires a directory." >&2; exit 2; }
      root="$2"
      shift 2
      ;;
    --label)
      [[ $# -ge 2 ]] || { echo "--label requires text." >&2; exit 2; }
      label="$2"
      shift 2
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "Unknown option: $1" >&2
      usage >&2
      exit 2
      ;;
  esac
done

[[ -n "$root" ]] || { usage >&2; exit 2; }
[[ -d "$root" ]] || { echo "Missing package root: $root" >&2; exit 1; }
command -v ruby >/dev/null 2>&1 || { echo "Missing required command: ruby" >&2; exit 1; }

ruby - "$root" "$label" <<'RUBY'
require "find"

root = File.expand_path(ARGV.fetch(0))
label = ARGV.fetch(1)
skill_paths = []
Find.find(root) do |path|
  skill_paths << path if File.basename(path) == "SKILL.md" && File.file?(path)
end
skill_paths.sort!

abort("error: #{label} contains no SKILL.md files") if skill_paths.empty?

shared_path = %r{(?<![A-Za-z0-9_.-])(?:\.\./)+(?:docs|examples|scripts|schemas)(?:/[A-Za-z0-9_.-]+)+}
references = 0
failures = []
markdown_paths = []

skill_paths.each do |skill_path|
  skill_root = File.dirname(skill_path)
  Find.find(skill_root) do |path|
    markdown_paths << path if File.file?(path) && File.extname(path) == ".md"
  end
end

markdown_paths.sort.uniq.each do |markdown_path|
  File.read(markdown_path).scan(shared_path).uniq.each do |reference|
    references += 1
    candidate = File.expand_path(reference, File.dirname(markdown_path))
    inside_root = candidate == root || candidate.start_with?("#{root}/")
    unless inside_root
      failures << "#{markdown_path.delete_prefix("#{root}/")}: #{reference} escapes the package root"
      next
    end
    unless File.file?(candidate) || File.directory?(candidate)
      failures << "#{markdown_path.delete_prefix("#{root}/")}: #{reference} is missing"
    end
  end
end

abort("error: #{label} contains no shared skill Markdown references") if references.zero?

unless failures.empty?
  warn "error: #{label} has unresolved shared references:"
  failures.each { |failure| warn "- #{failure}" }
  exit 1
end

puts "Validated #{references} shared Markdown references across #{markdown_paths.length} files in #{skill_paths.length} skills in #{label}."
RUBY
