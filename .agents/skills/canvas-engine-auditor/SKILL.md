---
name: canvas-engine-auditor
description: Audit SwiftUI, PencilKit, Apple Pencil, zoom/pan, gesture, ink, infinite canvas, layer, PDF annotation, persistence, performance, and regression risks in iPad canvas apps.
---
# Canvas Engine Auditor

Audit drawing, handwriting, annotation, infinite-canvas, and Apple Pencil workflows in SwiftUI/iPadOS apps. Use this skill when a project has canvas problems: strokes disappear, highlighter opacity compounds badly, zoom/pan breaks coordinates, PencilKit does not update, tool picker state is unstable, layers drift after reopening, PDF/background alignment is wrong, undo/redo corrupts data, or the canvas feels laggy.

## References
- `references/apple-doc-links.md`
- `references/canvas-engine-checklist.md`
- `references/pencilkit-bridge-checklist.md`
- `references/gesture-coordinate-checklist.md`
- `references/ink-tool-checklist.md`
- `references/persistence-regression-checklist.md`
- `references/performance-checklist.md`
- `references/test-matrix.md`
- `references/output-contract.md`

Prefer targeted search, project maps, existing tests, simulator evidence, and bundled scripts before reading many files. Do not guess about canvas behavior without tracing the input path, render path, persistence path, and verification path.

## Check
- Rendering engine: SwiftUI `Canvas`, PencilKit `PKCanvasView`, custom CoreGraphics/Metal, PDFKit overlay, or hybrid.
- Input model: Apple Pencil, finger drawing, Scribble, keyboard/mouse, trackpad, pointer, hover, squeeze, lasso, eraser, selection, drag, pinch, zoom, pan.
- Coordinate model: document space, viewport space, screen/global space, named SwiftUI coordinate spaces, scroll/zoom transforms, PDF/page transforms.
- Tool model: pen, pencil, marker/highlighter, eraser, lasso, shape, image, text box, sticky note, AI element, custom tools, opacity and width defaults.
- State ownership: source of truth for selected tool, active page, active layer, active selection, zoom scale, content offset, pending stroke, history stack, and persistence commit.
- Persistence: strokes, layers, page transforms, canvas bounds, undo/redo history, thumbnails, PDF backgrounds, image attachments, SwiftData/CoreData/file storage, autosave and restore.
- Performance: per-point mutations, full-canvas redraws, giant SwiftUI views, unnecessary `TimelineView`, oversized bitmaps, thumbnail churn, main actor blocking, memory spikes, and energy use.
- Testing: deterministic unit tests for model transforms and persistence, regression tests for known canvas bugs, screenshot/manual verification for visual behavior, and targeted UI tests only where stable.

## Workflow
1. Identify the canvas architecture and file map. Run `scripts/detect-canvas-risks.sh .` if available, then inspect the high-risk files it reports.
2. Build a data-flow map: input event → coordinate conversion → model mutation → render update → undo/redo → persistence → restore.
3. Build a tool-state map: tool picker/custom toolbar → selected tool → stroke style → renderer/PencilKit bridge → saved representation.
4. Build a viewport map: zoom scale, content offset, page origin, canvas bounds, PDF/image background placement, minimap/viewport overlays.
5. Classify issues by severity using the output contract. Do not report generic SwiftUI advice unless it is tied to project files, symbols, tests, screenshots, or a reproducible flow.
6. Propose fixes in the safest order: data loss and restore bugs first, coordinate bugs second, gesture conflicts third, performance fourth, visual polish last.
7. For every fix, propose at least one verification step: unit test, regression test, simulator flow, screenshot comparison, or manual Apple Pencil path.
8. When code changes are made in an Apple app project, build and run on the required iPad simulator according to repository instructions. Ask before screenshots or Computer Use.

## Canvas Bug Patterns To Prioritize
- Stroke visually changes during drawing but reopens in the wrong position, wrong layer, wrong scale, or disappears.
- Highlighting becomes opaque because marker/watercolor opacity defaults are not study-friendly.
- Drag gestures block scroll/zoom gestures, or minimum-distance zero gestures hijack scrolling.
- SwiftUI local/global coordinate use changes after zooming, rotation, split view, Stage Manager, or keyboard appearance.
- `UIViewRepresentable` creates a `PKCanvasView` once but does not reconcile changed page/document/tool state in `updateUIView`.
- `PKToolPicker` appears but tool changes do not reach the active canvas because first-responder/observer lifecycle is wrong.
- Infinite canvas grows `contentSize` but does not preserve content offset, page origin, minimap, or background alignment.
- Autosave commits every point and blocks the main thread, or only saves on disappear and loses drawings after crash/backgrounding.
- Undo/redo stores huge drawings for every movement or mutates shared model references.
- UI tests try to validate raw drawing pixels instead of testing stable model/state transformations.

## Output
Use `references/output-contract.md`.
