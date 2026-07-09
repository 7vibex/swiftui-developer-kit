# Platform Version Matrix

Use `platform-compatibility.md` for the canonical platform compatibility guidance. This file exists as a discoverable alias for agents or users who search for a platform version matrix by name.

| Platform | Liquid Glass Direction | Fallback Direction |
| --- | --- | --- |
| iOS/iPadOS 26+ | Use current SDK Liquid Glass APIs for eligible controls and chrome | Reduce Transparency can force solid/system backgrounds |
| iOS/iPadOS 18-25 | Do not fake Liquid Glass | Preserve existing UI or use approved system material for chrome |
| iOS/iPadOS 17 | Keep existing UI unless the user approves a fallback or minimum OS change | Avoid removing support silently |
| macOS 26+ | Use current SDK APIs for toolbar, sidebar, inspector, and window chrome where appropriate | Respect desktop density and focus order |
| macOS before 26 | Use standard AppKit/SwiftUI materials sparingly | Keep dense lists, forms, and long text opaque |
| Catalyst | Review separately | Confirm whether iPad-style or macOS-style chrome is rendered |

Before implementation, ask whether older OS versions keep the existing UI, get a new non-glass fallback, or are intentionally dropped.
