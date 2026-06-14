# Apple Source Map

Use this file as the repo-level evidence backbone. Skill references should cite official Apple sources first, summarize only the practical implication, and re-check exact API names in the installed SDK before implementation.

| Area | Official Source | Applies To | Practical Rule |
| --- | --- | --- | --- |
| Apple UI and platform fit | <https://developer.apple.com/design/human-interface-guidelines/> | `swiftui-design-system-auditor`, `swiftui-ui-patterns`, `swiftui-feature-builder` | Prefer system navigation, controls, layout, typography, and accessibility behavior before custom surfaces. |
| Layout and Liquid Glass separation | <https://developer.apple.com/design/human-interface-guidelines/layout> | `liquid-glass-placement-auditor`, `swiftui-design-system-auditor` | Distinguish controls from content; keep reading, writing, PDF, and study surfaces stable. |
| Materials and Liquid Glass | <https://developer.apple.com/design/human-interface-guidelines/materials> | `liquid-glass-placement-auditor` | Treat glass as functional chrome and navigation material; avoid using it as generic decoration. |
| SwiftUI Liquid Glass | <https://developer.apple.com/documentation/SwiftUI/Applying-Liquid-Glass-to-custom-views> | `liquid-glass-placement-auditor`, `swiftui-feature-builder` | Verify exact `glassEffect` and glass container APIs in the current SDK before editing. |
| SwiftUI | <https://developer.apple.com/documentation/swiftui> | SwiftUI feature, architecture, design, and UI-pattern skills | Check current APIs for navigation, toolbars, safe areas, layout, accessibility, and platform adaptation. |
| SwiftData | <https://developer.apple.com/documentation/swiftdata> | `swiftdata-persistence-auditor`, `swiftui-architecture-auditor` | Audit model identity, context ownership, delete/save boundaries, migrations, and query shape. |
| SwiftData ModelContext | <https://developer.apple.com/documentation/swiftdata/modelcontext> | `swiftdata-persistence-auditor` | Treat insert, delete, transaction, autosave, and save behavior as correctness decisions, not incidental plumbing. |
| PencilKit | <https://developer.apple.com/documentation/pencilkit> | `canvas-engine-auditor` | Use native drawing surfaces for Apple Pencil input unless a custom renderer is justified and tested. |
| PaperKit | <https://developer.apple.com/documentation/paperkit> | `canvas-engine-auditor` | Consider PaperKit when the app needs a full markup model with drawings, shapes, images, and text. |
| PDFKit overlays | <https://developer.apple.com/documentation/pdfkit/pdfpageoverlayviewprovider> | `canvas-engine-auditor` | Require page-aligned overlay lifecycle, save/export, and reopen verification for PDF annotation. |
| Apple Pencil interactions | <https://developer.apple.com/documentation/uikit/apple-pencil-interactions> | `canvas-engine-auditor`, `swiftui-design-system-auditor` | Respect Pencil double-tap and squeeze preferences when building custom canvas tool behavior. |
| Apple Pencil squeeze | <https://developer.apple.com/documentation/applepencil/handling-squeezes-from-apple-pencil> | `canvas-engine-auditor` | Do not override the user's preferred squeeze action without an explicit product reason and fallback. |
| Logging | <https://developer.apple.com/documentation/os/logging> | `swiftui-diagnostics-builder` | Use structured `Logger` categories and privacy annotations; never log raw user content by default. |
| Signposts | <https://developer.apple.com/documentation/os/ossignposter> | `swiftui-diagnostics-builder`, `canvas-engine-auditor` | Use signposts for expensive load, save, render, export, startup, and AI request intervals. |
| MetricKit | <https://developer.apple.com/documentation/metrickit> | `swiftui-diagnostics-builder`, `appstore-release-reviewer` | Use app performance and diagnostic reports through a diagnostics abstraction. |
| Xcode testing | <https://developer.apple.com/documentation/xcode/testing> | `test-coverage-improver`, `xcode-build-debugger` | Prefer stable model, repository, ViewModel, and UI tests tied to user-visible risks. |
| Accessibility HIG | <https://developer.apple.com/design/human-interface-guidelines/accessibility> | `accessibility-auditor`, `appstore-release-reviewer` | Evaluate common tasks with assistive technologies and accessibility settings enabled. |
| Accessibility Nutrition Labels | <https://developer.apple.com/help/app-store-connect/manage-app-accessibility/overview-of-accessibility-nutrition-labels/> | `accessibility-auditor`, `appstore-release-reviewer` | Claim support only when common tasks work for the feature on each supported device family. |
| App privacy details | <https://developer.apple.com/app-store/app-privacy-details/> | `appstore-release-reviewer`, `swiftui-diagnostics-builder` | Align diagnostics, analytics, screenshots, and uploads with App Store privacy disclosures. |
| Privacy manifests | <https://developer.apple.com/documentation/bundleresources/privacy-manifest-files> | `appstore-release-reviewer` | Review app and SDK data collection before release. |
| TestFlight | <https://developer.apple.com/testflight/> | `swiftui-diagnostics-builder`, `appstore-release-reviewer` | Treat beta feedback, screenshots, crashes, build details, and tester comments as release evidence. |

## Source Policy

- Link official Apple docs in reports when a finding depends on platform behavior.
- Prefer current SDK docs for API spelling and availability.
- Mark beta, seed, or future-release APIs explicitly and do not build production recommendations on them alone.
- Use developer forums as symptom evidence only, not as the primary source for API truth.
- Keep copied Apple text short; summarize the workflow implication in original words.
