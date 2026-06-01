# SwiftData Risk Checklist

- `@Model` classes have stable identities where needed.
- Required values are not accidentally optional to avoid migration work.
- Optional values are handled in UI and business logic.
- Deletes do not orphan important related data.
- Relationship delete rules match user expectations.
- `ModelContext` is not passed across unsafe concurrency boundaries.
- Save failures are handled.
- Seed/demo data cannot overwrite user data.
- Tests or fixtures cover destructive flows.

## Data Loss Anti-Patterns

- Delete buttons directly mutate `ModelContext` without confirmation for user-created data.
- Cascades remove related study history that users expect to keep.
- Import flows overwrite existing records by title or date alone.
- Startup seeding runs outside an idempotent guard.
- Save errors are ignored after important edits.
- Migration defaults silently change user-visible meaning.

## Evidence To Collect

- Model definitions and relationship delete rules.
- User actions that call delete or overwrite.
- Import and seed paths.
- Save and error handling paths.
- Existing migration schema or lack of one.
