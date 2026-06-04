# SwiftUI Liquid Glass Recipes

Use these recipes when a Liquid Glass recommendation needs implementation-ready direction. Verify exact Liquid Glass API names in the current Xcode and Apple documentation before editing, because API spelling can change across seeds and SDK releases.

## API Verification Required

Before applying Liquid Glass code, complete these checks:

1. Check the installed Xcode version and SDK with `xcodebuild -version`.
2. Confirm the app's deployment target for iOS, iPadOS, macOS, and Catalyst if present.
3. Inspect current SwiftUI documentation or SDK symbols for the exact Liquid Glass APIs available in that Xcode.
4. Search the project for existing glass, material, blur, toolbar, and chrome wrappers before introducing a new helper.
5. Confirm the older-OS behavior with the user: keep existing UI, add a new non-glass fallback, or intentionally raise the minimum OS.
6. Build after code changes and exercise both the Liquid Glass path and fallback path when possible.

Treat recipe snippets as shape guidance only until API names are verified.

## Shared Rules

- Keep study, reading, writing, drawing, PDF, flashcard, table, and warning content opaque.
- Apply Liquid Glass to compact controls, chrome, transient panels, and navigation surfaces.
- Guard Liquid Glass-only APIs with platform availability.
- Preserve the current non-glass UI path for older supported OS versions unless the user explicitly chooses a new fallback or minimum OS increase.
- Respect Reduce Transparency with an opaque or system-material fallback.

```swift
@Environment(\.accessibilityReduceTransparency) private var reduceTransparency
@Environment(\.accessibilityReduceMotion) private var reduceMotion
```

```swift
@ViewBuilder
private var chromeBackground: some View {
    if reduceTransparency {
        Color(.systemBackground)
    } else if #available(iOS 26.0, iPadOS 26.0, macOS 26.0, *) {
        // Use the current SDK's Liquid Glass material, container, or modifier here.
        Color.clear
    } else {
        Color.clear.background(.ultraThinMaterial)
    }
}
```

## Floating Canvas Toolbar

Use for pen, highlighter, eraser, lasso, undo, color, and width controls that float above an opaque canvas.

Before: toolbar controls sit in a heavy opaque strip or blend into the canvas.

After: the compact toolbar gets the glass treatment; the drawing surface, ink strokes, PDF page, and paper texture remain opaque.

```swift
CanvasToolbar(selection: $tool)
    .padding(8)
    .background {
        chromeBackground
            .clipShape(Capsule())
    }
    .accessibilityElement(children: .contain)
```

Check: controls keep visible labels or VoiceOver labels, hit targets stay at least 44 points, and Reduce Transparency makes the toolbar stable and opaque enough.

## Bottom Navigation Chrome

Use for a tab bar, page switcher, or mode switcher that sits outside primary content.

```swift
safeAreaInset(edge: .bottom) {
    ModeSwitcher(selection: $mode)
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background {
            chromeBackground
                .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
        }
}
```

Check: the inset does not cover notebook text, flashcard answers, or document pages.

## Inspector Panel

Use for short-lived editing controls such as color, stroke width, opacity, alignment, or object properties.

```swift
.popover(isPresented: $showInspector) {
    ToolInspector(tool: selection)
        .padding()
        .background {
            chromeBackground
        }
}
```

Check: dense controls stay readable, focused fields are not hidden by blur, and warnings inside the inspector use opaque emphasis.

## Search Overlay

Use for compact search over content only when the search field and result chips are visually separate from the content beneath.

```swift
SearchBar(text: $query)
    .padding(10)
    .background {
        chromeBackground
            .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
    }
```

Check: search suggestions and long result snippets remain opaque.

## AI Mini Panel

Use carefully for compact assistant chrome: header, grab handle, close button, and action strip. Keep generated explanations, citations, and answer text on an opaque surface.

```swift
AITutorHeader(title: "Tutor")
    .background {
        chromeBackground
    }
```

Check: Reduce Motion avoids decorative motion, Reduce Transparency preserves answer readability, and VoiceOver order moves from panel title to primary answer to actions.

## Sheet Header

Use for a sheet header or compact command area. Avoid glass behind long form fields, legal text, or destructive confirmations.

```swift
.safeAreaInset(edge: .top) {
    SheetHeader(title: title, actions: actions)
        .background {
            chromeBackground
        }
}
```

Check: the sheet body remains stable, scroll indicators are not obscured, and destructive actions retain high contrast.
