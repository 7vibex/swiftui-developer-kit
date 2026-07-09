# swiftui-design-system-auditor Good Output

This fictional example demonstrates the expected evidence standard.

## Medium: Every dashboard section is styled as a floating card
- Evidence: `FictionalStudyApp/Sources/Home/HomeDashboardView.swift` applies background, border, and shadow to each full-width section.
- Confidence: high from source inspection.
- User impact: hierarchy becomes noisy and repeated actions are harder to scan on iPad.
- Fix: use unframed section bands; reserve cards for repeated notebook items and keep controls in the toolbar.
- Missing evidence: pointer, keyboard, and Split View behavior were not run.
- Verification: inspect regular and accessibility text sizes, iPad Split View, keyboard focus, and pointer states.
- Safety: visual capture still requires explicit approval.
