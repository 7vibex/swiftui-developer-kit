# SwiftData Persistence Audit

## Executive Summary

- Overall persistence risk: high.
- Highest data-loss risk: irreversible session deletion.
- Highest performance risk: not inspected.
- Highest migration or reopen risk: delete/undo behavior after reopening.

## Schema Map

- Model: `StudySession` with related cards.
- Identity: not inspected.
- Relationships and delete rules: cascade from session to cards.
- Attachments or external files: not inspected.
- Migration version: not inspected.

## Data Loss Risks

- Risk: session deletion has no recovery boundary.
- Evidence: `FictionalStudyApp/Sources/Data/StudyRepository.swift` deletes the graph without undo or transaction result.
- Severity: critical.
- User impact: an accidental delete permanently removes study history.
- Safer behavior: return a recoverable snapshot and expose undo.
- Save or transaction boundary: repository transaction.
- Undo or recovery: explicit undo token.
- Verification: create, delete, undo, save, close, and reopen.
- Confidence: high.
- Missing evidence: existing-store migration behavior.

## Performance Risks

Not inspected; no query-shape claim is made.

## Migration Risks

- Risk: undo behavior across an existing store is unverified.
- Evidence: no migration fixture was supplied.
- Existing-store scenario: restore a deleted session after relaunch.
- Migration direction: define before schema changes.
- Fixture or test needed: seeded existing-store reopen fixture.

## Reopen Contracts

- Object or flow: session delete then undo.
- Commit point: transaction completion.
- Reopen scenario: new repository instance after save.
- Expected persisted state: original graph restored.
- Missing test: `SessionDeleteTests.testDeleteUndoAndReopenRestoresGraph()`.

## Model Relationship Issues

- Model: `StudySession`.
- Relationship: session-to-cards cascade.
- Risk: destructive cascade lacks recovery.
- Fix direction: transaction plus recoverable snapshot.

## Query Improvements

Not inspected; do not invent a query optimization.

## Recommended Fix Order

- Step: add transactional undo.
- Why first: prevents permanent data loss.
- Test to add: delete/undo/reopen regression.

## Codex Fix Prompts

- Prompt: inspect `StudyRepository`, add a recoverable delete transaction, and write the reopen regression test using fictional data only.
- Files to inspect first: repository, model relationships, existing persistence tests.
- Verification command or manual flow: run the focused test; only build/run with host approval.
