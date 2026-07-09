# Liquid Glass Platform Compatibility

Use this matrix before recommending implementation. Confirm the app's deployment targets and current SDK before editing code.

| Platform | Default Direction | Notes |
| --- | --- | --- |
| iOS/iPadOS 26+ | Use current Liquid Glass APIs for eligible controls and chrome | Verify API names in the installed Xcode SDK before editing. |
| iOS/iPadOS 18-25 | Keep existing UI or use system-material fallback | Do not remove the older UI path without user approval. |
| iOS/iPadOS 17 | Keep existing UI unless the user explicitly approves a new fallback or minimum OS change | Many production apps still support iOS 17-era devices. |
| macOS 26+ | Use current Liquid Glass APIs for toolbars, sidebars, inspectors, and window chrome where appropriate | Respect desktop density and focus order. |
| macOS before 26 | Use AppKit or SwiftUI material fallback only where it improves hierarchy | Avoid making dense lists or forms translucent. |
| Catalyst | Treat as a separate review path | Verify whether iPad-style or macOS-style chrome is being rendered. |

## Required User Decision

Before implementation, ask which older-OS behavior is intended when the project still supports older releases:

- Keep the existing UI for older OS versions and add Liquid Glass only behind availability guards.
- Build a new non-glass fallback for older OS versions.
- Raise the minimum OS intentionally and remove old code paths as a separate product decision.

## Availability Pattern

```swift
if #available(iOS 26.0, iPadOS 26.0, macOS 26.0, *) {
    // Use the current SDK's Liquid Glass API for eligible chrome.
} else {
    // Preserve the existing UI or use an approved material fallback.
}
```

## Accessibility Fallback

Reduce Transparency can override the visual design even on supported OS versions:

```swift
if reduceTransparency {
    Color(.systemBackground)
} else {
    // Liquid Glass or material path.
}
```

## Verification

- Build with the newest installed SDK.
- Exercise both availability paths when possible.
- Test Reduce Transparency and Increase Contrast.
- Confirm primary content remains opaque on every supported OS path.
