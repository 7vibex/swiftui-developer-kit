# Skill-Guided Fixture: ui-patterns-sheet-routing

- Severity: High
- Evidence: `scanner/Fixtures/Positive.swift` - Multiple Boolean-driven sheets should become one item-backed presentation route.
- User impact: Rapid actions can overlap presentations or preserve stale selected state.
- Fix: Replace mutually exclusive flags with one `Identifiable` route and `.sheet(item:)`.
- Verification: Add rapid-presentation and dismissal tests.
- Confidence: high for the source-level pattern.
- Missing evidence: Multiwindow restoration is not represented in the fixture.
- Safety: No build, launch, or capture is required for the static fixture.
