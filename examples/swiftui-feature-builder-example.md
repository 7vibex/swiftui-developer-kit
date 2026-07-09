# SwiftUI Feature Builder Example

This fictional example shows an end-to-end feature request that belongs in `swiftui-feature-builder`, rather than a one-screen UI-pattern refactor.

## Request

Add an offline favorites capability to a fictional iPad recipe app. A user can save a recipe from a detail screen, see it in Favorites after relaunch, and remove it with undo.

## Scope Decision

This changes domain behavior, persistence, data flow, and more than one screen. It belongs in `swiftui-feature-builder`; a screen-only sheet or layout cleanup would belong in `swiftui-ui-patterns`.

## Plan

1. Inspect the existing recipe model, repository, app route, and tests.
2. Add a persisted favorite identity in the existing data layer instead of storing state only in the detail view.
3. Inject the repository into both detail and Favorites entry points through existing app boundaries.
4. Make removal recoverable with an undo action that restores the persisted record.
5. Add accessibility labels and dynamic labels for the favorite state.
6. Add focused repository and route tests before requesting an approved build/run.

## Files Likely To Change

- `Sources/Recipes/RecipeRepository.swift` — persisted favorite operations.
- `Sources/Recipes/RecipeDetailView.swift` — favorite action and accessible state.
- `Sources/Favorites/FavoritesView.swift` — list source and empty state.
- `Tests/RecipeRepositoryTests.swift` — save/remove/undo/relaunch coverage.

## Verification

- Run focused repository tests.
- Confirm save → relaunch → Favorites contains the item.
- Confirm remove → undo → relaunch restores the item.
- Build/run only when the user or host project authorizes it; screenshots remain separately approval-gated.

## Expected Report Boundaries

The final report should name files changed, tests actually run, missing runtime evidence, accessibility impact, oldest-supported-OS behavior, and any remaining release/privacy risk.
