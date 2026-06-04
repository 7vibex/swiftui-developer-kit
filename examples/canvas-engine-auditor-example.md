# StudyOS Canvas Engine Audit Example

## Canvas Architecture Map
- Rendering engine: hybrid SwiftUI overlay plus PencilKit drawing surface.
- Input path: toolbar selected tool → drawing surface → stroke/element model → repository save.
- Coordinate spaces: visible viewport, page/document coordinates, PDF/background coordinates.
- State owners: Canvas view model owns document/page/tool/layer; PencilKit owns active drawing only while drawing.
- Persistence path: repository stores page/layer/elements; thumbnails are derived.

## Findings
| Severity | Area | Evidence | Impact | Fix | Verification |
| --- | --- | --- | --- | --- | --- |
| Critical | Persistence | `CanvasRepository.savePage` not called after layer movement | Moved elements reopen in old position | Commit layer transform on drag end and add save/restore test | `testMovedElementPersistsAfterReopen` |
| High | Coordinates | `DragGesture` uses `.global` while renderer uses page local space | Elements drift after zoom/pan | Convert screen point to document point in one boundary function | `testScreenToDocumentPointUsesZoomAndOffset` |
| High | Tool state | `selectedTool` exists in toolbar and canvas wrapper | Picker says highlighter but canvas draws pen | Make view model the source of truth and reconcile wrapper updates | Manual: switch tools, draw, reopen |
| Medium | Performance | Autosave serializes drawing in `onChanged` | Drawing stutters on long notes | Debounce save and commit on stroke end/background | Instruments + stress document |

## Fix Order
1. Save/restore of moved and drawn elements.
2. Coordinate conversion boundary.
3. Selected-tool source of truth.
4. Autosave debounce and thumbnail generation.

## Regression Tests To Add
- `CanvasCoordinateTransformTests.testScreenToDocumentPointUsesZoomAndOffset`
- `CanvasPersistenceTests.testMovedElementPersistsAfterReopen`
- `CanvasToolStateTests.testHighlighterSelectionUpdatesRenderer`
- `CanvasUndoRedoTests.testUndoRedoDoesNotChangeUnrelatedLayer`

## Codex Fix Prompt
Use the `canvas-engine-auditor` skill. Fix only the coordinate conversion path for Canvas element dragging. Inspect the canvas view, view model, and renderer files. Define one screen-to-document conversion function that accounts for zoom scale and content offset. Add regression tests for zoom 1.0, zoom 2.0, non-zero offset, and page origin. Do not redesign the UI. Build and run the iPad simulator after tests pass.
