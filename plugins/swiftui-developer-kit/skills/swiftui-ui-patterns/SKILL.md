---
name: swiftui-ui-patterns
description: Build or refactor one SwiftUI screen's composition, presentation state, navigation, sheets, async loading, previews, accessibility, and adaptive view structure.
---

# SwiftUI UI Patterns

Use this skill when shaping one SwiftUI screen, refactoring view structure, choosing state wrappers, wiring navigation or sheets, or reviewing UI composition. Use `swiftui-feature-builder` instead when the request adds an end-to-end capability involving domain behavior, persistence, services, or cross-screen data flow.

## References

- Read `references/state-ownership.md` when deciding where state lives or which property wrapper to use.
- Read `references/navigation-sheets.md` when routing, presenting sheets, alerts, popovers, or split navigation.
- Read `references/ipad-mac-adaptation.md` when screens need iPad, macOS, menu bar, window, keyboard, pointer, or resizing behavior.
- Read `references/async-ui-state.md` when screens load, refresh, search, debounce, or cancel async work.
- Read `references/view-refactor-patterns.md` when splitting large views or cleaning computed `some View` helpers.
- Read `references/previews-performance.md` when adding previews, fixtures, list identity, or render-cost checks.
- Use `references/output-contract.md` for final reports.
- See the fictional workflow example at `../../examples/swiftui-ui-patterns-example.md`.

Prefer existing project conventions. When the app already has a clear architecture, improve inside that architecture instead of introducing a new pattern.

## Workflow

1. Identify the target screen, primary interaction, deployment target, and existing local patterns.
2. Choose the source of truth for state before choosing property wrappers.
3. Map navigation and modal presentation as data, using enum or item state for mutually exclusive destinations.
4. Pick an adaptive navigation model: tab, stack, sidebar/detail, inspector, or multiwindow.
5. Keep resizing, rotation, and multiwindow behavior non-destructive.
6. Keep async work cancellable and tied to view lifecycle or explicit user actions.
7. Split complex screens into dedicated subview types with small explicit inputs.
8. Add previews for important states when the project supports previews.
9. Check accessibility, Dynamic Type, and stable identity for lists, grids, and frequently updating views.
10. Verify with build, tests, or static checks when safe and relevant.

## Guardrails

- Do not add a ViewModel just to mirror local view state.
- Do not bury business logic in `body`, `.task`, `.onAppear`, `.onChange`, or button closures.
- Do not replace a working project-wide pattern for stylistic reasons.
- Do not use multiple booleans for mutually exclusive sheets, alerts, or navigation destinations.
- Do not create a screen from many large computed `some View` properties when dedicated subviews would be clearer.
- Do not hide menu, command, or toolbar actions by destroying them for ordinary state changes; disable unavailable actions instead.
- Do not leave document or multiwindow scenes unnamed when the app supports multiple windows.
- Do not silently remove iOS 17 or earlier support when adopting newer Observation or SwiftUI APIs.

## Do Not Use When

- The main task is broad architecture audit, persistence correctness, build debugging, release review, or PR drafting.
- The user wants visual taste review without changing SwiftUI structure or interaction patterns.

## Done When

- State ownership, navigation, sheets, async UI state, adaptation, previews, and accessibility are addressed.
- Recommendations fit existing project conventions and avoid unnecessary architecture changes.
- Output includes concrete SwiftUI changes and safe verification steps.

## Output

Use `references/output-contract.md`.

Follow `../../docs/skill-quality-standard.md` and compare `../../examples/skill-outputs/swiftui-ui-patterns-bad-output.md` with `../../examples/skill-outputs/swiftui-ui-patterns-good-output.md`.
