# Fictional Apple App Security & Privacy Audit: LumenNotes

## Executive Summary

- Audit scope: iOS app source, target configuration, dependency manifest, entitlements, and privacy manifest supplied for review. No live service, production database, keychain contents, device, App Store Connect account, or network traffic was accessed.
- Threat model: private notes, session artifacts, and a service credential move across the app sandbox, Keychain, SwiftData store, share sheet, API client, and support channel.
- Overall risk: critical. A static service credential is present in the shipped app target, and a support export can include private note titles without a clear consent boundary.
- Highest user-impact risk: app-binary extraction of a credential can permit unintended backend access if server-side restrictions are insufficient. The backend restrictions are uninspected.

## Evidence Inspected

- `FictionalLumenNotes/Config/ServiceConfig.swift`
- `FictionalLumenNotes/Auth/SessionStore.swift`
- `FictionalLumenNotes/Networking/NotesAPI.swift`
- `FictionalLumenNotes/Support/ReportExporter.swift`
- `FictionalLumenNotes/Data/NoteStore.swift`
- `FictionalLumenNotes/Info.plist`
- `FictionalLumenNotes/FictionalLumenNotes.entitlements`
- `FictionalLumenNotes/PrivacyInfo.xcprivacy`
- `Package.resolved`

## Not Inspected And Constraints

- Secret values were neither displayed nor copied.
- Server authorization rules, token rotation, SDK behavior, cloud retention, app-group data, vendor contract terms, and App Store Connect disclosure answers were not supplied.
- No build, launch, screenshot, Simulator capture, Computer Use, active probing, or account creation was approved.

## Data Flow Map

| Data category | Source | At rest | In transit | Recipient | Retention/control | Evidence |
| --- | --- | --- | --- | --- | --- | --- |
| Session token | OAuth callback | `SessionStore` Keychain wrapper | API `Authorization` header | notes backend | logout cleanup uninspected | source |
| Private note title | editor | SwiftData and export file | user-selected support export | share destination | export deletion and recipient retention uninspected | source |
| Service credential | static app configuration | distributed app binary | API request header | notes backend | rotation and scope uninspected | source |
| Crash diagnostic | runtime error | third-party SDK cache uninspected | vendor upload path uninspected | crash-reporting vendor | vendor policy uninspected | dependency plus manifest |

## Critical And High Risks

### Critical: Static service credential is compiled into the app target

- Risk: a privileged service credential is recoverable from the app binary.
- Severity: critical.
- Evidence: `ServiceConfig.swift` reads a static credential string that is compiled into the app target and `NotesAPI.swift` attaches it to every request. The value is intentionally omitted.
- User impact: a recovered credential may be used outside the intended app, with consequences determined by backend permissions.
- Reachability and boundary: anyone who can obtain a distributed binary can inspect its bundled material. The backend is outside the inspected boundary.
- Fix direction: move privileged service authorization to a controlled server boundary. Rotate the existing credential. Give the client only short-lived, least-privileged artifacts when the product needs them.
- Verification: inspect the rebuilt app artifact for absence of privileged credentials, add a configuration test that rejects source-bundled secrets, and have the service owner prove backend requests require appropriate server-side authorization.
- Confidence: high for client-bundled exposure; medium for downstream backend impact.
- Missing evidence: credential scope, backend authorization, rotation history, and production use.

### High: Support report exports include note titles by default

- Risk: private note titles can leave the app through a share destination that may not be a support channel.
- Severity: high.
- Evidence: `ReportExporter.swift` interpolates `note.title` into a plain-text report and presents a system share sheet without a redaction choice or preflight summary.
- User impact: users can unintentionally disclose sensitive study, work, or health-related titles.
- Reachability and boundary: any signed-in user who uses Report Issue can generate the export; recipient retention is uninspected.
- Fix direction: default to identifiers and counts, put an explicit optional include-content switch behind clear explanatory copy, and show an export preview using redacted fixture content in tests.
- Verification: add unit tests for default redaction and, after approval, manually verify share-preview language with fictional notes.
- Confidence: high.
- Missing evidence: support workflow, recipient policy, and share-sheet runtime behavior.

### Medium: Keychain session policy is incomplete in the reviewed code

- Risk: session artifacts may persist longer or synchronize more broadly than intended.
- Severity: medium.
- Evidence: `SessionStore.swift` uses a Keychain wrapper, but the inspected call site does not document accessibility, synchronization, account-switch deletion, or logout behavior.
- User impact: a prior account's session can remain accessible on a shared device if lifecycle policy is wrong.
- Reachability and boundary: user actions trigger sign-in and logout; actual Keychain attributes were not supplied.
- Fix direction: make the intended accessibility, synchronizable, access group, account-switch, logout, and revocation behavior explicit and test it through the wrapper.
- Verification: add wrapper tests and an approved sign-in, account-switch, logout, restart, and sign-in-again manual flow.
- Confidence: medium.
- Missing evidence: Keychain query attributes, product session policy, and device-level behavior.

## Credentials And Authentication

- OAuth callback validation, state, PKCE, redirect scheme, and server-side token exchange were not in the supplied code. Do not assume those controls exist.
- UI login state is not proof of API authorization; backend policy needs separate evidence.

## Network, Web Content, And Transport

- `Info.plist` contains no ATS exception. This is a positive configuration signal only for URL Loading System traffic; it does not prove custom networking, server certificate management, redirects, or every endpoint is safe.
- `NotesAPI.swift` logs request failures. Inspect redaction of headers and response bodies before adding diagnostic detail.

## Local Storage, Sharing, And Data Protection

- SwiftData store location, file protection, backup inclusion, export cleanup, previews, Quick Look, and cloud-sync behavior are uninspected.
- The support report is the highest demonstrated outbound-sharing surface in scope.

## Deep Links, Imports, And External Actions

- No custom URL, universal-link, document-import, or web-content files were provided. These surfaces must remain uninspected rather than marked safe.

## Permissions, Entitlements, SDKs, And Privacy Disclosures

- `PrivacyInfo.xcprivacy` names diagnostics collection. Compare the crash SDK, support exports, and any remote upload with privacy-manifest contents, App Store privacy answers, user-facing consent, and vendor retention before release.
- The reviewed entitlements file has an associated-domain entry. The matching website association file and route authorization are uninspected.
- `Package.resolved` identifies a crash SDK. Its exact collection behavior, privacy manifest, and version-specific advisories require vendor and release-review evidence.

## Recommended Fix Order

1. Rotate and remove the client-bundled credential, then prove the server boundary independently.
2. Make support exports redacted by default and test the opt-in content path.
3. Define and test session lifecycle and Keychain attributes.
4. Complete a privacy-data-flow and SDK disclosure review before store submission.
5. Review associated domains and all uninspected URL or file-input surfaces when their source is available.

## Residual Risks And Handoffs

- Backend authorization, credential rotation, vendor retention, SDK versions, and App Store Connect disclosures require external owners or a separately authorized review.
- A release-readiness review should reconcile permissions, privacy manifests, and App Store declarations after the app-side changes land.

## Safety And Scope Boundaries

- This fictional report contains no secret values, personal content, production data, private screenshots, or active exploitation steps.
- It distinguishes code-backed findings from server, vendor, and store-dashboard evidence gaps. It does not certify compliance, penetration-test results, or release approval.
