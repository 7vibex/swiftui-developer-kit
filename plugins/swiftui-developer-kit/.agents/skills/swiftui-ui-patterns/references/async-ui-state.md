# Async UI State

Async work should have an owner, a cancellation story, and visible UI states.

## Patterns

- Use `.task` for first-load work tied to view lifetime.
- Use `.task(id:)` when a changing input should restart work and cancel the previous task.
- Use explicit loading, empty, error, and loaded states for user-visible data fetches.
- Keep business logic in models, services, or repositories; the view should orchestrate.
- Use `@MainActor` for UI-facing observable models that mutate rendered state.
- Debounce search or filtering before starting expensive work.
- Use `.refreshable` for user-triggered reloads when the platform control fits.

## Checks

- A fast-changing search query cannot race older results into the UI.
- Long-running tasks stop when the view disappears or the input changes.
- Errors are visible or intentionally recoverable, not swallowed.
- Button actions disable or show progress during non-idempotent work.
- Repeated `onAppear` calls do not start duplicate unstructured tasks.

## Avoid

- `Task {}` inside `.onAppear` when `.task` would tie lifetime correctly.
- Service calls inside `body` or computed view builders.
- `try?` around user-visible work without fallback UI.
- Manual cancellation state spread across unrelated views.
