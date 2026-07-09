# Issue Backlog

Last triaged: 2026-07-09

This file maps the expert review issue list to repository evidence. GitHub issues should remain open only for work that is not already represented by a merged artifact.

| Work Item | Repository Evidence | State |
| --- | --- | --- |
| Safer external-project build policy | `AGENTS.md` | Complete locally, untagged |
| Public synthetic fixtures and output proof | `benchmarks/`, `scanner/Fixtures/`, `examples/skill-outputs/` | Unreleased on `main` |
| Behavior benchmark harness and rubric | `benchmarks/`, `scripts/validate-benchmarks.sh` | Unreleased on `main` |
| Structured scanner, schema, suppressions, baseline | `scanner/`, `schemas/`, `scripts/run-structured-scanner.sh` | Unreleased on `main` |
| Skill lint and instruction conflicts | `scripts/lint-skills.sh`, `scripts/detect-instruction-conflicts.sh` | Complete locally, untagged |
| Links and docs freshness | `scripts/check-links.sh`, `scripts/check-doc-freshness.sh` | Unreleased on `main` |
| Exact Codex documentation links | `docs/openai-codex-doc-links.md` | Unreleased on `main` |
| Codex plugin distribution | `plugins/swiftui-developer-kit/`, `.agents/plugins/marketplace.json` | Source-checkout only; unreleased on `main` |
| Compatibility and release discipline | `docs/compatibility.md`, `CHANGELOG.md`, `docs/releases/manifest.json` | Unreleased on `main` |
| Threat model and contribution templates | `docs/threat-model.md`, `.github/` | Complete locally, untagged |
| Skill completion boundaries | all `SKILL.md` files | Complete locally, untagged |
| Paired good and bad outputs | `examples/skill-outputs/` | Unreleased on `main` |

Before opening or closing remote issues, compare this table with the live tracker and avoid duplicate or already-completed tickets.
