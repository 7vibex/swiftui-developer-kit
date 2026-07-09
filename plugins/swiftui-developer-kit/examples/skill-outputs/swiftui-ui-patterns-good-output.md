# SwiftUI UI Patterns Review

## Recommended Pattern

- Primary navigation: existing app navigation remains unchanged.
- Presentation: one item-backed sheet route.
- State owner: root coordinator owns `StudySheet?`; child views send intents.
- Adaptation: preserve current multiwindow behavior until inspected.

## Why

`FictionalStudyApp/Sources/App/RootView.swift` has two mutually exclusive Boolean sheet flags. One enum-backed route prevents conflicting presentation and stale selected data.

## Risks Avoided

- Severity: high.
- User impact: rapid actions cannot queue overlapping sheets.
- Fix: replace Booleans with one `Identifiable` enum and `.sheet(item:)`.
- Verification: add rapid-presentation/dismissal tests; build/run only with approval.
- Confidence: high from source inspection.
- Missing evidence: multiwindow restoration.

## Files Or Symbols To Change

- `RootView` presentation state.
- `StudySheet` route type.

## Verification

Run focused presentation tests. No UI operation or capture is required for source-level review.
