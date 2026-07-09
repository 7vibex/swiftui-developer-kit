# Apple API Inventory

Last verified: 2026-07-09

Compiler evidence: Xcode 26.5 and Swift 6.3.2. Run `./scripts/check-apple-api-inventory.sh --sdk` to refresh it.

Use this inventory before recommending platform-specific implementation. If an API is absent here or the local SDK disagrees, verify it before writing code and state the uncertainty in the report.

| API Or Surface | Source | Status For Skill Guidance | Skill-Pack Rule |
| --- | --- | --- | --- |
| `glassEffect(_:in:)` | <https://developer.apple.com/documentation/swiftui/view/glasseffect%28_%3Ain%3A%29> | Current SwiftUI Liquid Glass API | Use only behind availability policy and only for chrome, controls, and transient surfaces. |
| `GlassEffectContainer` | <https://developer.apple.com/documentation/swiftui/glasseffectcontainer> | Current SwiftUI Liquid Glass API | Use for related glass shapes that need to combine or morph; keep primary content outside the container. |
| `GlassButtonStyle` | <https://developer.apple.com/documentation/swiftui/glassbuttonstyle> | Current SwiftUI Liquid Glass API | Use for compact controls after confirming fallback behavior. |
| `backgroundExtensionEffect()` | <https://developer.apple.com/documentation/swiftui/view/backgroundextensioneffect%28%29> | Current SwiftUI visual integration API | Use to extend content behind system chrome where the platform expects edge-to-edge behavior. |
| `scrollEdgeEffectStyle(_:for:)` | <https://developer.apple.com/documentation/swiftui/view/scrolledgeeffectstyle%28_%3Afor%3A%29> | Current SwiftUI scroll-edge API | Configure control/content transitions; do not disable edge legibility just for decoration. |
| `safeAreaBar(edge:alignment:spacing:content:)` | <https://developer.apple.com/documentation/swiftui/view/safeareabar%28edge%3Aalignment%3Aspacing%3Acontent%3A%29> | Current SwiftUI custom bar API | Use for top or bottom study chrome when paired with scroll-edge and accessibility checks. |
| `NavigationSplitView` | <https://developer.apple.com/documentation/swiftui/navigationsplitview> | Stable SwiftUI navigation API | Prefer for broad/deep iPad and macOS content hierarchies. |
| `PKCanvasView` | <https://developer.apple.com/documentation/pencilkit/pkcanvasview> | Stable PencilKit surface | Treat as the source of truth for low-latency drawing unless the app proves another renderer. |
| `PKCanvasViewDelegate.canvasViewDrawingDidChange(_:)` | <https://developer.apple.com/documentation/pencilkit/pkcanvasviewdelegate/canvasviewdrawingdidchange%28_%3A%29> | Stable PencilKit change hook | Require an explicit save/debounce path for drawing changes. |
| `PKToolPicker` | <https://developer.apple.com/documentation/pencilkit/pktoolpicker> | Stable PencilKit tool surface | Prefer native tool picker lifecycle before custom palettes. |
| `PKToolPicker.shared(for:)` | <https://developer.apple.com/documentation/pencilkit/pktoolpicker/shared%28for%3A%29> | Deprecated legacy pattern | Detector should flag new use and route to `canvas-engine-auditor`. |
| PaperKit | <https://developer.apple.com/documentation/paperkit> | Current markup framework | Consider for Notes-like markup with shapes, images, text, and drawing data. |
| `PaperMarkupViewController` / `PaperMarkup` | <https://developer.apple.com/documentation/paperkit/getting-started-with-paperkit> | Current PaperKit integration surface | Require save/load and file-format decisions before adoption. |
| `PDFPageOverlayViewProvider` | <https://developer.apple.com/documentation/pdfkit/pdfpageoverlayviewprovider> | Stable PDFKit overlay protocol | Require overlay lifecycle, page transform, save/export, and reopen verification. |
| `UIPencilInteraction` | <https://developer.apple.com/documentation/uikit/apple-pencil-interactions> | Stable Apple Pencil interaction surface | Respect double-tap and squeeze preferences; mark hardware-only verification. |
| `ModelContext.delete(_:)` | <https://developer.apple.com/documentation/swiftdata/modelcontext/delete%28_%3A%29> | Stable SwiftData delete API | Pair destructive flows with confirmation, save/transaction boundary, and undo or recovery note. |
| `ModelContext.transaction(block:)` | <https://developer.apple.com/documentation/swiftdata/modelcontext/transaction%28block%3A%29> | Stable SwiftData transaction API | Use for grouped persistence changes when correctness depends on atomicity. |
| `ModelContext.autosaveEnabled` | <https://developer.apple.com/documentation/swiftdata/modelcontext/autosaveenabled> | Stable SwiftData autosave control | Do not treat autosave as the only correctness strategy for destructive or document-critical edits. |
| `@Query` / `Query` | <https://developer.apple.com/documentation/swiftdata/query> | Stable SwiftData view-facing fetch surface | Keep simple view-facing streams in views; move heavy orchestration out of large root views. |
| `SchemaMigrationPlan` | <https://developer.apple.com/documentation/swiftdata/schemamigrationplan> | Stable SwiftData migration surface | Require migration plans for renamed, removed, required, or relationship-changing data. |
| `Logger` | <https://developer.apple.com/documentation/os/logging> | Stable unified logging API | Use subsystem/category names and privacy annotations. |
| `OSSignposter` | <https://developer.apple.com/documentation/os/ossignposter> | Stable signpost API | Use for canvas latency, save/load/export, AI requests, startup, and render intervals. |
| `MXMetricManager` | <https://developer.apple.com/documentation/metrickit/mxmetricmanager> | Current MetricKit manager surface | Wrap behind app diagnostics so future MetricKit changes do not leak into feature code. |
| `MetricManager` | <https://developer.apple.com/documentation/metrickit/monitoring-app-performance-with-metrickit> | Newer MetricKit surface in current docs | Treat as a docs-verified but SDK-sensitive migration point; verify local SDK before coding. |
| `ResultsObserver` / `HistoryObserver` | <https://developer.apple.com/videos/play/wwdc2026/274/> | Future-release SwiftData guidance | Mention as future-looking only until the project targets the matching SDK and OS family. |
