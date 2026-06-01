# Migration Checklist

- Renamed properties have a migration plan.
- Removed fields are backed up or intentionally discarded.
- Required new fields have defaults or migration logic.
- Relationship shape changes are tested with existing-store fixtures.
- App startup handles migration failure gracefully.
- Versioned schema is used when the project needs controlled migrations.
- Release notes or support docs mention user-visible data changes.
