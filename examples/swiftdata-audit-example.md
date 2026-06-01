# SwiftData Persistence Audit

## Executive Summary

StudyOS uses SwiftData for notes, flashcards, and planner tasks. The biggest risks are in-memory filtering for large note sets and deletes that can remove study history without confirmation.

## Data Loss Risks

- Deleting a notebook cascades to flashcards without a visible confirmation. Severity: critical. Evidence: notebook delete flow reaches related decks before a user-facing confirmation step.
- Seed data import can create duplicates when run twice. Severity: high. Evidence: import path matches on display title instead of stable external ID.

## Performance Risks

- Notebook search fetches all notes and filters in memory. Query improvement: use a `#Predicate` scoped to notebook ID and search text.
- Planner fetches all tasks before grouping by week. Query improvement: fetch only visible date range and sort by due date.

## Migration Risks

- `StudyNote.title` was renamed from `name` without a documented migration. Existing-store scenario: users upgrading from v0.1 may lose visible note titles.
- New required `createdAt` fields need defaults for existing stores. Existing-store scenario: migration fails or assigns misleading dates.

## Model Relationship Issues

- Flashcard deck inverse relationship is implicit and should be verified.

## Query Improvements

- Add predicates for notebook search.
- Add sort descriptors for planner due dates.

## Recommended Fix Order

1. Add delete confirmation and tests.
2. Replace in-memory search filtering with predicates.
3. Add migration plan for renamed fields.

## Codex Fix Prompts

```text
Use the swiftdata-persistence-auditor skill. Review delete flows for Notebook and FlashcardDeck and propose safe confirmations.
```
