# Codex SwiftUI Developer Kit

Codex SwiftUI Developer Kit is an open-source Codex skill pack for building, auditing, debugging, redesigning, testing, screenshot-reviewing, and releasing SwiftUI, iOS, iPadOS, macOS, SwiftData, and Apple app projects.

It includes `liquid-glass-placement-auditor`, a dedicated skill for reviewing where Apple Liquid Glass should be applied or avoided in SwiftUI, iOS, iPadOS, and macOS apps.

## Why This Exists

Apple app work often repeats the same review loops: inspect SwiftUI state, check navigation, debug Xcode schemes, review Simulator screenshots, decide where Liquid Glass belongs, audit SwiftData risk, and prepare App Store releases. This repository packages those workflows as reusable Codex skills so the same checks can be run consistently across projects.

## What Codex Skills Are

Codex skills are structured workflow folders. Each skill has a `SKILL.md` file with YAML frontmatter and focused instructions. Skills can also include reference checklists, output contracts, and safe scripts. Codex reads the skill when the user's request matches its trigger-focused description.

## What This Pack Includes

| Skill | Purpose | Use When |
| --- | --- | --- |
| `swiftui-project-router` | Select the right specialist workflow | The request is broad or spans multiple Apple app tasks |
| `swiftui-feature-builder` | Plan and build SwiftUI features | Adding or modifying app functionality |
| `liquid-glass-placement-auditor` | Audit where Liquid Glass belongs | Modernizing UI, reviewing chrome, toolbars, panels, or screenshots |
| `simulator-screenshot-reviewer` | Capture and review Simulator screenshots | Looking for visual, layout, hierarchy, or readability issues |
| `swiftui-architecture-auditor` | Review architecture and maintainability | State ownership, navigation, async, huge views, and boundaries |
| `swiftdata-persistence-auditor` | Review SwiftData persistence | Models, queries, deletes, migrations, and data-loss risk |
| `xcode-build-debugger` | Diagnose Xcode build problems | Build errors, schemes, simulators, dependencies, and signing hints |
| `accessibility-auditor` | Review accessibility | VoiceOver, Dynamic Type, contrast, tap targets, and motion settings |
| `appstore-release-reviewer` | Review release readiness | TestFlight, App Store, privacy, metadata, screenshots, and signing |
| `test-coverage-improver` | Improve test coverage | Finding high-impact tests for ViewModels, repositories, services, and regressions |
| `pr-draft-generator` | Draft pull request material | PR titles, summaries, testing checklists, risks, and release notes |

## Installation

Clone the repository:

```bash
git clone https://github.com/7vibex/codex-swiftui-developer-kit.git
cd codex-swiftui-developer-kit
```

Use the skills by pointing Codex at this repository, or copy `.agents/skills/` into a Codex-compatible skills location if your environment supports local skill discovery.

For local Codex installs, use the installer:

```bash
./scripts/install-local.sh
```

It symlinks the 11 skills into `${CODEX_HOME:-$HOME/.codex}/skills` by default, skips existing skills, and prints the next prompt to try. Restart Codex after installing.

See [docs/installation.md](docs/installation.md) for more detail.

## Using The Router Skill

Use the router when you want Codex to choose the right workflow:

```text
Use the swiftui-project-router skill. I want to audit my SwiftUI app and decide which workflows are needed.
```

The router should return the selected workflow, why it was selected, needed inputs, and the next action. It does not claim to automatically invoke other skills.

## Using Specialist Skills Directly

Use a specialist skill when the workflow is clear:

```text
Use the swiftui-architecture-auditor skill. Review my SwiftUI project for state management, navigation, async, and maintainability problems.
```

```text
Use the appstore-release-reviewer skill. Check whether my iOS app is ready for TestFlight and App Store submission.
```

## Simulator Screenshot Workflow

The screenshot workflows are consent-first. A skill must ask whether Simulator is open, what screen should be captured, and whether anything sensitive is visible before capturing. When approved, scripts can use:

```bash
xcrun simctl io booted screenshot
```

Screenshots should be named clearly, such as `01-home.png` or `02-canvas.png`, and tracked in a screenshot inventory.

Example prompt:

```text
Use the liquid-glass-placement-auditor skill. My SwiftUI app is running in the iPad Simulator. Ask me before taking screenshots, then review the main screens and tell me where Liquid Glass should be used or avoided.
```

## Appshots Workflow

Appshots may capture the frontmost app window. The user must bring the intended window forward and must not expose sensitive windows, passwords, private chats, personal documents, production secrets, tokens, API keys, or private data. macOS may require Screen Recording or Accessibility permissions.

## Privacy And Safety

Do not capture screenshots, Appshots, or use Computer Use without asking first. Do not capture sensitive windows. Do not upload secrets, private production data, or personal documents. Scripts in this repository are intended to be non-destructive: they inspect, list, create folders, and capture only after user approval.

See [docs/safety-and-privacy.md](docs/safety-and-privacy.md).

## Apple Documentation Policy

Reference files link to official Apple documentation and summarize practical review points. They do not copy large Apple documentation pages. When Apple guidance matters, prefer official links and short summaries.

## Example Prompts

```text
Use the swiftui-project-router skill. I want to audit my SwiftUI app and decide which workflows are needed.
```

```text
Use the liquid-glass-placement-auditor skill. My SwiftUI app is running in the iPad Simulator. Ask me before taking screenshots, then review the main screens and tell me where Liquid Glass should be used or avoided.
```

```text
Use the swiftui-architecture-auditor skill. Review my SwiftUI project for state management, navigation, async, and maintainability problems.
```

```text
Use the appstore-release-reviewer skill. Check whether my iOS app is ready for TestFlight and App Store submission.
```

## Roadmap

- Add more platform-specific examples for visionOS and watchOS when the workflows are proven.
- Add optional metadata for skill marketplaces where supported.
- Add more deterministic validators for skill frontmatter and script safety.
- Add sample CI that validates Markdown, shell syntax, and required skill files.

## Contributing

Contributions are welcome. Keep skills concise, trigger-focused, and safe. New skills should include references, an output contract, examples, and documentation updates.

See [CONTRIBUTING.md](CONTRIBUTING.md).

## License

MIT License. See [LICENSE](LICENSE).
