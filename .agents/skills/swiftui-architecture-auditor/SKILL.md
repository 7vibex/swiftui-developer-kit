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
4. Classify findings by severity.
5. Recommend a fix order that reduces risk first.
6. Generate actionable Codex fix prompts.

## Output

Use `references/output-contract.md`.
