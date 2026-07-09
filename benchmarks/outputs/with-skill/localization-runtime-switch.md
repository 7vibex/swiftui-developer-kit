# Skill-Guided Fixture: localization-runtime-switch

- Severity: High
- Evidence: `examples/swiftui-localization-audit-example.md` - An Arabic app can coexist with an English widget, making language selection appear broken.
- User impact: People can select a language yet see a visible extension remain in another language.
- Fix: Define widget language ownership and verify it through the app/widget runtime flow.
- Verification: With build/run approval, test system and app language combinations, timeline refresh, and relaunch.
- Confidence: medium because runtime output is intentionally uninspected.
- Missing evidence: widget target membership, shared-preference policy, and running-app behavior.
- Safety: No language change, screenshot, capture, or private translation content is used in this fixture.
