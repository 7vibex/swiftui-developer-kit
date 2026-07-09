# SwiftUI Architecture Audit

## Executive Summary

StudyOS has a clear screen structure, but `HomeView` and `NotebookView` own too much state and trigger persistence directly from view actions.

## Critical Issues

- None in this fictional review.

## High Priority Issues

- `NotebookView` mixes editing state, save scheduling, and SwiftData fetch logic.
- `AITutorPanel` starts uncancelled tasks when prompts change quickly.

## Medium Priority Issues

- `PlannerView` duplicates date grouping logic also used on Home.
- Several icon-only buttons are missing labels.

## Dead Code / Red Flags

- `LegacyDeckView` appears unused after the Flashcards redesign.
- Custom blur modifiers duplicate system material behavior.

## Recommended Fix Order

1. Extract notebook editing state into a focused observable model.
2. Add cancellation to AI Tutor prompt tasks.
3. Move planner grouping into a small domain helper.
4. Remove unused legacy flashcard views after confirming routes.

## Codex Fix Prompts

```text
Use the swiftui-architecture-auditor skill. Refactor NotebookView so editing state and save scheduling live outside the view.
```
