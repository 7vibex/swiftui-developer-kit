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
