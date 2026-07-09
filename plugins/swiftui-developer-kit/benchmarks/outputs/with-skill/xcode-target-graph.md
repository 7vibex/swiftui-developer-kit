# Skill-Guided Fixture: xcode-target-graph

- Severity: High
- Evidence: `examples/skill-outputs/xcode-build-debugger-good-output.md` - A missing test-target dependency can produce a No such module error and needs a target-graph fix.
- User impact: CI and local tests cannot compile.
- Fix: Add the app target dependency and host application setting; do not alter signing or clean DerivedData.
- Verification: Re-run the exact failing test command only when the workflow is approved.
- Confidence: high for the target-graph diagnosis.
- Missing evidence: Archive and device builds are not inspected.
- Safety: No cleanup, launch, screenshot, or signing change is required.
