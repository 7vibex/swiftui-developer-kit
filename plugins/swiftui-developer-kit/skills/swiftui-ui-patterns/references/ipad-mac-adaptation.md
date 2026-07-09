# iPad And Mac Adaptation

Use this reference when a SwiftUI screen must scale across iPhone, iPad, macOS, Stage Manager, external display, or multiwindow contexts.

## Navigation Choice

- Use tabs when top-level sections are few, peer-like, and frequently switched.
- Use `NavigationSplitView` when hierarchy is broad or deep, especially library/detail, binder/page, notebook/canvas, or mail-style apps.
- Use inspectors for secondary editable properties that should not replace primary content.
- Preserve per-section navigation state when users switch top-level contexts.
- Keep window or document titles descriptive in multiwindow flows.

## Non-Destructive Adaptation

- Resizing, rotation, split view, or Stage Manager changes must not reset selection, navigation path, edit state, drawing tool, zoom, or unsaved content.
- Moving from compact to regular width may reveal sidebars or inspectors, but should not silently navigate away.
- Moving to compact width may collapse chrome, but primary task state must remain recoverable.

## Commands, Menus, Keyboard, Pointer

- Frequent iPad and macOS actions need keyboard shortcuts or discoverable commands when appropriate.
- Prefer stable command placement with disabled states over menu sections that appear and disappear for minor state changes.
- Pointer hover should clarify affordances without shifting layout.
- Toolbars should be compact and task-oriented; avoid turning every filter into a giant pill.

## Verification

- Resize from compact to regular and back.
- Switch tabs or sidebars and return.
- Open two windows or documents if the app supports it.
- Check keyboard access for frequent commands.
- Check pointer hover and focus order.
- Verify names for windows, documents, tabs, and major destinations.
