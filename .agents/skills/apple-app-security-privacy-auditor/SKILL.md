---
name: apple-app-security-privacy-auditor
description: Audit iOS, iPadOS, macOS, SwiftUI, and Xcode apps for privacy and security risks across data flows, permissions, Keychain, networking, authentication, deep links, storage, entitlements, SDKs, and disclosures.
---

# Apple App Security & Privacy Auditor

Audit the app-side security and privacy posture from code, configuration, dependencies, and approved runtime evidence. Treat backend, vendor, and store-dashboard behavior as uninspected unless evidence is supplied.

## References

- `references/threat-model-checklist.md`
- `references/data-flow-and-storage-checklist.md`
- `references/network-auth-and-input-checklist.md`
- `references/privacy-disclosure-checklist.md`
- `references/apple-security-privacy-sources.md`
- `../../../docs/apple-source-map.md`
- `references/output-contract.md`
- Worked fictional example: `../../../examples/apple-app-security-privacy-audit-example.md`

## Check

- Sensitive data sources, trust boundaries, recipients, retention, deletion, export, backups, and user controls.
- Keychain use, file and database protection, caches, logs, pasteboard, app groups, cloud sync, and local attachments.
- Authentication, credentials, session renewal, logout, OAuth or web sign-in, networking, ATS, and error reporting.
- Deep links, universal links, URL handling, web content, imports, external sharing, and untrusted input boundaries.
- Permissions, privacy manifests, entitlements, associated domains, SDKs, App Store disclosure evidence, and macOS sandbox or hardened-runtime scope.

## Workflow

1. Confirm the target platforms, threat model, sensitive data categories, user roles, and audit boundaries.
2. Inspect project settings, entitlements, privacy manifests, dependency manifests, app configuration, and code paths without exposing values that may be secrets.
3. Map each sensitive data flow from collection to storage, transmission, recipient, retention, deletion, and user control.
4. Trace credentials and sessions from acquisition through storage, renewal, logout, revocation, logging, and error handling.
5. Review network transport, ATS exceptions, trust customization, web content, deep links, import paths, and outbound sharing.
6. Review permissions, capabilities, SDK data flows, privacy manifest declarations, and App Store privacy evidence as separate layers.
7. Classify risks by plausible impact and evidence; distinguish app code proof from backend or vendor assumptions.
8. Recommend the smallest fix order and tests, configuration checks, or approved manual verification that would prove each change.

## Severity Standards

- Critical: plausible secret exposure, account takeover, arbitrary privileged action, or broad sensitive-data disclosure in normal use.
- High: a reachable boundary bypass, weak storage or transport affecting sensitive data, or a disclosure mismatch with material user or release risk.
- Medium: targeted hardening, consent, retention, input-validation, or configuration gap with a defined affected surface.
- Low: hygiene, documentation, or defense-in-depth improvement without evidence of practical exposure.

## Evidence Standards

Every finding should cite a file, target, symbol, entitlement, manifest entry, dependency, configuration key, test, approved runtime evidence, or an explicit gap. Do not report a vulnerability merely because an API exists; explain the data, boundary, reachability, and user impact.

## Guardrails

- Never print, copy, commit, transmit, or request secrets, passwords, tokens, authentication headers, private user content, signing assets, or production data.
- Do not actively exploit, probe live services, create accounts, scan networks, alter signing, or change entitlements without explicit scope and approval.
- Do not build, launch, inspect a device, or capture screenshots, Appshots, Simulator output, or Computer Use without the approval required by the user and host project.
- Do not infer that the backend, third-party SDK, App Store Connect answer, or vendor retention policy is secure from app source alone.
- Do not assume certificate pinning, custom cryptography, or storing large documents in Keychain is a default fix; tie recommendations to the threat model and platform guidance.

## Do Not Use When

- The task is only App Store submission packaging, a build or signing failure, or a general release checklist without app security or privacy analysis.
- The user requests active penetration testing or access to systems outside the explicitly authorized project scope.

## Done When

- Sensitive data flows, trust boundaries, storage, transport, auth, input surfaces, permissions, entitlements, SDKs, and disclosure evidence are mapped or marked uninspected.
- Findings include severity, evidence, user impact, fix direction, verification, confidence, and missing evidence without exposing sensitive material.
- The output separates code-backed risks from backend, vendor, and App Store evidence gaps and supplies a safe remediation order.

## Output

Use `references/output-contract.md`.

Follow `../../../docs/skill-quality-standard.md` and compare `../../../examples/skill-outputs/apple-app-security-privacy-auditor-bad-output.md` with `../../../examples/skill-outputs/apple-app-security-privacy-auditor-good-output.md`.
