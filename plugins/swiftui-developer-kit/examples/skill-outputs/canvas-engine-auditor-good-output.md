# Canvas Engine Audit

## Canvas Architecture Map

- Rendering engine: `PKCanvasView` bridge.
- Input path: PencilKit delegate to view model.
- Coordinate spaces: not fully inspected.
- State owners: editor owns the bridge; repository should own persisted drawings.
- Persistence path: missing drawing-change callback.
- Hardware-only input paths: Pencil latency and squeeze untested.

## Findings Table

| Severity | Area | Evidence | User impact | Fix | Verification | Confidence | Missing evidence |
| --- | --- | --- | --- | --- | --- | --- | --- |
| High | persistence | `FictionalStudyApp/Sources/Canvas/CanvasEditorView.swift` has no `canvasViewDrawingDidChange` save path | Strokes can disappear after reopen | Debounce a repository save behind one source of truth | Draw, close, reopen, switch page, undo, reopen; add `CanvasPersistenceTests` | High | Real Pencil latency and squeeze behavior |

## Fix Order

1. Add a durable drawing-save path.
2. Verify coordinate conversion before gesture polish.
3. Audit tool state and undo/redo after persistence is safe.

## Regression Tests To Add

- `CanvasPersistenceTests.testDrawingSurvivesCloseAndReopen()` — prevents lost strokes.
- `CanvasPersistenceTests.testUndoAfterRestore()` — prevents history corruption after reload.

## Canvas Verification Matrix

- [ ] Zoom and pan preserve coordinates.
- [ ] Draw → close → reopen restores content.
- [ ] Undo/redo works after restore.
- [ ] Apple Pencil-specific behavior is tested on supported hardware.
- [ ] Non-Pencil input remains accessible.

## Codex Fix Prompts

1. Inspect the canvas delegate and repository, add one debounced persistence path, and add the reopen regression test. Do not capture handwriting.
2. Trace coordinate conversion only after the persistence test passes; verify with a non-sensitive fixture.

## Safety And Approval Boundary

No private handwriting, screenshot, or live canvas capture was used. Build/run and any device-specific Pencil verification require the user or host project's approval.
