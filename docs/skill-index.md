# Skill Index

| Skill | Purpose | When To Use | Example Trigger Prompt | Key Outputs |
| --- | --- | --- | --- | --- |
| `swiftui-project-router` | Route broad Apple app work to a specialist workflow | Broad build, audit, debug, test, redesign, screenshot, release, or PR requests | `Use the swiftui-project-router skill. I want to audit my SwiftUI app and decide which workflows are needed.` | Selected workflow, reason, inputs needed, next action |
| `swiftui-feature-builder` | Plan and implement SwiftUI features | Building or modifying iOS, iPadOS, or macOS app features | `Use the swiftui-feature-builder skill. Add a planner detail screen.` | Feature plan, files changed, accessibility, tests, verification |
| `swiftui-ui-patterns` | Shape SwiftUI screen composition | State ownership, navigation, sheets, async loading, previews, performance, and view refactors | `Use the swiftui-ui-patterns skill. Clean up this editor screen's state and sheets.` | Recommended pattern, risks avoided, files to change, verification |
| `liquid-glass-placement-auditor` | Recommend where Liquid Glass should be used or avoided | UI modernization, chrome review, toolbars, sidebars, Simulator screenshots | `Use the liquid-glass-placement-auditor skill. Review where Liquid Glass belongs.` | Executive summary, screen recommendations, implementation plan |
| `simulator-screenshot-reviewer` | Capture, inventory, and review Simulator screenshots | Visual UI review of a running app | `Use the simulator-screenshot-reviewer skill. Review the Canvas screen in Simulator.` | Capture mode, screenshots, visual issues, layout fixes |
| `swiftui-architecture-auditor` | Audit architecture and maintainability | State, navigation, async, huge views, dead code, service boundaries | `Use the swiftui-architecture-auditor skill. Audit my app architecture.` | Critical/high/medium issues, fix order, Codex fix prompts |
| `swiftdata-persistence-auditor` | Audit SwiftData persistence | Models, queries, migrations, deletes, relationships, performance | `Use the swiftdata-persistence-auditor skill. Review my SwiftData layer.` | Data loss risks, performance risks, migration risks, query fixes |
| `xcode-build-debugger` | Diagnose build and scheme issues | Xcode errors, scheme detection, simulator build issues, signing hints | `Use the xcode-build-debugger skill. Diagnose this build failure.` | Project detected, command used, error summary, root cause, fix plan |
| `accessibility-auditor` | Audit accessibility | VoiceOver, Dynamic Type, contrast, tap targets, focus, motion settings | `Use the accessibility-auditor skill. Check my SwiftUI screens.` | Accessibility issues, recommended fixes, verification checklist |
| `appstore-release-reviewer` | Review TestFlight and App Store readiness | Pre-release checks for Apple platforms | `Use the appstore-release-reviewer skill. Check App Store readiness.` | Blockers, privacy, metadata, TestFlight checklist, go/no-go |
| `test-coverage-improver` | Improve test coverage | Missing tests, regression planning, ViewModel/repository/service coverage | `Use the test-coverage-improver skill. Find high-impact tests.` | Current test structure, gaps, suggested tests, commands |
| `pr-draft-generator` | Generate PR material | Preparing PR title, body, testing, risks, reviewer notes | `Use the pr-draft-generator skill. Draft a PR for my changes.` | Branch name, PR title, summary, testing, risks, release notes |

## Router Commands

Use these with `swiftui-project-router` when you want a concise command vocabulary:

| Command | Routes To | Use When |
| --- | --- | --- |
| `audit` | Architecture and related specialist audits | Broad project quality review |
| `fix-build` | `xcode-build-debugger` | Xcode, SwiftPM, scheme, simulator, signing, or compiler failures |
| `review-screenshots` | `simulator-screenshot-reviewer` | Simulator visual review after consent |
| `prepare-release` | `appstore-release-reviewer` | TestFlight and App Store readiness |
| `modernize-ui` | `swiftui-ui-patterns` or `liquid-glass-placement-auditor` | SwiftUI screen composition, view refactors, or Liquid Glass placement |
| `improve-tests` | `test-coverage-improver` | Missing high-impact tests |
| `draft-pr` | `pr-draft-generator` | PR material and release notes |
| `detect-risks` | Static scan plus specialist audit | Deterministic SwiftUI risk detection |
