# Compatibility Matrix

Last verified: 2026-07-09

This matrix separates native Codex skill discovery, Codex plugin distribution, and generated bundles for other tools. A listed surface is supported only for the path shown.

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

- Repository validation: Bash, Ruby, and standard Unix tools on macOS or Ubuntu.
- Structured scanner: Swift 6.0 or newer; the checked-in package is verified with Swift 6.3.2.
- Liquid Glass implementation guidance: verify against the local SDK before naming or applying APIs.
- Codex docs checked: 2026-07-09.
- Apple API inventory checked: 2026-07-09.

## Distribution Boundaries

- Use `.agents/skills` while developing or inspecting this repository.
- Use the Codex plugin package for stable Codex distribution.
- Use provider bundles only for the named non-Codex hosts.
- Do not claim identical activation, approval, or tool behavior across providers.
