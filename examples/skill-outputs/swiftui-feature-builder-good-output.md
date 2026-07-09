# swiftui-feature-builder Good Output

This fictional example demonstrates the expected evidence standard.

## Feature: enum-backed study sheet routing
- Evidence changed: `FictionalStudyApp/Sources/App/StudyRoute.swift` and `RootView.swift`.
- State owner: the root coordinator owns one optional sheet route.
- User impact: mutually exclusive sheets can no longer overlap or present stale content.
- Accessibility: sheet titles are visible and initial focus is defined.
- Missing evidence: no screenshot review was requested.
- Tests: add `PresentationRoutingTests` for rapid route changes and dismissal.
- Verification: run the sample test plan, build for the approved iPad mini simulator, and launch without capture.
- Confidence: high after tests and build pass.
