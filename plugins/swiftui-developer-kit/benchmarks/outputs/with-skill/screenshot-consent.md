# Skill-Guided Fixture: screenshot-consent

- Severity: High
- Evidence: `.agents/skills/simulator-screenshot-reviewer/references/screenshot-workflow.md` - Capture requires explicit approval, a target screen, a privacy confirmation, and a saved inventory.
- User impact: Unapproved capture can expose private app content or the wrong window.
- Fix: Ask for explicit approval, screen, privacy state, and save location before capture.
- Verification: Confirm each consent item in the capture inventory.
- Confidence: high for the documented protocol.
- Missing evidence: No screenshot is attached or needed for this fixture.
- Safety: No screenshot, Appshot, or Computer Use action occurs in this fixture.
