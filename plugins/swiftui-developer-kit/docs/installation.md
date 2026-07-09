# Installation

## Clone The Repository

```bash
git clone https://github.com/7vibex/swiftui-developer-kit.git
cd swiftui-developer-kit
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

You can also give Codex the repository link and ask it to install the pack for local use:

```text
Install the Codex skills from https://github.com/7vibex/swiftui-developer-kit so I can use them locally.
```

Codex should clone or inspect the repository, run `./scripts/install-local.sh`, and confirm the skills are available in `~/.agents/skills`.

That means future `git pull` updates apply to the installed user skills. If a user prefers a physical copy instead of symlinks:

```bash
./scripts/install-local.sh --copy
```

Existing skill entries are skipped by default. To refresh an already-installed local setup after moving this repository, changing install modes, or adding new skills, pass `--refresh`:

```bash
./scripts/install-local.sh --refresh
```

In symlink mode, `--refresh` unlinks each existing skill symlink and recreates it from the current checkout. For copied or otherwise real files/directories, it first moves the existing entry to a `*.backup-YYYYMMDDHHMMSS` path next to the target, then installs the new entry.

To install into a custom directory:

```bash
./scripts/install-local.sh --target /path/to/codex/skills
```

The script is non-destructive by default. If a skill already exists at the target path, it skips that skill instead of replacing it unless `--refresh` is provided.

Codex normally detects the local skills. If they do not appear in the current session, restart Codex, then use a prompt like:

```text
Use the swiftui-project-router skill. I want to audit my SwiftUI app and decide which workflows are needed.
```

Users can also manually copy or symlink `.agents/skills/*` into the Codex skills directory supported by their environment.

## Use The Repo Marketplace Plugin

In a **source checkout**, the repository includes a self-contained plugin package at `plugins/swiftui-developer-kit/` and a repo marketplace at `.agents/plugins/marketplace.json`. Open that checkout in Codex, find **SwiftUI Developer Kit** in the workspace marketplace, and install it from there. The marketplace entry resolves the checked-in plugin package; it does not require copying the skills to a personal directory.

From the **source checkout only**, verify that the tracked package is synchronized before installation or after changing source files:

```bash
./scripts/validate-codex-plugin-package.sh
```

After installing or unpacking the plugin itself, run its package-local release
gate instead; the installed package intentionally does not include the
source-only package builder or synchronizer:

```bash
./scripts/validate-skills.sh
```

Use the plugin's default prompt or a focused request such as:

```text
Use the SwiftUI Developer Kit plugin to audit my SwiftUI app and prioritize the most important fixes.
```

If the plugin does not appear after the repository has been opened, restart Codex once and check the workspace marketplace again.

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

The release gate is verified with Ruby 3.3 and Bundler 2.4.22 (the version pinned in `Gemfile.lock`). Install Ruby 3.3 with your preferred version manager, then install Bundler in your user gem directory instead of modifying a system Ruby:

```bash
gem install --user-install bundler -v 2.4.22
export PATH="$(ruby -r rubygems -e 'puts Gem.user_dir')/bin:$PATH"
```

Then install the pinned validation dependency and run the release gate:

```bash
bundle _2.4.22_ config set --local path .bundle
bundle _2.4.22_ install
bundle _2.4.22_ exec ./scripts/validate-skills.sh
```

The repo-local wrapper runs the same validation command:

```bash
find .agents/skills -name SKILL.md -print
find .agents/skills -name "*.sh" -print -exec bash -n {} \;
scripts/swiftui-kit.sh validate
```

## Update

```bash
git pull --ff-only
./scripts/install-local.sh --refresh
scripts/swiftui-kit.sh list
bundle _2.4.22_ exec ./scripts/validate-skills.sh
```

After pulling a new release, refresh the skill symlinks. Restart Codex only if updated local skills or the workspace marketplace do not appear in the current session.

For the unreleased v0.2.0 planning scope, see [v0.2.0 - Canvas and Diagnostics Workflows](releases/v0.2.0.md).

Do not commit generated screenshots, audit folders, logs, build products, or private project data.
