# Regression Test Checklist

- Reproduce the original bug before fixing it.
- Name the test after the behavior that must not regress.
- Use the smallest fixture that demonstrates the bug.
- Keep the assertion user-visible where possible.
- Run the failing test, then implement the fix, then run it again.
