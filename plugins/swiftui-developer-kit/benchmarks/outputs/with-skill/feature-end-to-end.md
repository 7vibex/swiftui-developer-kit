# Skill-Guided Fixture: feature-end-to-end

- Severity: High
- Evidence: `examples/swiftui-feature-builder-example.md` - Offline favorites spans domain behavior, persistence, and cross-screen data flow, so it needs an end-to-end feature plan.
- User impact: View-local state would lose favorites after relaunch and leave the Favorites screen inconsistent.
- Fix: Add the feature through the existing repository and route boundaries with focused persistence tests.
- Verification: Save, relaunch, remove, undo, and relaunch using the focused test plan.
- Confidence: high for the stated feature scope.
- Missing evidence: The host app's existing repository design is not inspected.
- Safety: Build/run remains host-approval-gated.
