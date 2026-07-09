# Compatibility Matrix

Last verified: 2026-07-10

This matrix separates native Codex skill discovery, Codex plugin distribution, and generated bundles for other tools. A listed surface is supported only for the path shown.

Only v0.1.0 is released and tagged. Later artifacts in this checkout are unreleased work on `main`; see `docs/releases/manifest.json` for the canonical status record.

| Surface | Status | Distribution Path | Verification |
| --- | --- | --- | --- |
| Codex CLI | Supported | `.agents/skills` or Codex plugin | Local install and repository validation |
| Codex IDE extension | Supported | `.agents/skills` or Codex plugin | Current Codex customization docs checked 2026-07-09 |
| Codex desktop app | Supported | `.agents/skills` or Codex plugin | Current Codex customization docs checked 2026-07-09 |
| Claude Code | Bundle only | `.claude/skills` plus `CLAUDE.md` | Generated provider bundle |
| Cursor | Bundle only | `.cursor/skills` | Generated provider bundle |
| Gemini CLI | Bundle only | `.gemini/skills` | Generated provider bundle |
| GitHub Copilot | Experimental bundle | `.github/skills` | Discovery behavior can differ by host version |
| OpenCode | Bundle only | `.opencode/skills` | Generated provider bundle |

## Version Baseline

- Repository validation: Bash, Ruby with the pinned Bundler dependencies (`bundle install`), and standard Unix tools on macOS or Ubuntu.
- Structured scanner: Swift 6.0 or newer; the checked-in package is verified with Swift 6.3.2.
- Liquid Glass implementation guidance: verify against the local SDK before naming or applying APIs.
- Codex docs checked: 2026-07-10.
- Apple API inventory checked: 2026-07-09.

## Distribution Boundaries

- Use `.agents/skills` while developing or inspecting this repository.
- Source-checkout distribution only: use the tracked Codex plugin package at `plugins/swiftui-developer-kit/` through the repo marketplace at `.agents/plugins/marketplace.json`. An installed plugin does not include those source paths; verify it with `./scripts/validate-skills.sh` instead.
- Use provider bundles only for the named non-Codex hosts.
- Do not claim identical activation, approval, or tool behavior across providers.
