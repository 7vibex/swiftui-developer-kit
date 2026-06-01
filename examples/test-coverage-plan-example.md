# Test Coverage Improvement Plan

## Current Test Structure

- `StudyOSTests`
- `StudyOSUITests`
- No dedicated SwiftData migration tests.

## Major Gaps

- Notebook search has no predicate tests.
- AI Tutor async cancellation is untested.
- Planner date grouping has no regression coverage.
- Flashcard delete flow lacks data-loss tests.

## Highest-Impact Tests

1. Notebook search returns matching notes without loading unrelated notebooks.
2. AI Tutor cancels stale prompt requests.
3. Deleting a flashcard deck requires confirmation and preserves unrelated decks.
4. Planner groups tasks by local calendar week.

## Suggested Test Files

- `StudyOSTests/NotebookSearchTests.swift`
- `StudyOSTests/AITutorViewModelTests.swift`
- `StudyOSTests/FlashcardPersistenceTests.swift`
- `StudyOSTests/PlannerGroupingTests.swift`

## Example Test Cases

- `testSearchUsesPredicateForNotebookScope`
- `testPromptChangeCancelsPreviousTutorRequest`
- `testDeckDeleteDoesNotRemoveUnrelatedCards`
- `testPlannerGroupsTasksByStartOfWeek`

## Verification Commands

```bash
xcodebuild test -workspace StudyOS.xcworkspace -scheme StudyOS -destination 'platform=iOS Simulator,name=iPad Pro (11-inch)'
```
