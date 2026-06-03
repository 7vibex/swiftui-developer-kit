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
- Missing UI state tests.

## Workflow

1. Detect test targets manually or with `scripts/detect-test-targets.sh`.
2. Map high-risk code to existing tests.
3. Prioritize tests that catch regressions in user-visible behavior.
4. Provide example test cases and verification commands.

## Output

Use `references/output-contract.md`.
