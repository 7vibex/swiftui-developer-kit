# Architecture Checklist

- App entry point and scene structure are clear.
- Feature folders or modules have understandable ownership.
- Views are not responsible for networking, persistence, or complex business rules.
- Shared services are injected intentionally.
- ViewModels or observable models have focused responsibilities.
- SwiftData contexts, repositories, and document/file stores have clear ownership boundaries.
- Scene, window, document, and inspector state are separated from transient view state.
- Reusable components are not over-abstracted.
- Error handling is visible to the user where needed.
- Preview-only code does not leak into production behavior.
- Dead code and duplicate flows are identified before refactors.

## Deep Audit Questions

- Can a new contributor identify the owner of each major screen's state in less than five minutes?
- Can business logic be unit-tested without rendering SwiftUI views?
- Can navigation be restored or deep-linked without reconstructing UI side effects?
- Can persistence, network, or AI services be swapped for tests?
- Can destructive, save, and reopen flows be tested without a full UI run?
- Can multiwindow or document scenes restore state without relying on hidden globals?
- Can a failed async operation be retried without leaving stale loading state?
- Does each feature have one obvious place for new behavior?

## Common SwiftUI Anti-Patterns

- Massive `body` builders with hidden business rules.
- Multiple booleans controlling mutually exclusive sheets.
- `onAppear` doing long-running work without cancellation.
- View-local state that should survive navigation.
- SwiftData `@Query` or `ModelContext` orchestration in oversized root views.
- Scene or document state stored in a shared singleton.
- Production code using future-looking APIs without availability and fallback boundaries.
- Shared mutable singletons used as hidden dependencies.
- Helper views that require too many unrelated bindings.
