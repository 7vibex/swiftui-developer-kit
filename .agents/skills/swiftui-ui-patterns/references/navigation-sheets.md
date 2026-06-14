# Navigation And Sheets

Model destinations as data. Keep route ownership close to the feature or app shell that owns the history.

## Navigation

- Use `NavigationStack` with a typed route path when a screen pushes multiple destinations.
- Keep per-tab navigation history inside each tab when tabs should preserve independent stacks.
- Use `NavigationSplitView` for sidebar-detail apps where selection is the route.
- Use a sidebar when hierarchy is broad or deep; use tabs when top-level sections are few and peer-like.
- Prefer enum routes with associated IDs or lightweight data over passing full mutable models through the route.
- Keep deep link handling at the app shell, then translate URLs into typed routes.
- Give document and multiwindow scenes descriptive titles derived from the active content.

## Sheets, Alerts, Popovers

- Prefer `.sheet(item:)` when presentation represents a selected model or enum case.
- Avoid several booleans for mutually exclusive presentations.
- Avoid `if let` inside sheet content when the item binding can express absence.
- Let presented views dismiss themselves with `dismiss()` for simple cancel flows.
- Keep destructive confirmation state explicit and localized.
- Prefer stable commands and disabled states over removing menu or command groups for ordinary view state changes.

## Example Shape

```swift
enum ActiveSheet: Identifiable {
    case editTask(Task.ID)
    case addNote

    var id: String {
        switch self {
        case .editTask(let id): "edit-task-\(id)"
        case .addNote: "add-note"
        }
    }
}

@State private var activeSheet: ActiveSheet?
```

Use the same idea for alerts, popovers, and inspectors when only one destination can be active.
