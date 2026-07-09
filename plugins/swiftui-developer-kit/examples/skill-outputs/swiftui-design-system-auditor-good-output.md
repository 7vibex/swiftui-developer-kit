# SwiftUI Design System Audit

## Executive Summary

- The fictional dashboard overuses full-width floating cards.
- Simplifying section surfaces will improve hierarchy on iPad.
- Keyboard, pointer, and Split View still need runtime evidence.

## Review Mode

Code-only; confidence is high for source structure and low for runtime platform behavior.

## Screens Or Components Reviewed

- Home dashboard — `FictionalStudyApp/Sources/Home/HomeDashboardView.swift`; high source confidence.

## Pass Criteria

The existing toolbar structure is platform-appropriate and can remain.

## Findings

### High

None found in the inspected source.

### Medium

- Issue: every dashboard section is styled as a floating card.
- Severity: medium.
- Evidence: full-width sections apply background, border, and shadow.
- User impact: hierarchy becomes noisy and repeated actions are harder to scan.
- Recommended fix: use unframed section bands; reserve cards for repeated items.
- SwiftUI direction: move controls to the toolbar and use semantic spacing.
- Verification: inspect Dynamic Type, iPad Split View, keyboard focus, and pointer states.
- Confidence: high.
- Missing evidence: runtime interaction states.

### Low

No other source-backed findings.

## Platform Fit

- iPhone: not inspected.
- iPad: simplify large-width content grouping.
- macOS: not inspected.
- Navigation model: not inspected.
- Resize/multiwindow behavior: not inspected.
- Menu and command behavior: not inspected.
- Keyboard/pointer/Pencil: not inspected.

## Design-System Fix Order

1. Simplify full-width surfaces.
2. Verify adaptive layout.
3. Review interaction affordances.

## Verification

- [ ] Dynamic Type.
- [ ] Increase Contrast / Reduce Transparency.
- [ ] Keyboard and pointer.
- [ ] iPad Split View or macOS resize.
- [ ] Approved screenshot or preview states.
