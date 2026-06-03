# Previews And Performance

Previews and performance checks should make common UI states easy to inspect without requiring live services.

## Previews

- Add previews for loaded, empty, error, and long-content states when those states exist.
- Use fictional fixtures and mock services.
- Inject environment dependencies explicitly so previews show wiring problems early.
- Include Dynamic Type or narrow-width previews for dense screens.
- Keep preview fixtures small and local unless many screens reuse them.

## Performance Checks

- Use stable IDs in lists and grids.
- Keep observation scope narrow; do not make the whole screen observe a large model when one subsection changes.
- Prefer lazy containers for large vertical or grid content.
- Avoid expensive formatting, sorting, or filtering directly in `body` when inputs do not change every render.
- Avoid `AnyView` unless type erasure is genuinely needed.
- Watch for top-level conditional branch swapping that invalidates the whole screen.

## Accessibility During Pattern Work

- Label icon-only buttons and custom controls.
- Preserve semantic controls before replacing them with custom gestures.
- Respect Dynamic Type, Reduce Motion, and Reduce Transparency.
- Keep hit targets large enough for repeated use.
