# Adding New Skills

## 1. Create The Skill Folder

```text
.agents/skills/<skill-name>/
```

Use lowercase letters, digits, and hyphens.

## 2. Add `SKILL.md`

Every skill needs valid YAML frontmatter:

```md
---
name: example-skill
description: Do a specific workflow. Use when the user asks for specific trigger contexts.
---
```

Use only `name` and `description`.

## 3. Add References

Put detailed checklists and output contracts in:

```text
.agents/skills/<skill-name>/references/
```

Add `output-contract.md` for every specialist skill.

## 4. Add Scripts Only If Useful

Use scripts for deterministic, repeated operations. Scripts must be safe and non-destructive.

Required header:

```bash
#!/usr/bin/env bash
set -euo pipefail
```

## 5. Add Example Output

Create a realistic example under `examples/`. Use fictional app data.

## 6. Update Indexes

Update:

- `README.md`
- `docs/skill-index.md`
- Any workflow doc affected by the new skill

## 7. Validate

```bash
find .agents/skills -name SKILL.md -print
find .agents/skills -name "*.sh" -print -exec bash -n {} \;
```
