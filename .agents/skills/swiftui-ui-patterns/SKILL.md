---
name: swiftui-ui-patterns
description: Build or refactor SwiftUI screens with modern state ownership, navigation, sheets, async loading, previews, accessibility, and performance-aware view composition.
---

# SwiftUI UI Patterns

Use this skill when shaping a SwiftUI screen, refactoring view structure, choosing state wrappers, wiring navigation or sheets, or reviewing UI composition before implementation.

## References

- Read `references/state-ownership.md` when deciding where state lives or which property wrapper to use.
- Read `references/navigation-sheets.md` when routing, presenting sheets, alerts, popovers, or split navigation.
- Read `references/async-ui-state.md` when screens load, refresh, search, debounce, or cancel async work.
- Read `references/view-refactor-patterns.md` when splitting large views or cleaning computed `some View` helpers.
- Read `references/previews-performance.md` when adding previews, fixtures, list identity, or render-cost checks.
- Use `references/output-contract.md` for final reports.

Prefer existing project conventions. When the app already has a clear architecture, improve inside that architecture instead of introducing a new pattern.

## Workflow

1. Identify the target screen, primary interaction, deployment target, and existing local patterns.
2. Choose the source of truth for state before choosing property wrappers.
3. Map navigation and modal presentation as data, using enum or item state for mutually exclusive destinations.
4. Keep async work cancellable and tied to view lifecycle or explicit user actions.
5. Split complex screens into dedicated subview types with small explicit inputs.
6. Add previews for important states when the project supports previews.
7. Check accessibility, Dynamic Type, and stable identity for lists, grids, and frequently updating views.
8. Verify with build, tests, or static checks when safe and relevant.

## Guardrails

- Do not add a ViewModel just to mirror local view state.
- Do not bury business logic in `body`, `.task`, `.onAppear`, `.onChange`, or button closures.
- Do not replace a working project-wide pattern for stylistic reasons.
- Do not use multiple booleans for mutually exclusive sheets, alerts, or navigation destinations.
- Do not create a screen from many large computed `some View` properties when dedicated subviews would be clearer.
- Do not silently remove iOS 17 or earlier support when adopting newer Observation or SwiftUI APIs.

## Output

Use `references/output-contract.md`.
