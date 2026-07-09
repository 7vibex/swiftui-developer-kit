#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'USAGE'
Usage: scripts/validate-codex-plugin-package.sh [--package DIR]

Validates the tracked Codex plugin, marketplace metadata, self-contained
shared references, and deterministic source-to-package synchronization.
USAGE
}

package_dir=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    --package)
      [[ $# -ge 2 ]] || { echo "--package requires a directory." >&2; exit 2; }
      package_dir="$2"
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

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
package_dir="${package_dir:-$repo_root/plugins/swiftui-developer-kit}"
manifest_template="$repo_root/plugins/swiftui-developer-kit.plugin.json"
marketplace="$repo_root/.agents/plugins/marketplace.json"

[[ -d "$package_dir" ]] || { echo "Missing plugin package: $package_dir" >&2; exit 1; }
[[ -f "$manifest_template" ]] || { echo "Missing plugin manifest template: $manifest_template" >&2; exit 1; }
[[ -f "$marketplace" ]] || { echo "Missing marketplace manifest: $marketplace" >&2; exit 1; }
command -v ruby >/dev/null 2>&1 || { echo "Missing required command: ruby" >&2; exit 1; }

ruby - "$repo_root" "$package_dir" "$manifest_template" "$marketplace" <<'RUBY'
require "find"
require "json"

repo_root, package_dir, manifest_template, marketplace_path = ARGV.map { |path| File.expand_path(path) }
errors = []

def json_object(path, errors, label)
  JSON.parse(File.read(path))
rescue JSON::ParserError
  errors << "#{label} must contain valid JSON"
  {}
end

manifest_path = File.join(package_dir, ".codex-plugin", "plugin.json")
errors << "missing .codex-plugin/plugin.json" unless File.file?(manifest_path)
manifest = File.file?(manifest_path) ? json_object(manifest_path, errors, "plugin manifest") : {}
json_object(manifest_template, errors, "plugin manifest template")
marketplace = json_object(marketplace_path, errors, "marketplace manifest")

errors << "plugin manifest differs from its canonical template" if File.file?(manifest_path) && File.binread(manifest_path) != File.binread(manifest_template)
errors << "plugin manifest name must be swiftui-developer-kit" unless manifest["name"] == "swiftui-developer-kit"
version_pattern = /^(0|[1-9]\d*)\.(0|[1-9]\d*)\.(0|[1-9]\d*)(?:-[0-9A-Za-z.-]+)?(?:\+[0-9A-Za-z.-]+)?$/
errors << "plugin manifest version must be strict semver" unless manifest["version"].is_a?(String) && manifest["version"].match?(version_pattern)
errors << "plugin manifest skills path must be ./skills/" unless manifest["skills"] == "./skills/"

author = manifest["author"]
errors << "plugin manifest author.name must be non-empty" unless author.is_a?(Hash) && author["name"].is_a?(String) && !author["name"].strip.empty?

interface = manifest["interface"]
unless interface.is_a?(Hash)
  errors << "plugin manifest interface must be an object"
else
  %w[displayName shortDescription longDescription developerName category].each do |key|
    errors << "plugin interface #{key} must be non-empty" unless interface[key].is_a?(String) && !interface[key].strip.empty?
  end
  capabilities = interface["capabilities"]
  errors << "plugin interface capabilities must be a non-empty string array" unless capabilities.is_a?(Array) && !capabilities.empty? && capabilities.all? { |value| value.is_a?(String) && !value.strip.empty? }
  prompts = interface["defaultPrompt"]
  errors << "plugin interface defaultPrompt must contain one to three short strings" unless prompts.is_a?(Array) && prompts.length.between?(1, 3) && prompts.all? { |value| value.is_a?(String) && !value.strip.empty? && value.length <= 128 }
end

skills_root = File.join(package_dir, "skills")
source_skills_root = File.join(repo_root, ".agents", "skills")
errors << "missing plugin skills directory" unless File.directory?(skills_root)
plugin_skills = File.directory?(skills_root) ? Dir.children(skills_root).select { |name| File.directory?(File.join(skills_root, name)) }.sort : []
source_skills = Dir.children(source_skills_root).select { |name| File.directory?(File.join(source_skills_root, name)) }.sort
errors << "plugin skills do not match canonical .agents/skills" unless plugin_skills == source_skills
plugin_skills.each do |skill|
  errors << "plugin skill #{skill} is missing SKILL.md" unless File.file?(File.join(skills_root, skill, "SKILL.md"))
end

canonical_skills_root = File.join(package_dir, ".agents", "skills")
errors << "package is missing the canonical .agents/skills mirror" unless File.directory?(canonical_skills_root)
canonical_skills = File.directory?(canonical_skills_root) ? Dir.children(canonical_skills_root).select { |name| File.directory?(File.join(canonical_skills_root, name)) }.sort : []
errors << "package .agents/skills mirror does not match canonical skills" unless canonical_skills == source_skills

%w[.claude .github benchmarks docs examples scanner schemas scripts tests].each do |directory|
  errors << "package is missing runtime directory #{directory}" unless File.directory?(File.join(package_dir, directory))
end
%w[.gitignore AGENTS.md CHANGELOG.md CLAUDE.md CODE_OF_CONDUCT.md CONTRIBUTING.md Gemfile Gemfile.lock LICENSE README.md SECURITY.md].each do |file|
  errors << "package is missing runtime file #{file}" unless File.file?(File.join(package_dir, file))
end
%w[Package.swift Package.resolved].each do |file|
  errors << "package is missing scanner/#{file}" unless File.file?(File.join(package_dir, "scanner", file))
end
%w[Fixtures Sources Tests].each do |directory|
  errors << "package is missing scanner/#{directory}" unless File.directory?(File.join(package_dir, "scanner", directory))
end
errors << "package must not include scanner build output" if File.exist?(File.join(package_dir, "scanner", ".build"))
errors << "package must not include the source marketplace" if File.exist?(File.join(package_dir, ".agents", "plugins"))

%w[build-codex-plugin-package.sh validate-codex-plugin-package.sh].each do |script|
  errors << "package must not include source-only script #{script}" if File.exist?(File.join(package_dir, "scripts", script))
end
errors << "package is missing validate-packaged-skill-closure.sh required by provider bundles" unless File.file?(File.join(package_dir, "scripts", "validate-packaged-skill-closure.sh"))

installation_guide = File.join(package_dir, "docs", "installation.md")
if File.file?(installation_guide)
  installation_text = File.read(installation_guide)
  errors << "package installation guide must label validate-codex-plugin-package.sh as source-checkout-only" if installation_text.include?("./scripts/validate-codex-plugin-package.sh") && !installation_text.match?(/source checkout/i)
  errors << "package installation guide must provide its package-local validate-skills.sh command" unless installation_text.include?("./scripts/validate-skills.sh")
end

# The installed artifact deliberately omits source marketplace metadata and the
# package builder/synchronizer. Markdown link closure cannot catch path names
# inside prose or code fences, so require nearby source-checkout context for
# every such reference copied into package documentation.
source_only_references = [
  ".agents/plugins/marketplace.json",
  "plugins/swiftui-developer-kit/",
  "./scripts/build-codex-plugin-package.sh",
  "./scripts/validate-codex-plugin-package.sh"
]
documentation_paths = [File.join(package_dir, "README.md")] + Dir[File.join(package_dir, "docs", "**", "*.md")]
documentation_paths.each do |path|
  next unless File.file?(path)

  lines = File.readlines(path, chomp: true)
  lines.each_with_index do |line, index|
    source_only_references.each do |reference|
      next unless line.include?(reference)

      context = lines[[index - 5, 0].max..[index + 5, lines.length - 1].min].join("\n")
      next if context.match?(/source[ -]checkout|repository[ -]checkout|source tree|source repository|on `main`/i)

      errors << "#{path.delete_prefix("#{package_dir}/")} references source-only #{reference} without nearby source-checkout context"
    end
  end
end

Find.find(package_dir) do |path|
  errors << "plugin package must not contain symlinks: #{path.delete_prefix("#{package_dir}/")}" if File.symlink?(path)
end

errors << "marketplace name must be swiftui-developer-kit" unless marketplace["name"] == "swiftui-developer-kit"
entry = marketplace.fetch("plugins", []).find { |candidate| candidate.is_a?(Hash) && candidate["name"] == "swiftui-developer-kit" }
if entry.nil?
  errors << "marketplace is missing swiftui-developer-kit entry"
else
  expected_source = { "source" => "local", "path" => "./plugins/swiftui-developer-kit" }
  expected_policy = { "installation" => "AVAILABLE", "authentication" => "ON_INSTALL" }
  errors << "marketplace plugin source is incorrect" unless entry["source"] == expected_source
  errors << "marketplace plugin policy is incorrect" unless entry["policy"] == expected_policy
  errors << "marketplace plugin category must be Developer Tools" unless entry["category"] == "Developer Tools"
end

unless errors.empty?
  warn "Plugin package validation failed:"
  errors.uniq.each { |error| warn "- #{error}" }
  exit 1
end

puts "Validated plugin manifest, marketplace metadata, and #{plugin_skills.length} packaged skills."
RUBY

bash "$repo_root/scripts/validate-packaged-skill-closure.sh" \
  --root "$package_dir" \
  --label "tracked Codex plugin package"

source "$repo_root/scripts/temp-dir.sh"
temp_dir="$(swiftui_kit_mktemp_dir "$repo_root" "swiftui-kit-plugin-package")"
cleanup() {
  /bin/rm -r "$temp_dir"
}
trap cleanup EXIT

bash "$repo_root/scripts/build-codex-plugin-package.sh" --output "$temp_dir/generated" >/dev/null
if ! diff -qr "$package_dir" "$temp_dir/generated" > "$temp_dir/plugin-diff.txt"; then
  echo "Plugin package is out of sync with canonical sources. Regenerate it with:" >&2
  echo "  scripts/build-codex-plugin-package.sh --output plugins/swiftui-developer-kit" >&2
  /bin/cat "$temp_dir/plugin-diff.txt" >&2
  exit 1
fi

if ! (
  cd "$temp_dir/generated"
  BUNDLE_GEMFILE="$repo_root/Gemfile" \
    SWIFTUI_KIT_PLUGIN_PACKAGE=1 \
    ./scripts/validate-skills.sh
  /bin/bash scripts/swiftui-kit.sh list > "$temp_dir/packaged-skill-list.txt"
) > "$temp_dir/standalone-validation.txt" 2>&1; then
  echo "Standalone plugin package validation failed:" >&2
  /bin/cat "$temp_dir/standalone-validation.txt" >&2
  exit 1
fi

grep -Fq "swiftui-project-router" "$temp_dir/packaged-skill-list.txt" || {
  echo "Standalone plugin package CLI did not list swiftui-project-router." >&2
  exit 1
}

echo "Validated deterministic plugin synchronization and standalone package validation."
