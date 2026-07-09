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

- For this repository itself, which is a skill library rather than an app, use `./scripts/validate-skills.sh` as the required verification command unless the user is explicitly working inside a separate Apple app project.
- For separate SwiftUI, iOS, iPadOS, macOS, SwiftData, or Xcode app projects, build and run verification is expected after code changes only when the user or host repository has approved that workflow.
- For approved iOS or iPadOS app verification, prefer `iPad mini (A17 Pro)` on the newest installed runtime. If no iPad mini (A17 Pro) simulator is installed, stop and report that instead of silently using another device.
- Build/run approval does not include screenshots, Appshots, Simulator capture, Computer Use, DerivedData cleanup, signing changes, destructive commands, or private-data capture; ask before those.
