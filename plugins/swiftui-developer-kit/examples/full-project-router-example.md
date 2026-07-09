# SwiftUI Project Router

## Selected Workflow

Primary: `swiftui-architecture-auditor`

Follow-ups:

- `liquid-glass-placement-auditor`
- `swiftdata-persistence-auditor`
- `accessibility-auditor`
- `appstore-release-reviewer`

## Why Selected

The user asked broadly to audit the StudyOS app before release. Architecture should run first because it identifies structural problems that may affect UI, persistence, testing, and release readiness.

## Inputs Needed

- Project path.
- Target platform and minimum OS.
- Whether screenshots are allowed.
- Whether the app is already running in Simulator.

## Next Action

Inspect the SwiftUI project structure and collect likely app entry points, major views, state owners, and test targets. Do not capture screenshots until the user approves that workflow.
