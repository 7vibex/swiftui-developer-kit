# Skill-Guided Fixture: canvas-persistence

- Severity: High
- Evidence: `scanner/Fixtures/Positive.swift` - PKCanvasView is declared without a drawing-change callback.
- User impact: Drawing changes may never reach persistence.
- Fix: Add a delegate callback and route versioned drawing data through a save boundary.
- Verification: Run the PKCanvas change-hook rule and add save-close-reopen coverage in a host app.
- Confidence: high for the cited source-level decision.
- Missing evidence: Apple Pencil latency, hover, squeeze, and tool-picker behavior were not inspected.
- Safety: No screenshot, private data, destructive action, or unapproved build is required for this fixture.
