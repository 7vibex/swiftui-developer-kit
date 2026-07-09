---
name: swiftui-architecture-auditor
description: Audit SwiftUI app architecture for state management, navigation, async/concurrency, oversized views, business logic in views, dependency boundaries, maintainability, dead code, and production-readiness risks.
---

# SwiftUI Architecture Auditor

Audit SwiftUI architecture for correctness, maintainability, and production readiness. Prefer findings grounded in file paths, symbols, and observed code.

## References

- `references/architecture-checklist.md`
- `references/state-management-rules.md`
- `references/navigation-checklist.md`
- `references/async-concurrency-checklist.md`
- `../../docs/apple-api-inventory.md`
- `references/output-contract.md`
- Worked fictional example: `../../examples/swiftui-architecture-audit-example.md`

Prefer targeted search, project maps, and bundled scripts before reading many files.

## Check

- Huge views and files doing too much.
- Business logic embedded in views.
- State ownership problems involving `@State`, `@Binding`, `@StateObject`, `@ObservedObject`, `@Environment`, and `@Observable`.
- Navigation structure and route ownership.
- Async work, cancellation, and `MainActor` boundaries.
- Repository/service boundaries.
- SwiftData and document persistence boundaries.
- Scene, window, and multiwindow ownership.
- New or future-looking API adoption risks.
- Duplicated logic.
- Dead code and unused view paths.
- Missing tests around important state transitions.

## Workflow

1. Inspect project structure and likely app entry points.
2. Collect SwiftUI files manually or with `scripts/collect-swiftui-files.sh`.
3. Read high-risk files before reporting.
4. Trace state from source of truth to rendered view and mutation sites.
5. Trace navigation ownership for tabs, stacks, sheets, popovers, and split views.
6. Trace persistence boundaries between views, models, contexts, repositories, files, and diagnostics.
7. Trace scene and multiwindow state if the app supports documents, sidebars, inspectors, or multiple windows.
8. Trace async work from trigger to cancellation, error handling, and UI update.
9. Classify findings by severity.
10. Recommend a fix order that reduces risk first.
11. Generate actionable Codex fix prompts.

## Severity Standards

- Critical: User data loss, crashes, broken navigation, or async state corruption likely in normal use.
- High: Architecture makes common feature work risky, duplicates sources of truth, or hides dependencies.
- Medium: Maintainability or testability issue that will compound but has a safe local fix.
- Low: Cleanup that should wait until higher-risk issues are handled.

## Evidence Standards

Every finding should cite a file path, symbol, or search result. Do not report generic SwiftUI advice unless it is tied to this project.

## Do Not Use When

- The user only needs a narrow build fix, screenshot review, release checklist, or PR draft.
- The request lacks SwiftUI app code or project structure to inspect.

## Done When

- State owners, navigation, async work, persistence boundaries, and high-risk files are mapped where relevant.
- Critical and high findings cite evidence and are separated from maintainability cleanup.
- Fix order starts with data loss, crashes, broken navigation, async corruption, or test-blocking issues.

## Output

Use `references/output-contract.md`.

Follow `../../docs/skill-quality-standard.md` and compare `../../examples/skill-outputs/swiftui-architecture-auditor-bad-output.md` with `../../examples/skill-outputs/swiftui-architecture-auditor-good-output.md`.
