---
name: swiftui-feature-builder
description: Plan and implement SwiftUI, iOS, iPadOS, or macOS features with clean architecture, state ownership, accessibility, tests, and verification. Use when asked to build or modify an Apple app feature.
---

# SwiftUI Feature Builder

Use this workflow to plan and implement Apple app features without large unreviewed rewrites. Prefer existing project patterns and keep changes scoped.

## References

- Read `references/feature-planning-checklist.md` before planning.
- Read `references/swiftui-component-guidelines.md` before changing SwiftUI view structure.
- Use `references/output-contract.md` for final reporting.

Prefer targeted search, project maps, and bundled scripts before reading many files.

## Workflow

1. Understand the requested feature and success criteria.
2. Inspect project structure, entry points, models, view state, and existing tests.
3. Identify the smallest set of files to edit.
4. Plan state ownership, data flow, navigation, async work, and persistence boundaries.
5. For Liquid Glass or iOS 26-only UI work, confirm the deployment target and iOS 17 fallback strategy before implementation.
6. Implement small changes with clear verification checkpoints.
7. Add accessibility labels, traits, Dynamic Type behavior, and keyboard or pointer support where relevant.
8. Add focused tests when project structure supports them.
9. Verify build, tests, or static checks when safe.
10. Summarize changes, tests, verification, and follow-up improvements.

## Guardrails

- Avoid huge rewrites unless the user explicitly asks and the risk is documented.
- Do not move business logic into SwiftUI views.
- Do not introduce new architecture patterns when the existing project has a clear one.
- Do not build, run, or capture screens when the user has not approved that workflow.
- Do not silently remove iOS 17 support when adding Liquid Glass or iOS 26 UI. Ask whether to keep the iOS 17 UI path, build a separate non-glass fallback, or intentionally raise the minimum OS.

## Output

Use `references/output-contract.md`.
