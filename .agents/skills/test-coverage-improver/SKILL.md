---
name: test-coverage-improver
description: Improve SwiftUI, SwiftData, iOS, iPadOS, macOS, ViewModel, repository, service, and regression test coverage by finding gaps and proposing high-impact tests.
---

# Test Coverage Improver

Find high-impact missing tests and propose focused additions.

## References

- `references/testing-strategy.md`
- `references/viewmodel-test-checklist.md`
- `references/repository-test-checklist.md`
- `references/regression-test-checklist.md`
- `references/output-contract.md`

Prefer targeted search, project maps, and bundled scripts before reading many files.

## Check

- Test targets and test frameworks.
- Missing ViewModel tests.
- Missing repository tests.
- Missing service tests.
- Missing regression tests.
- Missing async tests.
- Missing persistence tests.
- Missing save/reopen, migration, and destructive-flow tests.
- Missing canvas, PDF overlay, and Apple Pencil regression tests.
- Missing accessibility common-task tests for store-facing claims.
- Missing UI state tests.

## Workflow

1. Detect test targets manually or with `scripts/detect-test-targets.sh`.
2. Map high-risk code to existing tests.
3. Prioritize tests that catch regressions in user-visible behavior.
4. Separate stable model/repository tests from fragile screenshot-only tests.
5. Provide example test cases and verification commands.

## Do Not Use When

- The user needs implementation, build debugging, release review, or visual design feedback first.
- No app code, test target, or high-risk behavior can be inspected.

## Done When

- Existing test targets and high-risk untested paths are mapped.
- Recommended tests prioritize persistence, async, destructive flows, ViewModels, services, and regressions.
- Output includes concrete test cases, verification commands, and expected coverage impact.

## Output

Use `references/output-contract.md`.

Follow `../../../docs/skill-quality-standard.md` and compare `../../../examples/skill-outputs/test-coverage-improver-bad-output.md` with `../../../examples/skill-outputs/test-coverage-improver-good-output.md`.
