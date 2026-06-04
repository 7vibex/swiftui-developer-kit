# Persistence And Regression Checklist

## Save/Restore Matrix
Test these flows before treating a canvas fix as done:
- Draw stroke → switch page → return.
- Draw stroke → close document → reopen document.
- Draw stroke → background app → relaunch.
- Move/resize element → reopen document.
- Delete element/layer/page → reopen document.
- Undo/redo after draw, erase, move, resize, layer change, page change.
- Change zoom/pan → save → reopen and verify viewport restore if expected.
- Import PDF/image → annotate → reopen and verify alignment.

## Data Loss Risks
- Autosave only on view disappear.
- Writes swallowed without user-visible error.
- Delete cascades not tested.
- Drawing data stored without versioning.
- File attachments stored only in temporary paths.
- SwiftData/CoreData objects mutated on the wrong actor or outside a transaction.
- Thumbnails treated as source of truth instead of derived cache.

## Regression Test Targets
Prefer model-level tests for:
- Coordinate conversion.
- Tool state transitions.
- Layer ordering.
- Selection hit testing.
- Undo/redo stack behavior.
- Serialization/deserialization.
- Document/page/layer deletion.
- Highlighter default opacity.
