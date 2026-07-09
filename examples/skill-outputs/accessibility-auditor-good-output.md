# accessibility-auditor Good Output

This fictional example demonstrates the expected evidence standard.

## High: Canvas tool button has no accessible name
- Evidence: `FictionalStudyApp/Sources/Canvas/CanvasEditorView.swift`, symbol-only `Button` for the eraser.
- Confidence: high from source inspection.
- User impact: VoiceOver announces an unlabeled button, so the drawing tool cannot be identified reliably.
- Fix: use `Label("Eraser", systemImage: "eraser")` or add an equivalent accessibility label and selected-state value.
- Missing evidence: real-device VoiceOver order and Switch Control were not inspected.
- Verification: run accessibility tests, then manually complete draw, erase, and undo with VoiceOver.
- Safety: no screenshot or private content was collected.
