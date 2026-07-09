# Regression Test Checklist

- Reproduce the original bug before fixing it.
- Name the test after the behavior that must not regress.
- Use the smallest fixture that demonstrates the bug.
- Keep the assertion user-visible where possible.
- Run the failing test, then implement the fix, then run it again.
- Canvas/PDF bugs include save, close, reopen, export, and page-transform cases where relevant.
- SwiftData destructive bugs include confirmation/recovery and persisted-state verification.
- Accessibility regressions identify the common task and assistive feature they protect.
