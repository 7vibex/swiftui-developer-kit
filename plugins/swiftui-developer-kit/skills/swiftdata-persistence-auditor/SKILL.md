---
name: swiftdata-persistence-auditor
description: Audit SwiftData models, queries, persistence flows, migrations, deletes, relationships, performance, background saves, and data-loss risks in SwiftUI Apple apps.
---

# SwiftData Persistence Auditor

Audit SwiftData usage for data loss, migration, query performance, relationship correctness, and production readiness.

## References

- `references/swiftdata-risk-checklist.md`
- `references/migration-checklist.md`
- `references/query-performance-checklist.md`
- `references/reopen-delete-save-contract.md`
- `../../docs/apple-source-map.md`
- `../../docs/apple-api-inventory.md`
- `references/output-contract.md`
- Worked fictional example: `../../examples/swiftdata-audit-example.md`

Prefer targeted search, project maps, and bundled scripts before reading many files.

## Check

- Full-table fetches.
- In-memory filtering that belongs in a predicate.
- Missing predicates or sort descriptors.
- Migration risks and renamed properties.
- Unsafe deletes.
- Missing confirmation, undo, save, transaction, or recovery paths for destructive actions.
- Relationship and inverse problems.
- Autosave assumptions in flows that need explicit correctness.
- Save/reopen contracts for documents, notebooks, canvas data, and imported files.
- Background save and context isolation issues.
- Data-loss paths.
- Sync readiness if iCloud or server sync is involved.

## Workflow

1. Find SwiftData files manually or with `scripts/collect-swiftdata-files.sh`.
2. Inspect models, contexts, query sites, delete flows, and migrations.
3. Trace each destructive flow from user action to model mutation and save.
4. Trace high-volume queries from screen state to predicate, sort, and result size.
5. Build a schema map for user-created data, relationships, delete rules, and migration state.
6. Identify every place the app relies on autosave and decide whether an explicit save or transaction boundary is required.
7. Separate correctness risks from performance risks.
8. Recommend safe migration and verification steps.
9. Generate Codex fix prompts with scoped file targets.

## Severity Standards

- Critical: Plausible user data loss, migration failure, or destructive action without recovery.
- High: Queries or relationships likely fail at scale or corrupt user expectations.
- Medium: Performance or maintainability risk that has a targeted fix.
- Low: Cleanup or naming issue that does not change persistence behavior.

## Evidence Standards

Every finding should identify a model, query, context use, delete path, save boundary, reopen path, or migration concern. Mark code-only assumptions clearly when no fixture or running app evidence is available.

## Do Not Use When

- The project does not use SwiftData or persistence is not part of the request.
- The project uses Core Data without SwiftData; this pack does not yet provide a general Core Data persistence workflow, so state that boundary instead of applying SwiftData guidance.
- The issue is only UI layout, App Store metadata, or build configuration.

## Done When

- Models, queries, delete paths, save boundaries, migrations, and reopen flows are mapped where relevant.
- Data-loss and migration risks are separated from performance and maintainability issues.
- Findings include evidence, severity, fix direction, and verification commands or manual flows.

## Output

Use `references/output-contract.md`.

Follow `../../docs/skill-quality-standard.md` and compare `../../examples/skill-outputs/swiftdata-persistence-auditor-bad-output.md` with `../../examples/skill-outputs/swiftdata-persistence-auditor-good-output.md`.
