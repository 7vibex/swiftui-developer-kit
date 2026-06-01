# Installation

## Clone The Repository

```bash
git clone https://github.com/7vibex/codex-swiftui-developer-kit.git
cd codex-swiftui-developer-kit
```

## Use With Codex

This repository is structured as a Codex skill repository. Skills live under:

```text
.agents/skills/
```

Use the repository from a Codex workspace, or copy `.agents/skills/` into the local skill directory supported by your Codex environment.

## Verify The Pack

Run the non-destructive checks:

```bash
find .agents/skills -name SKILL.md -print
find .agents/skills -name "*.sh" -print -exec bash -n {} \;
```

## Update

```bash
git pull --ff-only
```

Do not commit generated screenshots, audit folders, logs, build products, or private project data.
