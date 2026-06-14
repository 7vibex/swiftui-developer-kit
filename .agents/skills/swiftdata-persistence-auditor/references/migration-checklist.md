# Migration Checklist

- Renamed properties have a migration plan.
- Removed fields are backed up or intentionally discarded.
- Required new fields have defaults or migration logic.
- Relationship shape changes are tested with existing-store fixtures.
- App startup handles migration failure gracefully.
- Versioned schema is used when the project needs controlled migrations.
- Release notes or support docs mention user-visible data changes.
- Fixture stores exist for recent shipped schemas.
- Migration tests cover renamed, removed, newly required, relationship-changing, and type-changing properties.
- Future SwiftData APIs are labeled as future-looking until the app targets the matching SDK and OS family.
