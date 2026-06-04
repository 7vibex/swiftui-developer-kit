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

For local Codex installs, install the skill folders into the local Codex user skills directory:

```bash
./scripts/install-local.sh
```

By default, the script symlinks every folder in `.agents/skills/` into:

```text
$HOME/.agents/skills
```

Current Codex skill locations are:

```text
Repo-local: .agents/skills
User-local: ~/.agents/skills
Admin: /etc/codex/skills
```

That means future `git pull` updates apply to the installed user skills. If a user prefers a physical copy instead of symlinks:

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

## Repo CLI

The local helper CLI wraps install, validation, listing, static risk detection, and provider bundle generation:

```bash
scripts/swiftui-kit.sh list
scripts/swiftui-kit.sh install
scripts/swiftui-kit.sh doctor
scripts/swiftui-kit.sh detect --format markdown /path/to/App
scripts/swiftui-kit.sh bundle --output .tmp/swiftui-kit-providers
```

`detect` is read-only and scans Swift source files without building, launching, or capturing anything.

## Provider Bundles

Generate provider-specific bundles when you want to copy the skills into another AI coding tool:

```bash
scripts/build-provider-bundles.sh --output .tmp/swiftui-kit-providers
```

The bundle includes:

- `.agents/skills` for Codex and generic agent skill discovery.
- `.claude/skills` for Claude Code.
- `.cursor/skills` for Cursor.
- `.gemini/skills` for Gemini CLI.
- `.github/skills` for GitHub Copilot.
- `.opencode/skills` for OpenCode.

Use a fresh output directory for each bundle build.

## Verify The Pack

Run the non-destructive checks:

```bash
find .agents/skills -name SKILL.md -print
find .agents/skills -name "*.sh" -print -exec bash -n {} \;
scripts/swiftui-kit.sh validate
```

## Update

```bash
git pull --ff-only
```

Do not commit generated screenshots, audit folders, logs, build products, or private project data.
