# Skill-Guided Fixture: liquid-glass-placement

- Severity: Medium
- Evidence: `scanner/Fixtures/Positive.swift` - glassEffect has no availability guard or fallback.
- User impact: Older deployment targets can fail to compile or render without a supported fallback.
- Fix: Add iOS 26 availability, semantic older-OS material, and Reduce Transparency behavior.
- Verification: Run the SDK probe, Reduce Transparency, Increase Contrast, and Dynamic Type checks.
- Confidence: high for the cited source-level decision.
- Missing evidence: No approved screenshot review was performed.
- Safety: No screenshot, private data, destructive action, or unapproved build is required for this fixture.
