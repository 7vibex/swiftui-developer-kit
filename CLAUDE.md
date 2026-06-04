# Claude Instructions

This repository is a SwiftUI agent workflow library, not a SwiftUI app.

Use the skills under `.agents/skills/` as reusable workflows for SwiftUI, iOS, iPadOS, macOS, SwiftData, canvas/PencilKit, Liquid Glass, accessibility, testing, release, and PR work.

## Working Rules

- Preserve all `SKILL.md` YAML frontmatter.
- Frontmatter must contain only `name` and `description`.
- Keep skill descriptions concise and trigger-focused.
- Move detailed guidance into `references/`.
- Do not claim that one skill automatically invokes another skill.
- Keep scripts non-destructive.
- Ask before screenshots, Appshots, Simulator capture, or Computer Use.
- Do not capture private windows, passwords, chats, personal documents, production secrets, tokens, API keys, or private data.
- Validate shell scripts with `bash -n`.
- For this skill library, use `./scripts/validate-skills.sh` as the required verification command.

## Common Commands

```bash
scripts/swiftui-kit.sh list
scripts/swiftui-kit.sh doctor
scripts/swiftui-kit.sh validate
scripts/swiftui-kit.sh detect --format markdown /path/to/SwiftUIApp
```

## Typical Prompts

```text
Use the swiftui-project-router skill. audit this SwiftUI app.
Use the canvas-engine-auditor skill. Audit this iPad canvas for PencilKit, zoom/pan, gestures, layers, persistence, undo/redo, and performance bugs.
Use the swiftui-design-system-auditor skill. Review whether this iPad UI feels native and usable.
Use the liquid-glass-placement-auditor skill. Review where Liquid Glass belongs or should be avoided.
```
