# Skill-Guided Fixture: router-detect-risks

- Severity: High
- Evidence: `scanner/Fixtures/Positive.swift` - The request should start with the read-only scanner, then route confirmed architecture and persistence findings.
- User impact: Reading everything first wastes evidence budget and can mix deterministic signals with speculation.
- Fix: Use high-confidence detect-risks routing with explicit specialist handoff prompts.
- Verification: Confirm the expected scanner rules and stop before build or capture without approval.
- Confidence: high for the cited source-level decision.
- Missing evidence: No runtime or screenshot evidence is required for the excluded fixture.
- Safety: No screenshot, private data, destructive action, or unapproved build is required for this fixture.
