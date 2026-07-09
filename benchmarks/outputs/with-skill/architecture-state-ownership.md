# Skill-Guided Fixture: architecture-state-ownership

- Severity: Medium
- Evidence: `scanner/Fixtures/Positive.swift` - Multiple boolean-driven sheets and an unstructured lifecycle task concentrate presentation and async behavior in one view.
- User impact: Presentation routes can conflict and lifecycle work can outlive the view.
- Fix: Use one enum-backed presentation route and cancellation-aware task ownership.
- Verification: Run the multiple-presentation and lifecycle-task scanner rules.
- Confidence: high for the cited source-level decision.
- Missing evidence: No runtime navigation trace was inspected.
- Safety: No screenshot, private data, destructive action, or unapproved build is required for this fixture.
