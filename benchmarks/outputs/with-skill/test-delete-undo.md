# Skill-Guided Fixture: test-delete-undo

- Severity: Critical
- Evidence: `examples/skill-outputs/swiftdata-persistence-auditor-good-output.md` - A delete, undo, and reopen regression test protects against permanent data loss.
- User impact: An accidental delete can permanently remove a user's history.
- Fix: Add a repository regression fixture that deletes, undoes, saves, and reopens the graph.
- Verification: Run the focused test twice to detect order dependence.
- Confidence: high for the documented persistence risk.
- Missing evidence: Existing-store migration behavior is outside this fixture.
- Safety: Use fictional fixture data and do not copy a production store.
