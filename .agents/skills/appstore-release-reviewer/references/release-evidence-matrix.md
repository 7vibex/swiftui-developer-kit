# Release Evidence Matrix

| Area | Inspect | Blocking Signal | Evidence Gap Language |
| --- | --- | --- | --- |
| Identity and version | bundle ID, marketing version, build number | missing, inconsistent, or non-incremented values | Archive and App Store Connect values not inspected |
| Permissions | protected API calls and purpose strings | code path exists without an accurate purpose string | Real-device permission flow not inspected |
| Privacy | `PrivacyInfo.xcprivacy`, diagnostics, analytics, uploads | manifest and runtime behavior disagree | Network and vendor dashboards not inspected |
| Signing | target capabilities, entitlements, configuration | required entitlement or profile path is inconsistent | Developer portal state not inspected |
| Accessibility claims | common-task evidence by device family | claim lacks repeatable task evidence | Real-device assistive technology run not inspected |
| Screenshots and metadata | inventory, locales, device sizes, copy | required size or locale is missing | App Store Connect draft not inspected |
| Stability | release build, tests, crash diagnostics | release build fails or a critical flow crashes | TestFlight production telemetry not inspected |

State one of `GO`, `CONDITIONAL GO`, or `NO-GO`. Never infer App Review approval from local evidence.
