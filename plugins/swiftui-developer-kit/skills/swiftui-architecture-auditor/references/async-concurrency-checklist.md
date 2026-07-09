# Async And Concurrency Checklist

- UI updates happen on the main actor.
- Long-running tasks can be cancelled.
- `Task` usage is tied to lifecycle intentionally.
- Network and persistence errors are surfaced.
- Duplicate requests are avoided.
- Async state includes loading, success, empty, and error where relevant.
- Services do not expose UI-only types.
- Tests cover important async success and failure paths.
