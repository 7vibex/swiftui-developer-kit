# Command Vocabulary

These command words give users a short way to ask for the right SwiftUI workflow without remembering every specialist skill name.

| Command | Primary Skill | Good Prompt |
| --- | --- | --- |
| `audit` | `swiftui-architecture-auditor` | `Use the swiftui-project-router skill. audit this SwiftUI app.` |
| `fix-build` | `xcode-build-debugger` | `Use the swiftui-project-router skill. fix-build this Xcode error.` |
| `review-screenshots` | `simulator-screenshot-reviewer` | `Use the swiftui-project-router skill. review-screenshots for the Home and Canvas screens.` |
| `prepare-release` | `appstore-release-reviewer` | `Use the swiftui-project-router skill. prepare-release for TestFlight.` |
| `modernize-ui` | `swiftui-ui-patterns` or `liquid-glass-placement-auditor` | `Use the swiftui-project-router skill. modernize-ui and clean up this screen's state, sheets, and Liquid Glass placement.` |
| `improve-tests` | `test-coverage-improver` | `Use the swiftui-project-router skill. improve-tests for my ViewModels and SwiftData layer.` |
| `draft-pr` | `pr-draft-generator` | `Use the swiftui-project-router skill. draft-pr for my current branch.` |
| `detect-risks` | `swiftui-architecture-auditor` | `Use the swiftui-project-router skill. detect-risks in this SwiftUI project.` |

## Local CLI

The repo-local CLI wraps the same workflows:

```bash
scripts/swiftui-kit.sh list
scripts/swiftui-kit.sh doctor
scripts/swiftui-kit.sh detect Sources/
scripts/swiftui-kit.sh bundle --output /tmp/swiftui-kit-dist
scripts/swiftui-kit.sh validate
```

`detect-risks` is the only command backed by a deterministic source scanner today:

```bash
scripts/swiftui-kit.sh detect --format markdown .
scripts/swiftui-kit.sh detect --format json .
```

The scanner is read-only. It does not build, launch, operate Simulator, capture screenshots, inspect private windows, or modify source files.

## What Not To Add Yet

The project should not add a browser extension or live visual editor until the SwiftUI detector and command vocabulary prove useful in normal Apple app audits. Those ideas are powerful, but they would shift this repository away from being a practical Apple app workflow library.
