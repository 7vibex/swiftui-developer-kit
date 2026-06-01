# Architecture Checklist

- App entry point and scene structure are clear.
- Feature folders or modules have understandable ownership.
- Views are not responsible for networking, persistence, or complex business rules.
- Shared services are injected intentionally.
- ViewModels or observable models have focused responsibilities.
- Reusable components are not over-abstracted.
- Error handling is visible to the user where needed.
- Preview-only code does not leak into production behavior.
- Dead code and duplicate flows are identified before refactors.
