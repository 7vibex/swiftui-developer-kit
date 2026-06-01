# Contributing

Thanks for improving Codex SwiftUI Developer Kit. This repository is a skill pack, not an app, so changes should improve repeatable Codex workflows for Apple app development.

## Contributing New Skills

- Create a folder under `.agents/skills/<skill-name>/`.
- Add a required `SKILL.md`.
- Use only `name` and `description` in YAML frontmatter.
- Keep `description` concise and trigger-focused.
- Put detailed checklists in `references/` instead of bloating `SKILL.md`.
- Add an `output-contract.md` reference so reports stay consistent.
- Add an example output under `examples/`.
- Update `README.md`, `docs/skill-index.md`, and `docs/adding-new-skills.md` if the workflow changes.

## Improving Existing Skills

- Preserve frontmatter exactly unless the trigger behavior needs to change.
- Keep instructions imperative and practical.
- Remove duplicated guidance when a reference file already covers it.
- Prefer small checklists and clear output sections over long essays.
- Do not claim one skill automatically invokes another skill.

## Adding Reference Checklists

- Keep checklists specific to a workflow.
- Include concrete review signals and common failure modes.
- Link official Apple or OpenAI docs when useful.
- Do not copy large documentation passages.
- Use short summaries and links instead.

## Adding Scripts

Scripts must be safe, deterministic, and non-destructive.

Required shell header:

```bash
#!/usr/bin/env bash
set -euo pipefail
```

Script safety rules:

- Do not delete files.
- Do not reset git state.
- Do not launch apps unless the user approved that workflow.
- Do not build projects unless the user approved that workflow.
- Do not capture screenshots unless the user explicitly approved the capture.
- Print what the script found or created.
- Accept paths as arguments where practical.
- Pass `bash -n` before merging.

## Adding Examples

Examples should be realistic but fictional. Use the Study OS-style app shape used in this repository: Home, Canvas, Notebook, AI Tutor, Flashcards, Planner, and Settings. Do not include private project details.

## Markdown Style

- Use clear headings.
- Keep paragraphs short.
- Prefer bullets for checklists.
- Use fenced code blocks for prompts and commands.
- Use ASCII punctuation unless a document needs a specific character.
- Avoid marketing filler.

## Pull Request Checklist

- [ ] Skill frontmatter is valid.
- [ ] Descriptions are trigger-focused.
- [ ] Reference files are useful and non-empty.
- [ ] Scripts pass `bash -n`.
- [ ] Screenshot workflows ask before capture.
- [ ] Apple docs are linked, not copied.
- [ ] README and skill index are updated.
- [ ] Examples are added or updated.
- [ ] No secrets, screenshots, private data, or generated audit output are committed.
