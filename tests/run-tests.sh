#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$repo_root"

fail() {
  echo "fail: $*" >&2
  exit 1
}

assert_contains() {
  local needle="$1"
  local haystack="$2"
  if ! grep -Fq "$needle" "$haystack"; then
    fail "expected $haystack to contain $needle"
  fi
}

tmp_dir="$(mktemp -d "${TMPDIR:-/tmp}/swiftui-kit-tests.XXXXXX")"
trap 'rm -rf "$tmp_dir"' EXIT

echo "test: cli lists skills"
scripts/swiftui-kit.sh list > "$tmp_dir/list.txt"
assert_contains "swiftui-project-router" "$tmp_dir/list.txt"
assert_contains "swiftui-design-system-auditor" "$tmp_dir/list.txt"
assert_contains "swiftui-ui-patterns" "$tmp_dir/list.txt"
assert_contains "liquid-glass-placement-auditor" "$tmp_dir/list.txt"

echo "test: detector flags SwiftUI anti-patterns"
mkdir -p "$tmp_dir/App"
cat > "$tmp_dir/App/ProblemView.swift" <<'SWIFT'
import SwiftUI

struct ProblemView: View {
  var body: some View {
    VStack {
      Button(action: save) {
        Image(systemName: "square.and.arrow.down")
      }
      Text("Save").foregroundColor(.red)
    }
    .onAppear {
      Task {
        await load()
      }
    }
  }

  func save() {}
  func load() async {}
}
SWIFT
for i in $(seq 1 130); do echo "extension ProblemView { var filler$i: String { \"x\" } }" >> "$tmp_dir/App/ProblemView.swift"; done

scripts/detect-swiftui-antipatterns.sh --format json "$tmp_dir/App" > "$tmp_dir/detect.json"
assert_contains '"rule":"large-swiftui-file"' "$tmp_dir/detect.json"
assert_contains '"rule":"image-button-missing-accessibility-label"' "$tmp_dir/detect.json"
assert_contains '"rule":"unstructured-task-in-view-lifecycle"' "$tmp_dir/detect.json"
assert_contains '"rule":"hardcoded-foreground-color"' "$tmp_dir/detect.json"

echo "test: provider bundles are generated"
scripts/build-provider-bundles.sh --output "$tmp_dir/dist" > "$tmp_dir/bundle.txt"
for provider_dir in .agents .claude .cursor .gemini .github .opencode; do
  [[ -f "$tmp_dir/dist/$provider_dir/skills/swiftui-project-router/SKILL.md" ]] || fail "missing $provider_dir bundle"
done
[[ -f "$tmp_dir/dist/.claude/CLAUDE.md" ]] || fail "missing Claude adapter manifest"
[[ -f "$tmp_dir/dist/.claude/commands/audit.md" ]] || fail "missing Claude command bundle"

echo "test: Codex install target uses current agents directory"
scripts/install-local.sh --help > "$tmp_dir/install-help.txt"
assert_contains '$HOME/.agents/skills' "$tmp_dir/install-help.txt"
assert_contains '$HOME/.agents/skills' scripts/install-local.sh
assert_contains '$HOME/.agents/skills' docs/installation.md
assert_contains '~/.agents/skills' README.md

echo "test: command vocabulary exists"
assert_contains "review-screenshots" docs/commands.md
assert_contains "prepare-release" docs/commands.md
assert_contains "detect-risks" docs/commands.md
assert_contains "review-screenshots" .agents/skills/swiftui-project-router/SKILL.md

echo "test: Liquid Glass implementation guidance exists"
assert_contains "Implementation Mode" .agents/skills/liquid-glass-placement-auditor/SKILL.md
assert_contains "swiftui-liquid-glass-recipes.md" .agents/skills/liquid-glass-placement-auditor/SKILL.md
assert_contains "implementation-recipes.md" .agents/skills/liquid-glass-placement-auditor/SKILL.md
assert_contains "platform-compatibility.md" .agents/skills/liquid-glass-placement-auditor/SKILL.md
assert_contains "platform-version-matrix.md" .agents/skills/liquid-glass-placement-auditor/SKILL.md
assert_contains "studyos-placement-map.md" .agents/skills/liquid-glass-placement-auditor/SKILL.md
[[ -f .agents/skills/liquid-glass-placement-auditor/references/swiftui-liquid-glass-recipes.md ]] || fail "missing Liquid Glass SwiftUI recipes"
[[ -f .agents/skills/liquid-glass-placement-auditor/references/implementation-recipes.md ]] || fail "missing Liquid Glass implementation recipes alias"
[[ -f .agents/skills/liquid-glass-placement-auditor/references/platform-compatibility.md ]] || fail "missing Liquid Glass compatibility matrix"
[[ -f .agents/skills/liquid-glass-placement-auditor/references/platform-version-matrix.md ]] || fail "missing Liquid Glass platform version matrix"
[[ -f .agents/skills/liquid-glass-placement-auditor/references/studyos-placement-map.md ]] || fail "missing StudyOS Liquid Glass placement map"
assert_contains "Reduce Transparency" .agents/skills/liquid-glass-placement-auditor/references/swiftui-liquid-glass-recipes.md
assert_contains "iOS/iPadOS 26" .agents/skills/liquid-glass-placement-auditor/references/platform-compatibility.md
assert_contains "Canvas floating tool palette" .agents/skills/liquid-glass-placement-auditor/references/studyos-placement-map.md

echo "test: behavior checks pass"
scripts/test-skill-behavior.sh > "$tmp_dir/behavior.txt"
assert_contains "Behavior checks passed" "$tmp_dir/behavior.txt"

echo "test: SwiftUI UI patterns skill exists"
assert_contains "state-ownership.md" .agents/skills/swiftui-ui-patterns/SKILL.md
assert_contains "navigation-sheets.md" .agents/skills/swiftui-ui-patterns/SKILL.md
assert_contains "async-ui-state.md" .agents/skills/swiftui-ui-patterns/SKILL.md
assert_contains "SwiftUI UI Patterns Review" examples/swiftui-ui-patterns-example.md

echo "test: SwiftUI design-system auditor exists"
assert_contains "apple-ui-quality-checklist.md" .agents/skills/swiftui-design-system-auditor/SKILL.md
assert_contains "platform-interaction-checklist.md" .agents/skills/swiftui-design-system-auditor/SKILL.md
assert_contains "SwiftUI Design System Audit" examples/full-studyos-design-audit.md

echo "test: security and Claude adapter exist"
assert_contains "Do not capture" SECURITY.md
assert_contains "swiftui-design-system-auditor" CLAUDE.md
assert_contains "Claude Code Usage" docs/claude-code-usage.md
assert_contains "Claude Prompt Examples" examples/claude-prompts.md

echo "test: docs demo exists"
[[ -f docs/demo-site/index.html ]] || fail "missing docs demo site"
assert_contains "Codex SwiftUI Developer Kit" docs/demo-site/index.html
assert_contains "detect-risks" docs/demo-site/index.html

echo "All tests passed."
