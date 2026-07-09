# Feature Planning Checklist

Use before implementation.

- Define the user-visible behavior in one sentence.
- Identify the source of truth for state.
- Identify whether data is local, remote, generated, or persisted.
- Confirm navigation entry and exit points.
- Confirm loading, empty, error, and disabled states.
- Check platform targets: iOS, iPadOS, macOS, or multiplatform.
- For Liquid Glass or newer-OS UI, ask how to handle the app's oldest supported OS before editing: keep the existing UI path, add a separate non-glass fallback, or raise the minimum OS.
- Check whether SwiftData, networking, file access, or permissions are involved.
- Check whether Apple APIs are new, availability-guarded, beta, future-looking, or fallback-dependent.
- Decide older-OS behavior for new SwiftUI, Liquid Glass, PaperKit, SwiftData, or MetricKit APIs.
- List likely tests: ViewModel, repository, service, persistence, or UI state.
- Decide verification: build, unit tests, UI snapshot, Simulator smoke test, or code-only review.

Do not expand scope into unrelated refactors.
