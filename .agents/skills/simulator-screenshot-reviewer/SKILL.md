---
name: simulator-screenshot-reviewer
description: Review user-approved iOS/iPadOS Simulator screenshots for SwiftUI layout, clipping, spacing, readability, visual hierarchy, and screenshot-based UI feedback.
---

# Simulator Screenshot Reviewer

Capture and review Simulator screenshots only after user approval.

## Required Questions Before Capture

Ask:

- Is Simulator open?
- Which screen should be captured?
- Is anything sensitive/private visible?

Do not capture until the user confirms the target screen and privacy state.

## References

- Use `references/privacy-checklist.md` before capture.
- Use `references/screenshot-workflow.md` for capture and inventory flow.
- Use `references/ui-review-checklist.md` for review.
- Use `references/output-contract.md` for the report.

## Supported Capture Modes

- Appshots, if available and approved.
- Shell fallback with `scripts/capture-simulator-screenshot.sh`.
- Manual screenshots attached by the user.

## Workflow

1. Confirm Simulator is open and the intended screen is visible.
2. Confirm no sensitive/private information is visible.
3. Ask for the screen name.
4. Capture with the approved method.
5. Create or update screenshot inventory.
6. Review visual hierarchy, layout, readability, clipping, spacing, and accessibility risks.
7. Ask for follow-up screenshots only when they materially affect the review.

## Do Not Use When

- The user has not approved capture or supplied screenshots.
- The task can be answered from code, build logs, or release metadata without visual evidence.

## Done When

- Capture consent, screen names, and privacy state are recorded or screenshots are user-supplied.
- Layout, clipping, readability, hierarchy, spacing, and accessibility risks are reviewed per screen.
- Output distinguishes screenshot-backed confidence from missing code or runtime evidence.

## Output

Use `references/output-contract.md`.

Follow `../../../docs/skill-quality-standard.md` and compare `../../../examples/skill-outputs/simulator-screenshot-reviewer-bad-output.md` with `../../../examples/skill-outputs/simulator-screenshot-reviewer-good-output.md`.
