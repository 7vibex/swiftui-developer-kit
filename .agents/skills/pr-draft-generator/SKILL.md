---
name: pr-draft-generator
description: Generate high-quality pull request titles, branch names, descriptions, testing checklists, risk notes, reviewer notes, and release notes for SwiftUI/iOS/iPadOS/macOS changes.
---

# PR Draft Generator

Generate clear pull request material from the actual diff and project context.

## References

- `references/pr-template.md`
- `references/review-risk-checklist.md`
- `references/output-contract.md`

## Workflow

1. Inspect branch name, status, and diff.
2. Summarize user-visible and developer-facing changes.
3. List tests and verification actually run.
4. Call out risks, screenshots needed, accessibility impact, release metadata impact, and Apple-source claims.
5. Draft reviewer checklist and release notes.

## Do Not Use When

- There is no diff, branch, change summary, or release note material to draft from.
- The user needs code review findings or implementation work before PR text.

## Done When

- Title, summary, testing, risk, reviewer notes, and release notes match inspected changes.
- Unverified tests, screenshots, Apple API claims, and release risks are called out honestly.

## Output

Use `references/output-contract.md`.

Follow `../../../docs/skill-quality-standard.md` and compare `../../../examples/skill-outputs/pr-draft-generator-bad-output.md` with `../../../examples/skill-outputs/pr-draft-generator-good-output.md`.
