# Canvas Test Matrix

## Unit Tests
- Coordinate transforms: screen ↔ viewport ↔ document/page.
- Tool reducer: selected tool, width, color, opacity, eraser/lasso modes.
- Layer reducer: add, remove, reorder, visibility, lock.
- Element reducer: move, resize, rotate, select, delete.
- Undo/redo reducer: command order and snapshot/delta memory strategy.
- Serialization: save and load strokes/layers/elements without id drift.

## Integration Tests
- Repository save/restore for canvas documents.
- Import PDF/image, annotate, reopen.
- PDF overlay export and reopen for rotated, cropped, reordered, and mixed-size pages.
- PaperKit save/load, duplicate, and migration fixtures when PaperKit is adopted.
- SwiftData/file storage migration/version fallback.
- Dirty-state debounce and background-save behavior.

## UI/Simulator Verification
- Open Canvas screen.
- Draw with Pencil/finger depending on target behavior.
- Pan/zoom.
- Switch tools.
- Add text/image/sticky/AI element.
- Undo/redo.
- Change page/layer.
- Relaunch and verify restore.
- Export annotated PDF or markup document and reopen it.

## Visual/Screenshot Verification
Use screenshots for layout, overlay placement, toolbar readability, minimap visibility, and PDF/background alignment. Do not rely on screenshot pixel equality for raw Pencil strokes unless the project has a controlled deterministic renderer.

## Manual Apple Pencil Device Verification
For Apple Pencil-specific issues, simulator is not enough. Mark device-only verification clearly when pressure, hover, squeeze, roll, palm rejection, haptic/canvas feedback, or real latency matters.
