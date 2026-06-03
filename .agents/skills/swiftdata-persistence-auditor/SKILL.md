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
- `references/output-contract.md`

Prefer targeted search, project maps, and bundled scripts before reading many files.

## Check

- Full-table fetches.
- In-memory filtering that belongs in a predicate.
- Missing predicates or sort descriptors.
- Migration risks and renamed properties.
- Unsafe deletes.
- Relationship and inverse problems.
- Background save and context isolation issues.
- Data-loss paths.
- Sync readiness if iCloud or server sync is involved.

## Workflow

1. Find SwiftData files manually or with `scripts/collect-swiftdata-files.sh`.
2. Inspect models, contexts, query sites, delete flows, and migrations.
3. Trace each destructive flow from user action to model mutation and save.
4. Trace high-volume queries from screen state to predicate, sort, and result size.
5. Separate correctness risks from performance risks.
6. Recommend safe migration and verification steps.
7. Generate Codex fix prompts with scoped file targets.

## Severity Standards

- Critical: Plausible user data loss, migration failure, or destructive action without recovery.
- High: Queries or relationships likely fail at scale or corrupt user expectations.
- Medium: Performance or maintainability risk that has a targeted fix.
- Low: Cleanup or naming issue that does not change persistence behavior.

## Evidence Standards

Every finding should identify a model, query, context use, delete path, or migration concern. Mark code-only assumptions clearly when no fixture or running app evidence is available.

## Output

Use `references/output-contract.md`.
