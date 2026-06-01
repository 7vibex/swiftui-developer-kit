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
3. Separate correctness risks from performance risks.
4. Recommend safe migration and verification steps.
5. Generate Codex fix prompts with scoped file targets.

## Output

Use `references/output-contract.md`.
