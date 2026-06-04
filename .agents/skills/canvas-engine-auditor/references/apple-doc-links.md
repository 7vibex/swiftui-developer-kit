# Apple Documentation Links

Use official Apple links and short summaries. Do not copy large Apple documentation pages into this skill.

| Topic | Official Link | Use In This Skill |
| --- | --- | --- |
| PencilKit | https://developer.apple.com/documentation/pencilkit | Baseline framework for low-latency Apple Pencil drawing and `PKCanvasView` integration. |
| PKCanvasView | https://developer.apple.com/documentation/pencilkit/pkcanvasview | UIKit drawing surface, touch capture, tool state, drawing data, scroll/zoom behavior. |
| Drawing with PencilKit | https://developer.apple.com/documentation/PencilKit/drawing-with-pencilkit | Inspecting strokes/points and building PencilKit drawing experiences. |
| PKCanvasViewDelegate | https://developer.apple.com/documentation/pencilkit/pkcanvasviewdelegate/canvasviewdrawingdidchange%28_%3A%29 | Detecting drawing changes and deciding when/how to persist. |
| SwiftUI Canvas | https://developer.apple.com/documentation/swiftui/canvas | Immediate-mode 2D drawing in SwiftUI. Use for non-PencilKit rendering paths and overlays. |
| SwiftUI DragGesture coordinateSpace | https://developer.apple.com/documentation/swiftui/draggesture/coordinatespace | Drag locations must be interpreted in a consistent coordinate space. |
| SwiftUI coordinateSpace | https://developer.apple.com/documentation/swiftui/view/coordinatespace%28_%3A%29 | Name a coordinate space for reliable geometry conversion. |
| Apple Pencil and Scribble HIG | https://developer.apple.com/design/human-interface-guidelines/apple-pencil-and-scribble | Apple Pencil ergonomics, handwriting, marking, pointer behavior, and Scribble expectations. |
| Xcode Testing | https://developer.apple.com/documentation/xcode/testing | Combine unit, integration, performance, and UI tests appropriately. |
| Adding tests to Xcode projects | https://developer.apple.com/documentation/xcode/adding-tests-to-your-xcode-project | Test target setup and UI test template guidance. |
| WWDC24 Apple Pencil updates | https://developer.apple.com/videos/play/wwdc2024/10214/ | Custom tool picker items, Apple Pencil Pro squeeze/roll/hover, canvas feedback, and modern PencilKit behavior. |

## Reference Policy
- Prefer official Apple docs for API behavior and platform availability.
- Use public developer posts/forums only as symptom evidence, not as authoritative API truth.
- Re-check docs before implementing platform-version-specific APIs.
- For screenshots, Appshots, Simulator capture, or Computer Use, ask before capture and avoid sensitive windows/data.
