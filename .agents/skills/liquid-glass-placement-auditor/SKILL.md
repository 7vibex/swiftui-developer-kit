---
name: liquid-glass-placement-auditor
description: Audit SwiftUI/iOS/iPadOS/macOS UI for Apple Liquid Glass placement in toolbars, tabs, sidebars, panels, chrome, canvas controls, and OS fallback decisions.
---

# Liquid Glass Placement Auditor

Audit SwiftUI screens and recommend where Liquid Glass belongs. Liquid Glass is for controls and chrome, not primary content.

## Required Preflight

Ask this before operating Simulator, using Computer Use, using Appshots, or capturing screenshots:

“Is the app already running in the iOS/iPadOS Simulator on the screen you want reviewed?

Reply with one of these:

1. `yes-running` — the app is already open in Simulator
2. `no-launch-it` — launch/build the app first
3. `screenshots-only` — I will provide screenshots manually
4. `code-only` — audit only the SwiftUI code”

Do not capture or operate anything until the user answers.

## References

- Use `references/placement-rules.md` for where to use or avoid glass.
- Use `references/screenshot-review-checklist.md` when screenshots are available.
- Use `references/accessibility-checklist.md` before recommending transparency.
- Use `references/swiftui-patterns.md` for code search signals.
- Use `references/swiftui-liquid-glass-recipes.md` when the user asks for implementation guidance or concrete SwiftUI directions.
- Use `references/implementation-recipes.md` when the request names implementation recipes directly.
- Use `references/platform-compatibility.md` before recommending availability guards or older-OS behavior.
- Use `references/platform-version-matrix.md` when the request names platform version rules directly.
- Use `references/studyos-placement-map.md` when the project resembles StudyOS or the user asks for StudyOS-specific placement.
- Use `references/apple-liquid-glass-links.md` for official links.
- Use `../../../docs/apple-source-map.md` and `../../../docs/apple-api-inventory.md` before naming new Liquid Glass APIs.
- Use `references/output-contract.md` for the report.

Prefer targeted search, project maps, and bundled scripts before reading many files.

## Workflows

### `yes-running`

1. Ask the user to bring Simulator to the front and navigate to the screen.
2. Ask for the screen name.
3. Prefer Appshots if available and approved.
4. Fallback to `scripts/capture-simulator-screenshot.sh` after approval.
5. Save screenshots with names like `01-home.png` and `02-canvas.png`.
6. Repeat only for screens the user approves.
7. Analyze screenshots and SwiftUI code together when code is available.

### `no-launch-it`

1. Inspect the project for `.xcodeproj`, `.xcworkspace`, or `Package.swift`.
2. Detect schemes with safe commands.
3. Ask if scheme or device is ambiguous.
4. Do not build or launch without confirmation.
5. After launch approval, follow `yes-running`.

### `screenshots-only`

Ask the user to attach screenshots. Mark recommendations as screenshot-based if no code was inspected.

### `code-only`

Inspect SwiftUI files for glass candidates. State lower confidence because screenshots were not reviewed.

### Implementation Mode

Use this mode when the user asks to apply Liquid Glass, convert a surface, or provide implementation-ready guidance.

1. Complete the placement audit first, even if it is code-only.
2. Classify each candidate as primary content, chrome, transient overlay, navigation, inspector, or warning/destructive UI.
3. Reject glass on reading, writing, drawing, PDF, flashcard, transcript, table, form, and warning content unless the user has a strong product reason and the accessibility risk is documented.
4. Create a minimal file-by-file implementation plan.
5. Check current Apple or Xcode documentation for exact API names before editing.
6. Add availability guards for Liquid Glass-only APIs.
7. Add Reduce Transparency and older-OS fallback behavior.
8. Build the latest app version after code changes.
9. Run the app in Simulator after a successful iOS or iPadOS build.
10. Ask before screenshots, Appshots, Computer Use, or Simulator capture.

If another specialist skill would be a better next step, recommend an explicit handoff prompt instead of claiming this skill automatically invokes it.

## Finding Standards

Every recommendation must include:

- Evidence source: screenshot, code path, or both.
- Confidence: high, medium, or low.
- Placement decision: use, use carefully, avoid, or needs screenshot verification.
- Surface classification: primary content, chrome, transient overlay, navigation, inspector, or warning/destructive UI.
- Glass variant decision: regular, clear, none, or needs SDK verification.
- Accessibility risk: none, low, medium, or high.
- OS support decision: ask before implementation whether iOS 17 keeps its existing UI, gets a new non-glass fallback, or is intentionally dropped by raising the minimum OS.
- Fallback decision: older OS and Reduce Transparency behavior.
- A concrete SwiftUI direction, not just visual advice.

Prioritize readability and control discoverability over decorative effect. A good Liquid Glass recommendation should explain what remains opaque, what becomes chrome, how the design behaves with Reduce Transparency, and what older OS users see.

## Do Not Use When

- The request is not about Liquid Glass, chrome placement, modern UI surfaces, or transparency fallbacks.
- The user needs a broad design audit, feature implementation, or build diagnosis first.

## Done When

- Every candidate is classified as content, chrome, navigation, inspector, transient overlay, or warning/destructive UI.
- Each glass recommendation includes evidence, confidence, availability, fallback, and accessibility risk.
- Primary reading, writing, drawing, PDF, form, transcript, and warning content are protected or explicitly justified.

## Output

Use `references/output-contract.md`.

Follow `../../../docs/skill-quality-standard.md` and compare `../../../examples/skill-outputs/liquid-glass-placement-auditor-bad-output.md` with `../../../examples/skill-outputs/liquid-glass-placement-auditor-good-output.md`.
