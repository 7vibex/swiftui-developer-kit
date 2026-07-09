# Apple Security And Privacy Sources

Use official Apple documentation for platform behavior and keep summaries brief. Re-check exact entitlement and API availability in the installed SDK before implementation.

| Source | Practical use |
| --- | --- |
| [Keychain services](https://developer.apple.com/documentation/security/keychain-services) | Review storage for small secrets and credentials. |
| [Preventing insecure network connections](https://developer.apple.com/documentation/security/preventing-insecure-network-connections) | Review ATS and transport exceptions. |
| [Privacy manifest files](https://developer.apple.com/documentation/bundleresources/privacy-manifest-files) | Review app and SDK privacy manifests and required-reason APIs. |
| [App privacy details](https://developer.apple.com/app-store/app-privacy-details/) | Separate App Store disclosures from code-only evidence. |
| [Supporting associated domains](https://developer.apple.com/documentation/xcode/supporting-associated-domains) | Review universal links, shared credentials, and the association boundary. |
| [macOS App Sandbox](https://developer.apple.com/documentation/xcode/configuring-the-macos-app-sandbox) | Check macOS capability scope and least privilege. |
| [Hardened Runtime](https://developer.apple.com/documentation/xcode/configuring-the-hardened-runtime) | Review macOS runtime exceptions and distribution requirements. |
| [Apple Platform Security](https://support.apple.com/guide/security/welcome/web) | Use high-level platform security context when needed. |

Do not paste large documentation excerpts into reports. Link the relevant official page and state the project-specific implication.
