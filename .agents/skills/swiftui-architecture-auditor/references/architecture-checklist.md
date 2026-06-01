# Architecture Checklist

- App entry point and scene structure are clear.
- Feature folders or modules have understandable ownership.
- Views are not responsible for networking, persistence, or complex business rules.
- Shared services are injected intentionally.
- ViewModels or observable models have focused responsibilities.
- Reusable components are not over-abstracted.
- Error handling is visible to the user where needed.
- Preview-only code does not leak into production behavior.
- Dead code and duplicate flows are identified before refactors.

## Deep Audit Questions

- Can a new contributor identify the owner of each major screen's state in less than five minutes?
- Can business logic be unit-tested without rendering SwiftUI views?
- Can navigation be restored or deep-linked without reconstructing UI side effects?
- Can persistence, network, or AI services be swapped for tests?
- Can a failed async operation be retried without leaving stale loading state?
- Does each feature have one obvious place for new behavior?

## Common SwiftUI Anti-Patterns

- Massive `body` builders with hidden business rules.
- Multiple booleans controlling mutually exclusive sheets.
- `onAppear` doing long-running work without cancellation.
- View-local state that should survive navigation.
- Shared mutable singletons used as hidden dependencies.
- Helper views that require too many unrelated bindings.
