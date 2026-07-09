# liquid-glass-placement-auditor Good Output

This fictional example demonstrates the expected evidence standard.

## Use selectively: notebook toolbar
- Evidence: `FictionalStudyApp/Sources/Notebook/NotebookEditorView.swift` separates fixed controls from the editor surface.
- Surface: chrome. Decision: use regular glass on iOS 26 or newer; keep editor content opaque.
- SDK verified: yes against Xcode 26.5 in the repository API probe.
- Confidence: medium until visual runtime review is approved.
- Older-OS fallback: existing semantic toolbar material.
- Accessibility fallback: opaque background under Reduce Transparency and verified contrast under Increase Contrast.
- Avoid: notes, forms, warning text, and destructive confirmations.
- Verification: build, inspect Dynamic Type and contrast, then request approval before any screenshot capture.
