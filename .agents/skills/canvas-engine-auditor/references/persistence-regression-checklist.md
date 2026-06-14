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
- Annotate PDF → export/share → reopen exported PDF and verify annotation placement.
- Annotate rotated, cropped, reordered, and mixed-size PDF pages.
- Draw with Pencil → switch input to finger/pointer/keyboard → verify tool state and undo history.
- Use hover or squeeze tools → close and reopen → verify only committed markup persisted.

## Data Loss Risks
- Autosave only on view disappear.
- Writes swallowed without user-visible error.
- Delete cascades not tested.
- Drawing data stored without versioning.
- File attachments stored only in temporary paths.
- PDF overlay views treated as the persisted source of truth.
- PaperKit or PencilKit data written without a declared file format, schema version, or migration path.
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
- PDF overlay save/export/reopen.
- PaperKit document save/load if adopted.
