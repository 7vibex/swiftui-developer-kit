# swiftui-ui-patterns Good Output

This fictional example demonstrates the expected evidence standard.

## Recommended pattern: one item-backed sheet route
- Evidence: `FictionalStudyApp/Sources/App/RootView.swift` has two mutually exclusive boolean sheet flags.
- Confidence: high from source inspection.
- State owner: the root coordinator owns `StudySheet?`; child views send intents.
- User impact: rapid actions cannot queue conflicting sheets or leave stale selected data.
- Fix: replace booleans with one `Identifiable` enum and one `.sheet(item:)`.
- Missing evidence: multiwindow restoration was not inspected.
- Verification: add rapid-presentation and dismissal tests; build and exercise both routes.
- Safety: no UI operation or capture is required for the source-level change.
