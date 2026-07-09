# swiftui-architecture-auditor Good Output

This fictional example demonstrates the expected evidence standard.

## High: Root view owns navigation, persistence, and async loading
- Evidence: `FictionalStudyApp/Sources/App/RootView.swift` mutates route state, calls the repository, and starts refresh work.
- Confidence: high from source inspection.
- User impact: presentation and save failures can diverge, making regressions difficult to isolate.
- Fix: keep route state in an app coordinator and move persistence orchestration behind `StudyRepository`.
- Missing evidence: no runtime navigation trace or crash log was inspected.
- Verification: add presentation-routing tests and run the sample app test plan.
- Fix order: protect data and navigation behavior before splitting visual subviews.
