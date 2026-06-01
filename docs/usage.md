# Usage

## Router Skill Usage

Use the router when the task is broad:

```text
Use the swiftui-project-router skill. I want to audit my SwiftUI app and decide which workflows are needed.
```

Expected output:

- Selected workflow
- Why selected
- Inputs needed
- Next action

## Direct Skill Usage

Use a specialist skill when the workflow is already clear:

```text
Use the swiftui-architecture-auditor skill. Review my SwiftUI project for state management, navigation, async, and maintainability problems.
```

## Screenshot Mode

Use when visual evidence matters:

```text
Use the simulator-screenshot-reviewer skill. Ask before capturing screenshots, then review the Home and Canvas screens.
```

The skill should ask what screen to capture and whether anything sensitive is visible before using Appshots or `xcrun simctl io booted screenshot`.

## Code-Only Mode

Use when the app is not running or screenshots are not appropriate:

```text
Use the liquid-glass-placement-auditor skill. Use code-only mode and review likely Liquid Glass candidates from SwiftUI files.
```

Code-only findings should be marked lower confidence when no screenshots were reviewed.

## Release-Review Mode

```text
Use the appstore-release-reviewer skill. Check whether my iOS app is ready for TestFlight and App Store submission.
```

The review should inspect bundle settings, versioning, privacy strings, privacy manifest, screenshots, metadata, release notes, signing hints, debug flags, and basic accessibility.

## PR Summary Mode

```text
Use the pr-draft-generator skill. Draft a PR title, summary, testing checklist, risk notes, and release notes for my current SwiftUI changes.
```

Use the generated PR draft as a starting point, then adjust it to match the actual branch diff.
