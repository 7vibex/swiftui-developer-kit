---
name: swiftui-project-router
description: Route broad Apple app requests or named workflow commands like audit, canvas-audit, fix-build, review-screenshots, prepare-release, modernize-ui, improve-tests, draft-pr, and detect-risks.
---

# SwiftUI Project Router

Route broad Apple app requests to the most relevant specialist workflow. Do not claim to automatically call another skill. If enough context exists, continue with the matching workflow instructions. If the task is ambiguous, ask one minimal routing question.

## Command Vocabulary

Use these command words when the user wants a concise workflow menu or names one directly:

| Command | Route To | Use When |
| --- | --- | --- |
| `audit` | `swiftui-architecture-auditor`, then related specialist audits as needed | Broad project quality review across architecture, persistence, accessibility, tests, release, or UI |
| `canvas-audit` | `canvas-engine-auditor` | Drawing, handwriting, PencilKit, Apple Pencil, zoom/pan, layer, PDF annotation, gesture, persistence, undo/redo, or canvas performance bugs |
| `fix-build` | `xcode-build-debugger` | Xcode, SwiftPM, scheme, simulator, signing, package, or compiler failures |
| `review-screenshots` | `simulator-screenshot-reviewer` | Simulator screenshots, visual hierarchy, clipping, spacing, readability, layout, or screen-by-screen UI review |
| `prepare-release` | `appstore-release-reviewer` | TestFlight, App Store, privacy, metadata, screenshots, signing, and go/no-go release checks |
| `modernize-ui` | `swiftui-design-system-auditor` for Apple UI quality; `swiftui-ui-patterns` for screen structure; `liquid-glass-placement-auditor` for Liquid Glass placement | SwiftUI UI modernization, screen composition, platform fit, chrome, toolbar, sidebar, tab, panel, canvas review, or Liquid Glass placement |
| `improve-tests` | `test-coverage-improver` | Missing tests, regression coverage, ViewModel tests, repository tests, service tests, or async test planning |
| `draft-pr` | `pr-draft-generator` | PR title, branch name, description, testing checklist, release notes, and reviewer notes |
| `detect-risks` | `swiftui-architecture-auditor` plus deterministic scan output | Static SwiftUI risk detection with `scripts/swiftui-kit.sh detect` when local files are available |

If the user asks for the menu, show the commands above with one-line guidance and recommend the narrowest next command. Do not auto-run screenshots, builds, launches, or captures.

## Routing Map

- Build or modify a feature: `swiftui-feature-builder`
- Canvas, drawing, handwriting, annotation, PencilKit, Apple Pencil, zoom/pan, coordinate drift, layers, PDF alignment, highlighter opacity, undo/redo, or canvas persistence bugs: `canvas-engine-auditor`
- Apple UI design quality, layout hierarchy, typography, spacing, SF Symbols, platform fit, keyboard, pointer, or Apple Pencil review: `swiftui-design-system-auditor`
- SwiftUI screen composition, state wrappers, sheets, previews, async UI state, or view refactors: `swiftui-ui-patterns`
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
2. If the request names a command from Command Vocabulary, route through that command.
3. Pick the narrowest matching workflow.
4. If multiple workflows are needed, order them by dependency. Example: build debug before screenshot review.
5. For `detect-risks`, run `scripts/swiftui-kit.sh detect` only when local Swift files are available and the user did not request a code-free answer.
6. Ask only for missing routing information that changes the workflow choice.
7. Return the selected command, selected workflow, and next action.

## Output

```md
# SwiftUI Project Router

## Selected Command

## Selected Workflow

## Why Selected

## Inputs Needed

## Next Action
```
