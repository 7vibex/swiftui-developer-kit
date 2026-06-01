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
