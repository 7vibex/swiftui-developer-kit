# Testing Strategy

- Prefer behavior tests over implementation tests.
- Test state transitions and edge cases.
- Keep UI tests for critical flows and integration confidence.
- Use unit tests for ViewModels, services, repositories, and formatters.
- Use persistence tests for migration, deletes, and query behavior.
- Add regression tests for fixed bugs before changing implementation.
- Prefer save/reopen and migration fixtures over screenshot-only persistence confidence.
- Mark Apple Pencil Pro, hover, squeeze, roll, and real latency checks as device-required manual or hardware tests.
- Treat Accessibility Nutrition Label claims as common-task test matrices by feature and device family.
