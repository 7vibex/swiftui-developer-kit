# Skill-Guided Fixture: release-go-no-go

- Severity: Critical
- Evidence: `.agents/skills/appstore-release-reviewer/references/release-evidence-matrix.md` - A local release review must separate inspected evidence from App Store Connect and real-device gaps.
- User impact: A GO decision without external evidence can overstate submission readiness.
- Fix: Use NO-GO or CONDITIONAL GO until missing external evidence is named and reviewed.
- Verification: Validate the output includes inspected, not-inspected, blockers, and a final status.
- Confidence: high for the cited source-level decision.
- Missing evidence: App Store Connect and Developer portal state were not inspected.
- Safety: No screenshot, private data, destructive action, or unapproved build is required for this fixture.
