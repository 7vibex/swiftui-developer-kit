---
name: swiftui-project-router
description: Route SwiftUI, iOS, iPadOS, macOS, SwiftData, Xcode, accessibility, Liquid Glass, Simulator screenshot, testing, release, or PR tasks to the right Codex skill/workflow. Use when the user asks broadly to build, audit, debug, test, redesign, screenshot-review, or release an Apple app.
---

# SwiftUI Project Router

Route broad Apple app requests to the most relevant specialist workflow. Do not claim to automatically call another skill. If enough context exists, continue with the matching workflow instructions. If the task is ambiguous, ask one minimal routing question.

## Routing Map

- Build or modify a feature: `swiftui-feature-builder`
- Liquid Glass, modern UI, glass placement, chrome review: `liquid-glass-placement-auditor`
- Simulator screenshots or visual UI review: `simulator-screenshot-reviewer`
- Architecture, state, navigation, huge views: `swiftui-architecture-auditor`
- SwiftData, persistence, migrations, slow queries: `swiftdata-persistence-auditor`
- Xcode build errors, schemes, simulator build problems: `xcode-build-debugger`
- Accessibility, VoiceOver, Dynamic Type, contrast: `accessibility-auditor`
- App Store, TestFlight, release readiness: `appstore-release-reviewer`
- Tests, coverage, missing tests: `test-coverage-improver`
- PR title, body, checklist, release notes: `pr-draft-generator`

## Workflow

1. Inspect the user's request and any available project context.
2. Pick the narrowest matching workflow.
3. If multiple workflows are needed, order them by dependency. Example: build debug before screenshot review.
4. Ask only for missing routing information that changes the workflow choice.
5. Return the selected workflow and next action.

## Output

```md
# SwiftUI Project Router

## Selected Workflow

## Why Selected

## Inputs Needed

## Next Action
```
