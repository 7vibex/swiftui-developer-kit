# Skill-Guided Fixture: security-bundled-credential

- Severity: Critical
- Evidence: `examples/apple-app-security-privacy-audit-example.md` - A static service credential is present in the shipped app target.
- User impact: A recoverable credential can be reused outside the intended app, subject to uninspected backend permissions.
- Fix: Move privileged authorization to a server-controlled boundary and rotate the exposed credential without printing it.
- Verification: Confirm a rebuilt artifact contains no privileged credential and have the service owner verify authorization boundaries.
- Confidence: high for client-bundled exposure; medium for backend impact.
- Missing evidence: credential scope, rotation status, and server-side authorization policy.
- Safety: Never display, copy, transmit, or test a real credential in the fixture.
