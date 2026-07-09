# Navigation Checklist

- Route ownership is clear.
- Deep links or restored routes have a defined path.
- `NavigationStack` paths use stable values.
- `NavigationSplitView` has sensible iPad/macOS behavior.
- Sheets and popovers have a single source of presentation truth.
- Dismissal paths do not leave stale state behind.
- Tabs do not duplicate independent navigation models accidentally.
- Navigation state is testable outside the view when flows are complex.
