# Agent Instructions

This repository contains Codex skills for Apple app development. Treat it as a workflow library, not an application.

## Skill Rules

- Preserve all `SKILL.md` YAML frontmatter.
- Frontmatter must contain only `name` and `description`.
- Keep descriptions concise and trigger-focused.
- Avoid bloated skills; move detailed guidance into `references/`.
- Do not claim that skills automatically invoke other skills.
- When adding a skill, add docs, references, examples, and an output contract.

## Safety Rules

- Keep scripts non-destructive.
- Ask before screenshots, Appshots, Simulator capture, or Computer Use.
- Never capture sensitive windows, passwords, private chats, personal documents, production secrets, tokens, API keys, or private data.
- Do not paste large copyrighted Apple documentation.
- Use official links and short summaries.

## Development Rules

- Prefer practical checklists over vague guidance.
- Keep examples fictional.
- Validate shell scripts with `bash -n`.
- Validate every skill has useful content and required references.
- Do not commit generated audit folders, screenshots, secrets, logs, or local build output.

## Apple App Verification Rules

- When working in a SwiftUI, iOS, iPadOS, macOS, SwiftData, or Xcode app project and code changes are made, build the latest app version before reporting completion.
- For iOS or iPadOS app changes, run the latest build in Simulator after a successful build.
- If Simulator is not running, start it and boot a 13-inch iPad Pro M5 simulator.
- Always prefer `iPad Pro 13-inch (M5) (16GB)` on the newest installed runtime. If that is not installed, use `iPad Pro 13-inch (M5)`.
- If no 13-inch iPad Pro M5 simulator is installed, stop and report that instead of silently using another device.
- This standing approval covers normal build, boot, install, and launch steps needed to verify SwiftUI app code changes. It does not cover screenshots, Appshots, Computer Use, DerivedData cleanup, signing changes, destructive commands, or private-data capture; ask before those.
- For this repository itself, which is a skill library rather than an app, use `./scripts/validate-skills.sh` as the required verification command unless the user is explicitly working inside a separate Apple app project.
