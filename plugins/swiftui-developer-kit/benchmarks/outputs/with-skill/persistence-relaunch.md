# Skill-Guided Fixture: persistence-relaunch

- Severity: High
- Evidence: `scanner/Fixtures/Positive.swift` - ModelContext delete has no confirmation or recovery signal.
- User impact: An accidental destructive action can permanently remove user data.
- Fix: Add confirmation or undo behind a repository transaction.
- Verification: Run the delete-recovery rule and add delete-undo-reopen coverage in a host app.
- Confidence: high for the cited source-level decision.
- Missing evidence: No host-app store, migration, or transaction boundary was inspected.
- Safety: No screenshot, private data, destructive action, or unapproved build is required for this fixture.
