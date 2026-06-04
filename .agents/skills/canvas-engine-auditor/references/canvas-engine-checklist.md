# Canvas Engine Checklist

## Engine Identification
- Determine whether the screen uses `PKCanvasView`, SwiftUI `Canvas`, `UIViewRepresentable`, `PDFKit`, CoreGraphics, Metal, or a hybrid.
- Identify one source of truth for document/page/layer/stroke state.
- Identify whether the renderer is model-driven, view-state-driven, or both.
- Identify whether visual changes are committed live, on stroke end, on page change, on app background, or on view disappear.

## Model Boundaries
- Canvas document: id, title, pages, page order, created/modified timestamps.
- Page: id, size, background, page origin, template/PDF page index, layers, thumbnail.
- Layer: id, visibility, lock state, z-order, opacity, elements.
- Element: stroke, image, text box, sticky note, shape, AI annotation, selection frame.
- Viewport: zoom scale, content offset, visible rect, rotation/orientation, safe area, keyboard offset.

## Red Flags
- Canvas model stored directly inside a giant SwiftUI view.
- Multiple independent selected-tool states in toolbar, view model, PencilKit, and renderer.
- `@State` owns persistent document data that should be owned by a repository/view model.
- Page/layer ids are optional or recreated on every render.
- Renderer depends on array index instead of stable ids.
- Delete/move/resize operations mutate view-only copies and never commit to repository.
- Background/PDF image and strokes use different coordinate origins.

## Required Evidence
For each finding, cite a path, symbol, test, screenshot, or reproducible flow. Avoid generic advice.
