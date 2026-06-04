# Claude Code Usage

This repository can be used by Claude Code as a skill/workflow library even though the primary structure is Codex-oriented.

## Setup

Use the provider bundle command to generate a Claude-compatible skill directory:

```bash
scripts/swiftui-kit.sh bundle --output .tmp/swiftui-kit-providers
```

The Claude bundle is written to:

```text
.tmp/swiftui-kit-providers/.claude/skills
```

Copy or symlink those skills into the Claude Code skills location supported by your environment.

## Claude Project Instructions

`CLAUDE.md` tells Claude that this repository is a workflow library, not an app. It repeats the safety rules for screenshots, private data, script behavior, and validation.

## Useful Prompts

```text
Use the swiftui-project-router skill. audit this SwiftUI app.
```

```text
Use the swiftui-design-system-auditor skill. Review the Home, Canvas, AI Tutor, and Settings screens for Apple platform fit.
```

```text
Use the canvas-engine-auditor skill. Audit the Canvas screen for PencilKit, Apple Pencil, zoom/pan, gestures, save/reopen, undo/redo, performance, and regression-test risks.
```

```text
Use the liquid-glass-placement-auditor skill. Use code-only mode and review likely Liquid Glass candidates from SwiftUI files.
```
