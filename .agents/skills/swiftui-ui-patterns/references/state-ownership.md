# State Ownership

Choose the owner first, then the wrapper. Prefer the narrowest state tool that matches the data's lifetime.

| Scenario | Preferred Pattern |
| --- | --- |
| Local UI state owned by one view | `@State` |
| Child edits parent-owned value state | `@Binding` |
| Root owns an iOS 17+ `@Observable` reference model | `@State` stored observable |
| Child reads or mutates an injected iOS 17+ observable | Explicit stored property |
| Shared app service or platform context | `@Environment(Type.self)` |
| Legacy reference model for iOS 16 or earlier | `@StateObject` at the owner, `@ObservedObject` when injected |
| Truly app-wide legacy object | `@EnvironmentObject`, used sparingly |

## Checks

- One source of truth exists for each editable value.
- Parent state is not copied into child `@State` unless the child intentionally edits a draft.
- Optional observable state exists only when the UI has a real unloaded or absent state.
- Shared dependencies are not hidden globals.
- Derived values are computed from source data instead of stored and synchronized manually.

## Common Fixes

- Replace mirrored child `@State` with `@Binding`.
- Move a root-owned observable to `@State` on iOS 17+.
- Pass feature-local dependencies through initializers.
- Keep app services in environment only when many unrelated screens need them.
- Use value types for simple form state before introducing reference models.
