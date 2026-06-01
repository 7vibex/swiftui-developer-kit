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
- `references/output-contract.md`

## Check

- Huge views and files doing too much.
- Business logic embedded in views.
- State ownership problems involving `@State`, `@Binding`, `@StateObject`, `@ObservedObject`, `@Environment`, and `@Observable`.
- Navigation structure and route ownership.
- Async work, cancellation, and `MainActor` boundaries.
- Repository/service boundaries.
- Duplicated logic.
- Dead code and unused view paths.
- Missing tests around important state transitions.

## Workflow

1. Inspect project structure and likely app entry points.
2. Collect SwiftUI files manually or with `scripts/collect-swiftui-files.sh`.
3. Read high-risk files before reporting.
4. Trace state from source of truth to rendered view and mutation sites.
5. Trace navigation ownership for tabs, stacks, sheets, popovers, and split views.
6. Trace async work from trigger to cancellation, error handling, and UI update.
7. Classify findings by severity.
8. Recommend a fix order that reduces risk first.
9. Generate actionable Codex fix prompts.

## Severity Standards

- Critical: User data loss, crashes, broken navigation, or async state corruption likely in normal use.
- High: Architecture makes common feature work risky, duplicates sources of truth, or hides dependencies.
- Medium: Maintainability or testability issue that will compound but has a safe local fix.
- Low: Cleanup that should wait until higher-risk issues are handled.

## Evidence Standards

Every finding should cite a file path, symbol, or search result. Do not report generic SwiftUI advice unless it is tied to this project.

## Output

Use `references/output-contract.md`.
