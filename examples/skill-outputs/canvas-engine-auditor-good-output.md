# canvas-engine-auditor Good Output

This fictional example demonstrates the expected evidence standard.

## High: Drawing changes have no persistence callback
- Evidence: `FictionalStudyApp/Sources/Canvas/CanvasEditorView.swift` owns a `PKCanvasView` bridge without a `canvasViewDrawingDidChange` save path.
- Confidence: high from source inspection.
- User impact: strokes can disappear after closing and reopening a notebook.
- Fix: route drawing changes through a debounced repository save with one documented source of truth.
- Missing evidence: Pencil latency and squeeze behavior require supported hardware.
- Verification: draw, close, reopen, switch pages, undo, and reopen again; add `CanvasPersistenceTests`.
- Safety: do not capture handwriting or private documents without explicit approval.
