# Command Vocabulary

These command words give users a short way to ask for the right SwiftUI workflow without remembering every specialist skill name.

| Command | Primary Skill | Good Prompt |
| --- | --- | --- |
| `audit` | `swiftui-architecture-auditor` | `Use the swiftui-project-router skill. audit this SwiftUI app.` |
| `canvas-audit` | `canvas-engine-auditor` | `Use the swiftui-project-router skill. canvas-audit the StudyOS Canvas for PencilKit, zoom/pan, persistence, and gesture bugs.` |
| `fix-build` | `xcode-build-debugger` | `Use the swiftui-project-router skill. fix-build this Xcode error.` |
| `review-screenshots` | `simulator-screenshot-reviewer` | `Use the swiftui-project-router skill. review-screenshots for the Home and Canvas screens.` |
| `prepare-release` | `appstore-release-reviewer` | `Use the swiftui-project-router skill. prepare-release for TestFlight.` |
| `modernize-ui` | `swiftui-design-system-auditor`, `swiftui-ui-patterns`, or `liquid-glass-placement-auditor` | `Use the swiftui-project-router skill. modernize-ui and review Apple UI fit, state, sheets, and Liquid Glass placement.` |
| `improve-tests` | `test-coverage-improver` | `Use the swiftui-project-router skill. improve-tests for my ViewModels and SwiftData layer.` |
| `draft-pr` | `pr-draft-generator` | `Use the swiftui-project-router skill. draft-pr for my current branch.` |
| `detect-risks` | `swiftui-architecture-auditor` | `Use the swiftui-project-router skill. detect-risks in this SwiftUI project.` |

## Local CLI

The repo-local CLI wraps the same workflows:

```bash
scripts/swiftui-kit.sh list
scripts/swiftui-kit.sh doctor
scripts/swiftui-kit.sh detect Sources/
scripts/swiftui-kit.sh bundle --output .tmp/swiftui-kit-dist
scripts/swiftui-kit.sh validate
```

`detect-risks` is backed by the general SwiftUI source scanner:

```bash
scripts/swiftui-kit.sh detect --format markdown .
scripts/swiftui-kit.sh detect --format json .
```

The scanner is read-only. It does not build, launch, operate Simulator, capture screenshots, inspect private windows, or modify source files.

For canvas-specific apps, use `canvas-audit` directly or run the bundled canvas scanner from the app root:

```bash
.agents/skills/canvas-engine-auditor/scripts/detect-canvas-risks.sh .
```

## Worked `detect-risks` Output

The full example lives in [../examples/detect-risks-example.md](../examples/detect-risks-example.md). A typical scanner result looks like this:

```markdown
# SwiftUI Anti-Pattern Scan

- **large-swiftui-file** `StudyOS/Sources/StudyPlanDashboard.swift:1` [medium]: SwiftUI view file has 148 lines. Split rendering, state, and helper views before adding more behavior.
- **image-button-missing-accessibility-label** `StudyOS/Sources/StudyPlanDashboard.swift:42` [high]: A button appears to rely on an SF Symbol without an accessibility label. Add a clear .accessibilityLabel or use a Label with visible text.
- **swiftdata-delete-without-recovery-signal** `StudyOS/Sources/StudyPlanDashboard.swift:112` [high]: SwiftData delete path has no nearby confirmation or recovery signal. Verify destructive actions have confirmation, undo, or a clear recovery path.

Findings: 5
```

Use the result as a starting point for `swiftui-architecture-auditor`; route accessibility and SwiftData findings to those specialist skills when the source confirms the risk.

See [detector-roadmap.md](detector-roadmap.md) for candidate static rules such as duplicate sheet booleans, unstable `.id(UUID())`, heavy `.onChange`, custom blur on long content, and ad hoc toolbar `HStack` patterns.

## What Not To Add Yet

The project should not add a browser extension or live visual editor until the SwiftUI detector and command vocabulary prove useful in normal Apple app audits. Those ideas are powerful, but they would shift this repository away from being a practical Apple app workflow library.
