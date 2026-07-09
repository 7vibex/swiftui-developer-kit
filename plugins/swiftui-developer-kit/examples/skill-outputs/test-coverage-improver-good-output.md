# Test Coverage Improvement Plan

## Current Test Structure

The fictional app has repository tests but no delete/undo/reopen regression coverage.

## Major Gaps

Destructive session deletion has no test for undo or persistence after relaunch.

## Highest-Impact Tests

- Severity: critical.
- Test: `SessionDeleteTests.testDeleteUndoAndReopenRestoresGraph()`.
- Risk addressed: permanent loss of study history and orphaned cards.
- Type: repository regression test.
- CI tier: required unit-test tier.
- Flakiness risk: low with isolated persistent-store fixture.
- Evidence: `FictionalStudyApp/Sources/Data/StudyRepository.swift` has a delete cascade; no matching test covers undo/reopen.
- User impact: an accidental delete can become permanent.
- Fix: add a transaction-backed undo test with a fresh repository instance.
- Verification: run the focused test twice to detect order dependence.
- Confidence: high.
- Missing evidence: migration fixtures for older schemas.

## Suggested Test Files

- `FictionalStudyAppTests/SessionDeleteTests.swift`.

## Example Test Cases

- Create a session graph, delete it, undo, save, recreate the repository, and assert the graph returns.

## Verification Commands

Use the host project's focused unit-test command when approved; otherwise validate the test plan statically.

## Safety And Approval Boundary

Use fictional or isolated fixture data only. Do not copy production stores, launch an app, or capture screens without the applicable approval.
