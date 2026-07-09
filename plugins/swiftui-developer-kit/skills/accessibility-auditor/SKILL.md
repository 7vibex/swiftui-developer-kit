---
name: accessibility-auditor
description: Audit SwiftUI/iOS/iPadOS/macOS accessibility for VoiceOver, Dynamic Type, contrast, tap targets, Reduce Motion, Reduce Transparency, focus order, labels, hints, and inclusive UI behavior.
---

# Accessibility Auditor

Audit accessibility from code and screenshots when available. If screenshots are needed, ask before capture.

## References

- `references/accessibility-checklist.md`
- `references/dynamic-type-checklist.md`
- `references/voiceover-checklist.md`
- `references/reduce-motion-transparency-checklist.md`
- `references/store-label-readiness.md`
- `../../docs/apple-source-map.md`
- `references/output-contract.md`
- Worked fictional example: `../../examples/accessibility-audit-example.md`

## Check

- Labels, hints, and traits.
- Dynamic Type behavior.
- Contrast and readability.
- Tap targets.
- Color-only states.
- Reduce Motion.
- Reduce Transparency.
- Focus order.
- Custom controls.
- Common-task coverage for Accessibility Nutrition Label claims.
- Screenshot evidence if available.

## Workflow

1. Inspect SwiftUI views, custom controls, and high-traffic screens.
2. Review screenshots only if the user provides or approves them.
3. Classify critical barriers before polish issues.
4. Map common tasks to assistive technologies when the audit may support App Store accessibility claims.
5. Recommend verification steps using Simulator, Accessibility Inspector, device testing, or code review.

## Do Not Use When

- The task is general visual design without accessibility impact.
- The user only needs App Store metadata, build debugging, or architecture review.

## Done When

- Findings cite inspected code, screenshots, or explicit evidence gaps.
- VoiceOver, Dynamic Type, contrast, tap targets, motion, transparency, and common-task risks are covered.
- Output separates blockers from improvements and includes verification steps.

## Output

Use `references/output-contract.md`.

Follow `../../docs/skill-quality-standard.md` and compare `../../examples/skill-outputs/accessibility-auditor-bad-output.md` with `../../examples/skill-outputs/accessibility-auditor-good-output.md`.
