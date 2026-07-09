---
name: swiftui-feature-builder
description: Plan and implement end-to-end SwiftUI, iOS, iPadOS, or macOS features with domain behavior, data flow, persistence or services, accessibility, tests, and verification.
---

# SwiftUI Feature Builder

Use this workflow to plan and implement Apple app features without large unreviewed rewrites. Prefer existing project patterns and keep changes scoped.

## References

- Read `references/feature-planning-checklist.md` before planning.
- Read `references/swiftui-component-guidelines.md` before changing SwiftUI view structure.
- Use `../../../docs/apple-api-inventory.md` before recommending new Apple platform APIs.
- Use `references/output-contract.md` for final reporting.
- See the fictional end-to-end example at `../../../examples/swiftui-feature-builder-example.md`.

Prefer targeted search, project maps, and bundled scripts before reading many files.

## Workflow

1. Understand the requested feature and success criteria.
2. Inspect project structure, entry points, models, view state, and existing tests.
3. Identify the smallest set of files to edit.
4. Plan state ownership, data flow, navigation, async work, and persistence boundaries.
5. Check API availability, beta/future-release status, and fallback strategy for any new Apple API.
6. For Liquid Glass or other new-OS UI work, confirm the deployment target and oldest-supported-OS fallback strategy before implementation.
7. Implement small changes with clear verification checkpoints.
8. Add accessibility labels, traits, Dynamic Type behavior, and keyboard or pointer support where relevant.
9. Add focused tests when project structure supports them.
10. Verify build, tests, or static checks when safe.
11. Summarize changes, tests, verification, and follow-up improvements.

## Guardrails

- Avoid huge rewrites unless the user explicitly asks and the risk is documented.
- Do not move business logic into SwiftUI views.
- Do not introduce new architecture patterns when the existing project has a clear one.
- Do not build, run, or capture screens when the user has not approved that workflow.
- Do not silently remove support for the app's oldest supported OS when adding newer UI APIs. Ask whether to keep the existing UI path, build a separate fallback, or intentionally raise the minimum OS.
- Do not implement APIs absent from the current SDK or marked future-looking without stating that constraint and choosing a fallback.

## Do Not Use When

- The user wants only an audit, PR draft, screenshot review, or release checklist.
- The requested change lacks enough app context to identify target files and verification.

## Done When

- Success criteria, target files, state ownership, data flow, accessibility, and API availability are addressed.
- Changes are scoped to existing architecture and include focused tests or verification where safe.
- Output reports edits, tests, verification, risks, and follow-up work.

## Output

Use `references/output-contract.md`.

Follow `../../../docs/skill-quality-standard.md` and compare `../../../examples/skill-outputs/swiftui-feature-builder-bad-output.md` with `../../../examples/skill-outputs/swiftui-feature-builder-good-output.md`.
