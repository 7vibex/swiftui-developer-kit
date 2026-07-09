---
name: swiftui-project-router
description: Route broad Apple app requests or named workflow commands like audit, canvas-audit, fix-build, diagnostics, localize, privacy-audit, review-screenshots, prepare-release, modernize-ui, improve-tests, draft-pr, and detect-risks.
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
| `diagnostics` | `swiftui-diagnostics-builder` | App diagnostics, logs, breadcrumbs, app-state snapshots, report issue workflows, MetricKit, signposts, TestFlight feedback, or AI-readable bug reports |
| `localize` | `swiftui-localization-auditor` | String Catalogs, language switching, pluralization, locale formatting, RTL, localized assets, or accessibility strings |
| `privacy-audit` | `apple-app-security-privacy-auditor` | App data flows, Keychain, auth, networking, deep links, storage, permissions, entitlements, SDKs, or privacy disclosures |
| `review-screenshots` | `simulator-screenshot-reviewer` | Simulator screenshots, visual hierarchy, clipping, spacing, readability, layout, or screen-by-screen UI review |
| `prepare-release` | `appstore-release-reviewer` | TestFlight, App Store, privacy, metadata, screenshots, signing, and go/no-go release checks |
| `modernize-ui` | `swiftui-design-system-auditor` for Apple UI quality; `swiftui-ui-patterns` for screen structure; `liquid-glass-placement-auditor` for Liquid Glass placement | SwiftUI UI modernization, screen composition, platform fit, chrome, toolbar, sidebar, tab, panel, canvas review, or Liquid Glass placement |
| `improve-tests` | `test-coverage-improver` | Missing tests, regression coverage, ViewModel tests, repository tests, service tests, or async test planning |
| `draft-pr` | `pr-draft-generator` | PR title, branch name, description, testing checklist, release notes, and reviewer notes |
| `detect-risks` | `swiftui-architecture-auditor` plus deterministic scan output | Static SwiftUI risk detection with `scripts/swiftui-kit.sh detect` when local files are available |

If the user asks for the menu, show the commands above with one-line guidance and recommend the narrowest next command. Do not auto-run screenshots, builds, launches, or captures.

## Routing Map

- Build or modify an end-to-end feature involving domain behavior, persistence, services, or cross-screen data flow: `swiftui-feature-builder`
- Diagnostics, issue reports, breadcrumbs, logs, MetricKit, signposts, TestFlight feedback, or AI-readable bug reports: `swiftui-diagnostics-builder`
- String Catalogs, localized resources, runtime language switching, pluralization, locale-aware formatting, RTL, or localized accessibility strings: `swiftui-localization-auditor`
- App data flows, credentials, Keychain, networking, auth, deep links, storage, permissions, entitlements, SDKs, or privacy disclosures: `apple-app-security-privacy-auditor`
- Canvas, drawing, handwriting, annotation, PencilKit, PaperKit, Apple Pencil Pro, zoom/pan, coordinate drift, layers, PDF alignment, highlighter opacity, undo/redo, or canvas persistence bugs: `canvas-engine-auditor`
- Apple UI design quality, layout hierarchy, typography, spacing, SF Symbols, platform fit, adaptive navigation, keyboard, pointer, menus, windows, or Apple Pencil review: `swiftui-design-system-auditor`
- One SwiftUI screen's composition, state wrappers, sheets, previews, async UI state, adaptive navigation, multiwindow behavior, or view refactors without new domain behavior: `swiftui-ui-patterns`
- Liquid Glass, modern UI, glass placement, chrome review: `liquid-glass-placement-auditor`
- Simulator screenshots or visual UI review: `simulator-screenshot-reviewer`
- Architecture, state, navigation, huge views: `swiftui-architecture-auditor`
- SwiftData, persistence, migrations, slow queries: `swiftdata-persistence-auditor`
- Xcode build errors, schemes, simulator build problems: `xcode-build-debugger`
- Accessibility, VoiceOver, Dynamic Type, contrast: `accessibility-auditor`
- App Store, TestFlight, release readiness, Accessibility Nutrition Labels, privacy metadata: `appstore-release-reviewer`
- Tests, coverage, missing tests: `test-coverage-improver`
- PR title, body, checklist, release notes: `pr-draft-generator`

## Workflow

1. Inspect the user's request and any available project context.
2. If the request names a command from Command Vocabulary, route through that command.
3. Pick the narrowest matching workflow.
4. If multiple workflows are needed, order them by dependency. Example: build debug before screenshot review.
5. For `detect-risks`, run `scripts/swiftui-kit.sh detect` only when local Swift files are available and the user did not request a code-free answer.
6. For broad audits, list the evidence needed for each selected specialist: code, screenshots, build logs, diagnostic bundle, store metadata, or manual device proof.
7. Ask only for missing routing information that changes the workflow choice.
8. Return the selected command, selected workflow, and next action.

## Do Not Use When

- The user already named the exact specialist skill and the task is narrow.
- The request is not about SwiftUI, Apple app development, release workflows, diagnostics, screenshots, tests, or PR drafting.

## Done When

- The narrowest command and specialist workflow are selected with routing confidence.
- Required evidence, explicit unknowns, inputs, stop conditions, and next action are stated.
- No build, launch, screenshot, capture, or specialist handoff is claimed as automatic.

## Orchestration Contract

Use `references/orchestration-contract.md` for routing confidence, specialist sequence, stop conditions, and the evidence budget.

See the fictional full-routing example at `../../../examples/full-project-router-example.md`.

## Output

Use `references/output-contract.md`.

Follow `../../../docs/skill-quality-standard.md` and compare `../../../examples/skill-outputs/swiftui-project-router-bad-output.md` with `../../../examples/skill-outputs/swiftui-project-router-good-output.md`.
