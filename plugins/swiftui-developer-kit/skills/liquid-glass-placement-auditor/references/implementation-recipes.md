# Liquid Glass Implementation Recipes

Use `swiftui-liquid-glass-recipes.md` for the canonical implementation guidance. This file exists as a discoverable alias for agents or users who search for implementation recipes by name.

Required recipe coverage:

- Toolbar and floating tool palette chrome.
- Bottom accessory bars and mode switchers.
- Sheet headers and compact command areas.
- Search overlays.
- Inspector and sidebar chrome.
- AI assistant mini-panel chrome while keeping answer text opaque.
- Reduce Transparency fallback.
- iOS/iPadOS/macOS 26 availability checks.
- Older OS non-glass fallback behavior.

Do not use custom blur or `.ultraThinMaterial` as a fake Liquid Glass replacement for primary content.
