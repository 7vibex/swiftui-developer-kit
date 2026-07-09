# Privacy, Permissions, And Disclosure Checklist

## Collection And Consent

- Map each data category to its collection point, purpose, recipient, linkage, tracking behavior, retention, deletion, and user control.
- Include direct app code, extensions, analytics, crash reporting, diagnostics, AI services, cloud sync, support exports, and third-party SDKs.
- Check permission usage descriptions against the exact feature and user-visible trigger. Flag broad or misleading wording and unused protected-resource access.
- Check notifications, widgets, lock-screen surfaces, and share workflows for private-data exposure before consent or after sign-out.

## Declarations And Supply Chain

- Inspect `PrivacyInfo.xcprivacy` files for the app and bundled SDKs when applicable. Compare required-reason APIs and declared collection with supplied code and dependency evidence.
- Treat an App Store privacy answer, a vendor privacy policy, and a privacy manifest as related but distinct evidence sources.
- Inventory packages, XCFrameworks, binary SDKs, and generated code. Record version and source only when that information is safe to share.
- Do not claim all SDK behavior is known from a package manifest; identify vendor documentation or runtime evidence gaps.

## Platform Capabilities

- Review entitlements and capabilities for least privilege: associated domains, app groups, Keychain sharing, iCloud, push, background modes, network extensions, and protected resources as relevant.
- For macOS, review App Sandbox and Hardened Runtime scope separately from iOS or iPadOS entitlements.
- Route release-submission evidence and App Store Connect status to the release-review workflow instead of inferring it from source files.
