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

For local Codex installs, install the skill folders into the local Codex skills directory:

```bash
./scripts/install-local.sh
```

By default, the script symlinks every folder in `.agents/skills/` into:

```text
${CODEX_HOME:-$HOME/.codex}/skills
```

That means future `git pull` updates apply to the installed skills. If a user prefers a physical copy instead of symlinks:

```bash
./scripts/install-local.sh --copy
```

To install into a custom directory:

```bash
./scripts/install-local.sh --target /path/to/codex/skills
```

The script is non-destructive. If a skill already exists at the target path, it skips that skill instead of replacing it.

After installing, restart Codex so the new skills are discovered. Then use a prompt like:

```text
Use the swiftui-project-router skill. I want to audit my SwiftUI app and decide which workflows are needed.
```

Users can also manually copy or symlink `.agents/skills/*` into the Codex skills directory supported by their environment.

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
