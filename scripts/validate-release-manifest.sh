#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$repo_root"

manifest="docs/releases/manifest.json"
[[ -f "$manifest" ]] || {
  echo "error: missing release manifest: $manifest" >&2
  exit 1
}

verify_git_tags=0
if [[ "${SWIFTUI_KIT_PLUGIN_PACKAGE:-0}" != "1" && -d "$repo_root/.git" ]]; then
  verify_git_tags=1
fi

ruby -rjson - "$manifest" "$verify_git_tags" <<'RUBY'
manifest_path, verify_git_tags = ARGV
manifest = JSON.parse(File.read(manifest_path))
abort("release manifest schema version mismatch") unless manifest["schema_version"] == "1.0.0"
releases = manifest.fetch("releases")
abort("release manifest releases must be a non-empty array") unless releases.is_a?(Array) && !releases.empty?

allowed_statuses = %w[released unreleased-planning release-criteria]
versions = []
errors = []

releases.each do |release|
  version = release["version"]
  status = release["status"]
  tag = release["tag"]
  notes = release["notes"]
  artifacts = release["shipped_artifacts"]
  versions << version

  errors << "invalid release version #{version.inspect}" unless version.is_a?(String) && version.match?(/\A\d+\.\d+\.\d+\z/)
  errors << "#{version} has unsupported status #{status.inspect}" unless allowed_statuses.include?(status)
  errors << "#{version} has missing release note #{notes.inspect}" unless notes.is_a?(String) && File.file?(notes)
  errors << "#{version} shipped_artifacts must be an array" unless artifacts.is_a?(Array)

  note_text = File.file?(notes) ? File.read(notes) : ""
  case status
  when "released"
    expected_tag = "v#{version}"
    errors << "#{version} released tag must be #{expected_tag.inspect}" unless tag == expected_tag
    errors << "#{notes} must identify a released status" unless note_text.match?(/^Status:\s+Released\b/i)
    if verify_git_tags == "1"
      errors << "released tag #{expected_tag} is absent from this checkout" unless system("git", "rev-parse", "--verify", "--quiet", "refs/tags/#{expected_tag}", out: File::NULL, err: File::NULL)
    end
  when "unreleased-planning"
    errors << "#{version} must not carry a release tag while unreleased" unless tag.nil?
    errors << "#{notes} must identify an unreleased planning status" unless note_text.match?(/^Status:\s+Unreleased planning\b/i)
    if verify_git_tags == "1"
      errors << "unreleased planning version #{version} already has tag v#{version}" if system("git", "rev-parse", "--verify", "--quiet", "refs/tags/v#{version}", out: File::NULL, err: File::NULL)
    end
  when "release-criteria"
    errors << "#{version} must not carry a release tag while it is criteria only" unless tag.nil?
    errors << "#{notes} must identify release criteria status" unless note_text.match?(/^Status:\s+Release criteria\b/i)
    if verify_git_tags == "1"
      errors << "release-criteria version #{version} already has tag v#{version}" if system("git", "rev-parse", "--verify", "--quiet", "refs/tags/v#{version}", out: File::NULL, err: File::NULL)
    end
  end
end

errors << "release manifest contains duplicate versions" unless versions.uniq.length == versions.length
changelog = File.read("CHANGELOG.md")
errors << "CHANGELOG must state that v0.1.0 is the only published tag" unless changelog.include?("v0.1.0 is the only published and tagged release")

abort("error: #{errors.join("\nerror: ")}") unless errors.empty?
puts "Release manifest validation passed: #{releases.length} entries#{verify_git_tags == "1" ? " with local tag verification" : " in package mode"}."
RUBY
