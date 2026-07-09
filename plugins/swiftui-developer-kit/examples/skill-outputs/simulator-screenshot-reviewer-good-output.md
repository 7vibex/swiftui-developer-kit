# Simulator Screenshot Review

## Capture Mode

User-approved, fictional screenshot-only review. No source code was inspected.

## Screens Captured

- `01-home-accessibility.png` — fictional Home screen at larger text size.

## Visual Issues

The primary action appears visually compressed at the bottom of the screen.

## Layout Issues

### High: Primary action clips at larger text sizes

- Severity: high.
- Evidence: user-approved fictional `01-home-accessibility.png`.
- User impact: the start-session label is truncated and the tap target is ambiguous.
- Fix: allow the label to wrap, remove fixed height, preserve a 44-point minimum target.
- Verification: request an updated screenshot only after explicit approval.
- Confidence: medium because this is screenshot-only.
- Missing evidence: landscape, Split View, and backing SwiftUI layout.

## Readability Issues

The clipped label is not reliably readable at the inspected text size.

## Accessibility Risks

VoiceOver order and Dynamic Type behavior beyond this screenshot are unverified.

## Recommended Fixes

Remove the fixed height, allow multiline text, then verify landscape and Split View with fictional data.

## Follow-up Screenshots Needed

Request approved fictional captures for landscape, Split View, and the fixed accessibility-text state.
