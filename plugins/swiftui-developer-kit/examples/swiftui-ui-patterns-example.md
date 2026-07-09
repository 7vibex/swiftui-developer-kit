# SwiftUI UI Patterns Review

## Recommended Pattern

Refactor StudyOS `TaskBoardView` around one typed sheet enum, a stable `NavigationStack`, and dedicated section views for filters, task rows, and empty state.

## Why

The screen currently uses separate booleans for add, edit, and duplicate sheets. It also keeps filtering, row rendering, and save actions inside one large body, which makes route changes and preview states harder to reason about.

## Risks Avoided

- Two sheets competing when users tap actions quickly.
- Child views editing copied state that does not write back to the board.
- Repeated async reloads when filter changes happen quickly.
- List identity churn from using array offsets in `ForEach`.

## Files Or Symbols To Change

- `TaskBoardView`: replace sheet booleans with `ActiveSheet`.
- `TaskFilterSection`: extract filter controls with a binding to selected filter.
- `TaskRowsSection`: render rows with durable task IDs.
- `TaskBoardPreviewData`: add loaded, empty, and error fixtures.

## Verification

- Build the app after refactor.
- Check add, edit, duplicate, and dismiss flows.
- Preview loaded, empty, and long-title states.
- Confirm icon-only row actions have accessibility labels.
