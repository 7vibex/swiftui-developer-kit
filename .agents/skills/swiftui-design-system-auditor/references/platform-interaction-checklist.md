# Platform Interaction Checklist

## iPad

- Use `NavigationSplitView` or a clear sidebar-detail model when the app has persistent sections.
- Start with tabs only when top-level sections are few and peer-like.
- Preserve independent navigation state for major tabs or sections when users switch contexts.
- Keep writing, drawing, reading, and study content stable while chrome floats above or beside it.
- Resizing, rotation, split view, and Stage Manager must not reset selection, edit state, drawing tool, or navigation.
- Menu bar commands and keyboard flows are first-class on iPad when the app has repeated workflows.
- Support pointer hover only where it clarifies controls.
- Consider Apple Pencil affordances for canvas, annotation, drawing, and handwriting workflows.

## macOS

- Respect desktop density without making controls tiny.
- Use toolbars, sidebars, inspectors, commands, menus, and keyboard shortcuts where they fit.
- Prefer stable menu placement with disabled states over menus that appear and disappear based on minor state.
- Name document and multiwindow scenes clearly.
- Keep focus rings, tab order, and menu actions coherent.
- Avoid iPhone-style bottom bars as the main macOS navigation model.

## Keyboard And Pointer

- Frequent actions have keyboard access or discoverable commands.
- Focus order follows visual order.
- Hover states do not shift layout.
- Drag handles, resize controls, and floating palettes show clear affordances.

## Settings And Forms

- Settings are grouped by task and consequence.
- Destructive or account-level actions are separated from routine preferences.
- Long forms avoid translucent or image-backed surfaces.
- Validation and save state are visible without relying only on color.

## Apple Pencil And Canvas

- Tool palettes stay compact and reachable.
- Undo, redo, tool choice, width, color, lasso, and eraser controls are visible without covering work.
- Finger, pointer, and Pencil modes do not fight for the same gesture.
- Important canvas state survives orientation, split view, and stage manager resizing.
