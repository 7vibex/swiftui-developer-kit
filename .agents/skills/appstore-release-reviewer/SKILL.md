---
name: appstore-release-reviewer
description: Review iOS, iPadOS, macOS, SwiftUI, and Xcode apps for TestFlight and App Store release readiness, including bundle settings, versioning, privacy, permissions, metadata, screenshots, signing, and release notes.
---

# App Store Release Reviewer

Review release readiness for TestFlight and App Store submission.

## References

- `references/appstore-release-checklist.md`
- `references/privacy-manifest-checklist.md`
- `references/testflight-checklist.md`
- `references/screenshots-metadata-checklist.md`
- `references/output-contract.md`

## Check

- Bundle ID.
- Version and build number.
- Icons, app name, and launch screen.
- Permission strings.
- Privacy manifest.
- Signing hints.
- TestFlight readiness.
- Screenshots and metadata.
- Release notes.
- Debug flags.
- Crash risk.
- Basic accessibility.

## Workflow

1. Detect project files safely.
2. Inspect release settings and app metadata where available.
3. Separate submission blockers from cleanup.
4. Draft release notes if requested.
5. Return a final go/no-go with evidence and remaining risks.

## Output

Use `references/output-contract.md`.
