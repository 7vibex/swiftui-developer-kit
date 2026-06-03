# View Refactor Patterns

A good SwiftUI refactor makes the file read as state, dependencies, layout, actions, and helpers.

## File Ordering

Prefer this order unless the local file has a stronger convention:

1. Environment values.
2. Stored inputs.
3. State and bindings.
4. Non-view computed values.
5. Initializers.
6. `body`.
7. Small view builders.
8. Actions, async helpers, and formatting helpers.

## Extract Subviews

Prefer dedicated `View` types for sections that have branching, bindings, async work, repeated layout, or their own preview value.

Pass small explicit inputs:

```swift
private struct FilterSection: View {
    let options: [FilterOption]
    @Binding var selection: FilterOption

    var body: some View {
        Picker("Filter", selection: $selection) {
            ForEach(options) { option in
                Text(option.title).tag(option)
            }
        }
    }
}
```

Avoid turning a large screen into many large `private var header: some View` fragments. Small computed builders are fine for tiny repeated pieces, toolbar content, or localized modifiers.

## Stable View Tree

- Prefer one stable root container with conditional sections, overlays, toolbars, and disabled states.
- Avoid swapping entirely different root views for edit/read/loading modes when a stable structure can express the change.
- Keep `ForEach` identity stable and based on durable IDs, not array offsets.

## Action Extraction

- Keep non-trivial button actions out of `body`.
- Let body read like UI and move orchestration into small private functions.
- Move real business rules into services, repositories, models, or feature coordinators.
