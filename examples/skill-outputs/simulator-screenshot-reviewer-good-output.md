# simulator-screenshot-reviewer Good Output

This fictional example demonstrates the expected evidence standard.

## High: Primary action clips at larger text sizes
- Evidence: user-approved fictional `01-home-accessibility.png`; no source code was inspected.
- Confidence: medium because the finding is screenshot-only.
- User impact: the start-session label is truncated and the tap target is ambiguous.
- Fix: allow the label to wrap, remove the fixed height, and preserve a 44-point minimum target.
- Missing evidence: landscape, Split View, VoiceOver order, and the backing SwiftUI layout.
- Verification: request updated screenshots only after explicit approval and inspect at accessibility text sizes.
- Privacy: confirm the screen contains fictional data before any follow-up capture.
