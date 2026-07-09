# Skill-Guided Fixture: accessibility-sidebar

- Severity: Medium
- Evidence: `scanner/Fixtures/Negative.swift` - The labeled button and separate decorative image should not be reported as an unlabeled symbol button.
- User impact: A false positive wastes review time and can encourage unnecessary accessibility changes.
- Fix: Scope the rule to the Button syntax subtree instead of the whole file.
- Verification: Run the structured scanner core test for syntax-local button labels.
- Confidence: high for the cited source-level decision.
- Missing evidence: Runtime VoiceOver behavior is outside this static fixture.
- Safety: No screenshot, private data, destructive action, or unapproved build is required for this fixture.
