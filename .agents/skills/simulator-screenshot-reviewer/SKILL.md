---
name: simulator-screenshot-reviewer
description: Capture, organize, and review iOS/iPadOS Simulator screenshots for SwiftUI UI problems, layout issues, visual hierarchy, clipping, spacing, readability, and screenshot-based design feedback. Use when the user asks Codex to look at the app running in Simulator.
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

## Output

Use `references/output-contract.md`.
