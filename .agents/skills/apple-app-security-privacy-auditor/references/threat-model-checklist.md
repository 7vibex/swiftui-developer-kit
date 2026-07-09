# App Threat Model Checklist

Build a small project-specific threat model before ranking findings. A code pattern without an asset, boundary, and plausible misuse path is not automatically a vulnerability.

| Element | Record |
| --- | --- |
| Asset | Credentials, account state, private content, identifiers, payments, files, health data, or other protected data in scope |
| Actor | Signed-in user, signed-out user, malicious app, compromised device, network observer, or service operator as relevant |
| Boundary | App sandbox, Keychain, file system, app group, web view, deep link, network, extension, cloud service, or third-party SDK |
| Entry point | Permission, URL, notification, imported file, share sheet, web callback, API response, local database, or user action |
| Misuse case | Unauthorized read, write, replay, redirect, disclosure, retention, privilege escalation, or confused-deputy behavior |
| Existing control | Platform default, entitlement, authorization check, user consent, validation, redaction, expiry, or audit log |
| Evidence gap | Backend rule, dashboard setting, vendor contract, runtime observation, or device configuration not inspected |

## Scope Rules

- State whether the audit covers app code only, bundled configuration, a test environment, backend rules, production behavior, or a combination.
- Name assumptions that materially change severity, such as account isolation, server authorization, device compromise, or managed-device policy.
- Separate a local coding flaw from a server-side authorization claim. The app cannot prove the server validates every request.
- Keep threat scenarios proportional to the product. Do not invent regulated-data obligations or adversaries without scope evidence.
