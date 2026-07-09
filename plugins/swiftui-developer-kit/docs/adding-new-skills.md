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

## 5. Add Evidence Examples And A Benchmark

Create one realistic, complete worked example under `examples/` using fictional app data. Also add paired files:

```text
examples/skill-outputs/<skill-name>-good-output.md
examples/skill-outputs/<skill-name>-bad-output.md
```

The good output must use the headings in the skill's output contract and state severity, evidence, user impact, verification, confidence, missing evidence, and safety/approval boundaries where relevant. Add a deterministic benchmark task, weak baseline, and contract-compliant output under `benchmarks/` so the new skill is covered by the fixture suite.

## 6. Update Indexes

Update:

- `README.md`
- `docs/skill-index.md`
- Any workflow doc affected by the new skill
- `docs/usage.md`, `CLAUDE.md`, and router command vocabulary when users need a short command

## 7. Validate

```bash
find .agents/skills -name SKILL.md -print
find .agents/skills -name "*.sh" -print -exec bash -n {} \;
scripts/swiftui-kit.sh validate
scripts/swiftui-kit.sh benchmarks
```

## 8. Update Command Vocabulary When Needed

If the skill creates a new user-facing workflow, update:

- `.agents/skills/swiftui-project-router/SKILL.md`
- `docs/commands.md`
- `docs/skill-index.md`
- `README.md`

Only add a new command when it helps users choose a workflow faster. Do not add aliases for every narrow task.
