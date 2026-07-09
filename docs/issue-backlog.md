# Issue Backlog

Last triaged: 2026-07-09

This file maps the expert review issue list to repository evidence. GitHub issues should remain open only for work that is not already represented by a merged artifact.

| Work Item | Repository Evidence | State |
| --- | --- | --- |
| Safer external-project build policy | `AGENTS.md` | Complete locally |
| Public synthetic fixtures and output proof | `benchmarks/`, `scanner/Fixtures/`, `examples/skill-outputs/` | In this hardening release |
| Behavior benchmark harness and rubric | `benchmarks/`, `scripts/validate-benchmarks.sh` | In this hardening release |
| Structured scanner, schema, suppressions, baseline | `scanner/`, `schemas/`, `scripts/run-structured-scanner.sh` | In this hardening release |
| Skill lint and instruction conflicts | `scripts/lint-skills.sh`, `scripts/detect-instruction-conflicts.sh` | Complete locally |
| Links and docs freshness | `scripts/check-links.sh`, `scripts/check-doc-freshness.sh` | In this hardening release |
| Exact Codex documentation links | `docs/openai-codex-doc-links.md` | In this hardening release |
| Codex plugin distribution | `plugins/swiftui-developer-kit/`, `.agents/plugins/marketplace.json` | In this hardening release |
| Compatibility and release discipline | `docs/compatibility.md`, `CHANGELOG.md`, `docs/releases/` | In this hardening release |
| Threat model and contribution templates | `docs/threat-model.md`, `.github/` | Complete locally |
| Skill completion boundaries | all `SKILL.md` files | Complete locally |
| Paired good and bad outputs | `examples/skill-outputs/` | In this hardening release |

Before opening or closing remote issues, compare this table with the live tracker and avoid duplicate or already-completed tickets.
