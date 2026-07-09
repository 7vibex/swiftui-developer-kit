# Canvas Engine Checklist

## Engine Identification
- Determine whether the screen uses `PKCanvasView`, PaperKit, SwiftUI `Canvas`, `UIViewRepresentable`, `PDFKit`, CoreGraphics, Metal, or a hybrid.
- Identify one source of truth for document/page/layer/stroke state.
- Identify whether the renderer is model-driven, view-state-driven, or both.
- Identify whether visual changes are committed live, on stroke end, on page change, on app background, or on view disappear.
- Identify whether rich markup objects such as shapes, images, text boxes, and PDF annotations are modeled separately from raw strokes.

## Model Boundaries
- Canvas document: id, title, pages, page order, created/modified timestamps.
- Page: id, size, background, page origin, template/PDF page index, layers, thumbnail.
- Layer: id, visibility, lock state, z-order, opacity, elements.
- Element: stroke, image, text box, sticky note, shape, AI annotation, selection frame.
- Viewport: zoom scale, content offset, visible rect, rotation/orientation, safe area, keyboard offset.
- PDF overlay: source document id, page id, page index, crop/rotation, overlay element ids, export state.

## Red Flags
- Canvas model stored directly inside a giant SwiftUI view.
- Multiple independent selected-tool states in toolbar, view model, PencilKit, and renderer.
- `@State` owns persistent document data that should be owned by a repository/view model.
- Page/layer ids are optional or recreated on every render.
- Renderer depends on array index instead of stable ids.
- Delete/move/resize operations mutate view-only copies and never commit to repository.
- Background/PDF image and strokes use different coordinate origins.
- `PKToolPicker.shared(for:)` appears in new code instead of current tool-picker lifecycle patterns.
- `PKCanvasView` exists without a drawing-change hook, debounce, or persistence commit path.
- `PDFPageOverlayViewProvider` exists without annotation/export/save and reopen verification.
- PaperKit would solve required markup objects, but the app hand-rolls shapes, images, text, and drawing persistence without a clear model.
- Apple Pencil squeeze, hover, or roll behavior is custom but does not respect user preferences or lacks a non-Pencil fallback.

## Required Evidence
For each finding, cite a path, symbol, test, screenshot, or reproducible flow. Avoid generic advice.
