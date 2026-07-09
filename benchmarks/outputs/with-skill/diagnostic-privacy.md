# Skill-Guided Fixture: diagnostic-privacy

- Severity: High
- Evidence: `examples/diagnostic-report.sample.json` - Privacy flags are false and redactions are listed, but schema validation remains required.
- User impact: A hand-edited report could add unknown fields or invalidate privacy guarantees.
- Fix: Validate versioned JSON before export and fail closed on privacy flags.
- Verification: Run schema validation and redaction tests with token-shaped and note-shaped fixtures.
- Confidence: high for the cited source-level decision.
- Missing evidence: Retention, remote upload, and host-app logs were not inspected.
- Safety: No screenshot, private data, destructive action, or unapproved build is required for this fixture.
