# SwiftUI Component Guidelines

- Keep views small enough to understand without scrolling through unrelated behavior.
- Put business logic in models, ViewModels, services, repositories, or focused helpers.
- Use `@State` for local view-only state.
- Use `@Binding` for parent-owned editable state.
- Use `@StateObject` or `@Observable` ownership at stable boundaries.
- Use `@ObservedObject` for injected object observation where ownership lives elsewhere.
- Use `@Environment` for platform and app-wide context, not hidden business dependencies.
- Keep navigation declarations close to the screen or coordinator that owns the route.
- Keep async work cancellable and update UI on the main actor.
- Prefer platform controls and SF Symbols before custom controls.
- Add accessibility labels for icon-only controls and custom drawing.
- Respect Dynamic Type, Reduce Motion, and Reduce Transparency.
