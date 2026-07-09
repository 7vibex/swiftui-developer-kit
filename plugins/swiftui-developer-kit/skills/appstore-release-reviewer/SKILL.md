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
- `references/accessibility-labels-checklist.md`
- `references/release-evidence-matrix.md`
- `references/app-store-connect-fields.md`
- `references/privacy-review-output.md`
- `references/accessibility-claims-risk.md`
- `../../docs/apple-source-map.md`
- `references/output-contract.md`
- Worked fictional example: `../../examples/appstore-release-review-example.md`

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
- Accessibility Nutrition Label evidence.

## Workflow

1. Detect project files safely.
2. Inspect release settings and app metadata where available.
3. Review privacy and accessibility metadata against implemented behavior.
4. Separate submission blockers from cleanup.
5. Draft release notes if requested.
6. Return a final go/no-go with evidence and remaining risks.

## Do Not Use When

- The task is only build debugging, feature work, or code architecture review.
- App Store, TestFlight, privacy, signing, metadata, or release evidence is not in scope.

## Done When

- Go/no-go status is stated with blockers, risks, and missing evidence.
- Bundle, version, privacy, permissions, screenshots, signing, notes, and accessibility claims are checked where available.
- Output names exact files, metadata, or evidence gaps and gives verification steps.

## Output

Use `references/output-contract.md`.

Follow `../../docs/skill-quality-standard.md` and compare `../../examples/skill-outputs/appstore-release-reviewer-bad-output.md` with `../../examples/skill-outputs/appstore-release-reviewer-good-output.md`.
