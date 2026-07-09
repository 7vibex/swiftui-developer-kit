# Skill Index

| Skill | Purpose | When To Use | Example Trigger Prompt | Key Outputs |
| --- | --- | --- | --- | --- |
| `swiftui-project-router` | Route broad Apple app work to a specialist workflow | Broad build, audit, debug, test, redesign, screenshot, release, or PR requests | `Use the swiftui-project-router skill. I want to audit my SwiftUI app and decide which workflows are needed.` | Selected workflow, reason, inputs needed, next action |
| `swiftui-feature-builder` | Plan and implement SwiftUI features | Building or modifying iOS, iPadOS, or macOS app features | `Use the swiftui-feature-builder skill. Add a planner detail screen.` | Feature plan, files changed, accessibility, tests, verification |
| `swiftui-diagnostics-builder` | Build AI-readable app diagnostics | Logs, breadcrumbs, app-state snapshots, Report Issue exports, MetricKit, signposts, TestFlight feedback, and privacy-safe bug reports | `Use the swiftui-diagnostics-builder skill. Add a diagnostics export for canvas bugs.` | Diagnostic design, report schema, privacy rules, implementation plan, verification |
| `swiftui-localization-auditor` | Audit Apple-app localization correctness | String Catalogs, `.strings`, runtime language selection, pluralization, locale formatting, RTL, localized assets, or accessibility strings | `Use the swiftui-localization-auditor skill. Audit every supported language in this app.` | Locale coverage matrix, runtime gaps, formatter/RTL findings, fix order, verification matrix |
| `apple-app-security-privacy-auditor` | Audit app-side security and privacy | Data flows, Keychain, networking, authentication, deep links, storage, permissions, entitlements, SDKs, or privacy disclosures | `Use the apple-app-security-privacy-auditor skill. Audit this Apple app for security and privacy risks.` | Data-flow map, risks, remediation order, disclosure gaps, safe verification |
| `swiftui-ui-patterns` | Shape SwiftUI screen composition | State ownership, navigation, sheets, async loading, adaptive iPad/macOS behavior, previews, performance, and view refactors | `Use the swiftui-ui-patterns skill. Clean up this editor screen's state and sheets.` | Recommended pattern, adaptation, risks avoided, files to change, verification |
| `swiftui-design-system-auditor` | Audit Apple UI design quality | Layout hierarchy, typography, spacing, symbols, toolbars, empty states, platform fit, keyboard, pointer, menus, windows, and Pencil flows | `Use the swiftui-design-system-auditor skill. Review whether this iPad UI feels native.` | Pass criteria, findings, platform fit, fix order, verification |
| `canvas-engine-auditor` | Audit canvas/ink/gesture/persistence correctness | Canvas, PencilKit, PaperKit, drawing, annotation, zoom/pan, Apple Pencil Pro, highlighter, PDF annotation, layer, persistence, undo/redo, or infinite-board bugs | `Use the canvas-engine-auditor skill. Audit my StudyOS Canvas.` | Architecture map, verification matrix, findings, fix order, regression tests, Codex fix prompts |
| `liquid-glass-placement-auditor` | Recommend where Liquid Glass should be used or avoided | UI modernization, chrome review, toolbars, sidebars, Simulator screenshots | `Use the liquid-glass-placement-auditor skill. Review where Liquid Glass belongs.` | Executive summary, screen recommendations, implementation plan |
| `simulator-screenshot-reviewer` | Capture, inventory, and review Simulator screenshots | Visual UI review of a running app | `Use the simulator-screenshot-reviewer skill. Review the Canvas screen in Simulator.` | Capture mode, screenshots, visual issues, layout fixes |
| `swiftui-architecture-auditor` | Audit architecture and maintainability | State, navigation, async, huge views, dead code, service boundaries | `Use the swiftui-architecture-auditor skill. Audit my app architecture.` | Critical/high/medium issues, fix order, Codex fix prompts |
| `swiftdata-persistence-auditor` | Audit SwiftData persistence | Models, queries, migrations, deletes, save/reopen flows, relationships, performance | `Use the swiftdata-persistence-auditor skill. Review my SwiftData layer.` | Schema map, data loss risks, performance risks, migration risks, reopen contracts |
| `xcode-build-debugger` | Diagnose build and scheme issues | Xcode errors, scheme detection, simulator build issues, signing hints | `Use the xcode-build-debugger skill. Diagnose this build failure.` | Project detected, command used, error summary, root cause, fix plan |
| `accessibility-auditor` | Audit accessibility | VoiceOver, Dynamic Type, contrast, tap targets, focus, motion settings, and store-label evidence | `Use the accessibility-auditor skill. Check my SwiftUI screens.` | Accessibility issues, store-label readiness, recommended fixes, verification checklist |
| `appstore-release-reviewer` | Review TestFlight and App Store readiness | Pre-release checks, privacy, metadata, screenshots, and Accessibility Nutrition Labels for Apple platforms | `Use the appstore-release-reviewer skill. Check App Store readiness.` | Blockers, privacy, accessibility labels, metadata, TestFlight checklist, go/no-go |
| `test-coverage-improver` | Improve test coverage | Missing tests, regression planning, ViewModel/repository/service coverage | `Use the test-coverage-improver skill. Find high-impact tests.` | Current test structure, gaps, suggested tests, commands |
| `pr-draft-generator` | Generate PR material | Preparing PR title, body, testing, risks, reviewer notes | `Use the pr-draft-generator skill. Draft a PR for my changes.` | Branch name, PR title, summary, testing, risks, release notes |

## Router Commands

Use these with `swiftui-project-router` when you want a concise command vocabulary:

| Command | Routes To | Use When |
| --- | --- | --- |
| `audit` | Architecture and related specialist audits | Broad project quality review |
| `canvas-audit` | `canvas-engine-auditor` | Drawing, handwriting, PencilKit, zoom/pan, gestures, layers, PDF annotation, persistence, undo/redo, or canvas performance bugs |
| `fix-build` | `xcode-build-debugger` | Xcode, SwiftPM, scheme, simulator, signing, or compiler failures |
| `diagnostics` | `swiftui-diagnostics-builder` | Logs, breadcrumbs, app-state snapshots, issue reports, MetricKit, signposts, TestFlight feedback, or AI-readable bug reports |
| `localize` | `swiftui-localization-auditor` | Localization resources, runtime language behavior, formatters, RTL, and localized assets |
| `privacy-audit` | `apple-app-security-privacy-auditor` | App security, privacy, credentials, data flows, storage, transport, permissions, and disclosures |
| `review-screenshots` | `simulator-screenshot-reviewer` | Simulator visual review after consent |
| `prepare-release` | `appstore-release-reviewer` | TestFlight and App Store readiness |
| `modernize-ui` | `swiftui-design-system-auditor`, `swiftui-ui-patterns`, or `liquid-glass-placement-auditor` | Apple UI design quality, SwiftUI screen composition, view refactors, or Liquid Glass placement |
| `improve-tests` | `test-coverage-improver` | Missing high-impact tests |
| `draft-pr` | `pr-draft-generator` | PR material and release notes |
| `detect-risks` | Static scan plus specialist audit | Deterministic SwiftUI risk detection |
