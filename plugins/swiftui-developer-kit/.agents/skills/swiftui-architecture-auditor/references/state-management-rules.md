# State Management Rules

- `@State`: local, view-owned, short-lived UI state.
- `@Binding`: parent-owned state edited by a child.
- `@StateObject`: stable ownership for an observable object in a view lifecycle.
- `@ObservedObject`: observe an object owned elsewhere.
- `@Environment`: platform values or intentionally global app context.
- `@Observable`: modern observable model when the project targets support it.

Red flags:

- Multiple sources of truth for the same value.
- Business state reset because it is owned by a transient view.
- Environment used as hidden dependency injection for feature-specific logic.
- Async callbacks updating state after a view disappears.
- View state copied into model state without synchronization rules.
