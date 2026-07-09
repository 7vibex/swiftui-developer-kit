# PencilKit Bridge Checklist

## `UIViewRepresentable`
- `makeUIView` should create and configure the `PKCanvasView` once.
- `updateUIView` should reconcile external state changes without resetting active drawings unnecessarily.
- Coordinator should handle delegate callbacks and avoid retain cycles.
- Bindings should not overwrite in-progress drawings during SwiftUI updates.
- Tool picker visibility, observers, and first-responder state should be tied to the active canvas lifecycle.

## Tool Picker
- Verify whether the app uses system `PKToolPicker`, a custom SwiftUI toolbar, or both.
- Ensure selected tool changes propagate to the actual active canvas.
- If using custom tools, define what is rendered by PencilKit versus the app's own renderer.
- If the picker is minimized, actions such as add text/background should still be available elsewhere.

## Saving
- Use change callbacks to mark dirty state, but debounce expensive persistence.
- Do not serialize the entire drawing on every point movement unless explicitly justified.
- Store drawing data with page/layer ids and schema/version metadata.
- Restore should be tested after app relaunch, page switch, layer toggle, zoom/pan, and rotation.

## Common Failure Modes
- Drawing disappears because SwiftUI recreates the wrapper and assigns a blank drawing.
- Tool picker shows but selected tools do not work because the canvas is not first responder or not observing the picker.
- Background images drift because `PKCanvasView` zoom/content offset is not synchronized with the background view.
- Undo/redo is inconsistent because PencilKit undo and app model undo are both active without a clear boundary.
