---
name: swiftui-design-system-auditor
description: Audit SwiftUI, iOS, iPadOS, or macOS UI design quality, Apple platform fit, layout hierarchy, typography, spacing, controls, empty states, settings, iPad behavior, pointer, keyboard, and Apple Pencil workflows.
---

# SwiftUI Design System Auditor

Use this skill when the user wants an Apple-platform design review that is broader than Liquid Glass placement or architecture. Focus on whether the interface feels native, coherent, readable, and usable across iPhone, iPad, and macOS contexts.

## References

- Read `references/apple-ui-quality-checklist.md` for layout, typography, spacing, controls, density, and hierarchy checks.
- Read `references/platform-interaction-checklist.md` for iPad, macOS, pointer, keyboard, Apple Pencil, sidebar, toolbar, and split-view behavior.
- Use `../../../docs/apple-source-map.md` when a finding depends on official Apple UI, Liquid Glass, accessibility, or App Store guidance.
- Read `references/output-contract.md` before reporting.

Use `liquid-glass-placement-auditor` only when the question is specifically about Liquid Glass surfaces, glass fallbacks, or chrome placement. Use `swiftui-ui-patterns` when the main issue is state, sheets, navigation, async UI state, previews, or view composition.

## Workflow

1. Identify review mode: screenshot-plus-code, screenshot-only, code-only, or design-brief-only.
2. List screens, components, and evidence inspected.
3. Check platform fit: navigation model, toolbar placement, sidebar/tab usage, settings forms, and density.
4. Check adaptation: resizing, rotation, split view, Stage Manager, multiwindow, window naming, menus, and command stability.
5. Check visual system: hierarchy, spacing rhythm, typography, SF Symbols, color, contrast, empty states, and component consistency.
6. Check interaction quality: keyboard shortcuts, pointer affordances, Apple Pencil flows, focus order, hit targets, and repeated-use ergonomics.
7. Separate design-system findings from architecture, accessibility, Liquid Glass, or release-readiness findings.
8. Prioritize findings by user impact and implementation risk.
9. Give concrete SwiftUI-oriented fixes and verification steps.

## Guardrails

- Do not recommend decorative blur, gradients, shadows, or glass as generic polish.
- Do not make content harder to read for visual novelty.
- Do not force iPhone patterns onto iPad or macOS layouts.
- Do not report generic Apple advice without tying it to observed screens, files, or stated product goals.
- Do not capture screenshots, Appshots, Simulator output, or use Computer Use without explicit user approval.

## Output

Use `references/output-contract.md`.
