#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$repo_root"
source scripts/temp-dir.sh

if [[ -n "${SWIFTUI_KIT_TEST_INVOCATION_LOG:-}" ]]; then
  printf 'run-tests\n' >> "$SWIFTUI_KIT_TEST_INVOCATION_LOG"
  if [[ "${SWIFTUI_KIT_TEST_STUB_ONLY:-0}" == "1" ]]; then
    exit 0
  fi
fi

fail() {
  echo "fail: $*" >&2
  exit 1
}

if [[ "${SWIFTUI_KIT_TEST_TEMP_PROBE:-0}" == "1" ]]; then
  probe_dir="$(swiftui_kit_mktemp_dir "$repo_root" "swiftui-kit-temp-probe")" || fail "could not create probe temp directory"
  [[ -d "$probe_dir" ]] || fail "probe temp directory was not created"
  rm -rf "$probe_dir"
  echo "Temp probe passed."
  exit 0
fi

assert_contains() {
  local needle="$1"
  local haystack="$2"
  if ! grep -Fq "$needle" "$haystack"; then
    fail "expected $haystack to contain $needle"
  fi
}

tmp_dir="$(swiftui_kit_mktemp_dir "$repo_root" "swiftui-kit-tests")" || fail "could not create test temp directory"
trap 'rm -rf "$tmp_dir"' EXIT

echo "test: temp directory falls back when TMPDIR is unavailable"
TMPDIR="$tmp_dir/missing-tmp-base" \
  SWIFTUI_KIT_TEST_TEMP_PROBE=1 \
  bash tests/run-tests.sh > "$tmp_dir/temp-probe.txt"
assert_contains "Temp probe passed." "$tmp_dir/temp-probe.txt"

echo "test: cli lists skills"
scripts/swiftui-kit.sh list > "$tmp_dir/list.txt"
assert_contains "swiftui-project-router" "$tmp_dir/list.txt"
assert_contains "canvas-engine-auditor" "$tmp_dir/list.txt"
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
TMPDIR="$tmp_dir/missing-bundle-tmp-base" \
  scripts/build-provider-bundles.sh --output "$tmp_dir/dist" > "$tmp_dir/bundle.txt"
for provider_dir in .agents .claude .cursor .gemini .github .opencode; do
  [[ -f "$tmp_dir/dist/$provider_dir/skills/swiftui-project-router/SKILL.md" ]] || fail "missing $provider_dir bundle"
  [[ -f "$tmp_dir/dist/$provider_dir/skills/canvas-engine-auditor/SKILL.md" ]] || fail "missing $provider_dir canvas bundle"
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
assert_contains "canvas-audit" docs/commands.md
assert_contains "review-screenshots" .agents/skills/swiftui-project-router/SKILL.md
assert_contains "canvas-audit" .agents/skills/swiftui-project-router/SKILL.md

echo "test: Liquid Glass implementation guidance exists"
assert_contains "Implementation Mode" .agents/skills/liquid-glass-placement-auditor/SKILL.md
assert_contains "API Verification Required" .agents/skills/liquid-glass-placement-auditor/references/swiftui-liquid-glass-recipes.md
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

echo "test: canvas engine auditor exists"
[[ -f examples/canvas-engine-auditor-example.md ]] || fail "missing canvas engine auditor example"
assert_contains "Canvas Architecture Map" examples/canvas-engine-auditor-example.md
assert_contains "canvas-engine-auditor" README.md
assert_contains "canvas-engine-auditor" docs/skill-index.md
assert_contains "canvas-engine-auditor" CLAUDE.md
assert_contains "canvas-engine-auditor" examples/claude-prompts.md

echo "test: canvas risk scanner flags PencilKit and coordinate hotspots"
mkdir -p "$tmp_dir/Canvas App"
cat > "$tmp_dir/Canvas App/CanvasView.swift" <<'SWIFT'
import PencilKit
import SwiftUI

struct CanvasView: UIViewRepresentable {
  func makeUIView(context: Context) -> PKCanvasView {
    PKCanvasView()
  }

  func updateUIView(_ canvasView: PKCanvasView, context: Context) {
    canvasView.drawing = PKDrawing()
  }

  var drag: some Gesture {
    DragGesture(coordinateSpace: .global)
  }
}
SWIFT
.agents/skills/canvas-engine-auditor/scripts/detect-canvas-risks.sh "$tmp_dir/Canvas App" > "$tmp_dir/canvas-scan.txt"
assert_contains "PKCanvasView" "$tmp_dir/canvas-scan.txt"
assert_contains "DragGesture" "$tmp_dir/canvas-scan.txt"

echo "test: detect-risks worked example exists"
[[ -f examples/detect-risks-example.md ]] || fail "missing detect-risks example"
assert_contains "Findings: 5" examples/detect-risks-example.md
assert_contains "examples/detect-risks-example.md" README.md
assert_contains "detect-risks-example.md" docs/commands.md
assert_contains "detect-risks-example.md" docs/usage.md

echo "test: validate command runs local tests once"
validate_log="$tmp_dir/validate-test-invocations.txt"
: > "$validate_log"
SWIFTUI_KIT_TEST_INVOCATION_LOG="$validate_log" \
  SWIFTUI_KIT_TEST_STUB_ONLY=1 \
  scripts/swiftui-kit.sh validate > "$tmp_dir/validate.txt"
test_invocations="$(wc -l < "$validate_log" | tr -d ' ')"
[[ "$test_invocations" -eq 1 ]] || fail "expected validate to run local tests once, ran $test_invocations times"
assert_contains "Validated " "$tmp_dir/validate.txt"

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
assert_contains "multiple booleans" docs/detector-roadmap.md
assert_contains "public sample SwiftUI app" docs/demo-roadmap.md

echo "All tests passed."
