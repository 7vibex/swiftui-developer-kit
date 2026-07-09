# Apple UI Quality Checklist

## Layout And Hierarchy

- Primary task is obvious within the first viewport.
- Navigation, content, and inspector/tool areas are visually distinct.
- Repeated sections use consistent spacing and alignment.
- Dense screens have grouping, headers, and enough scan rhythm.
- Empty states explain the next meaningful action without feeling like marketing copy.
- Destructive, warning, and error states are visually stable and unmistakable.

## Typography

- System text styles are preferred over fixed custom sizes.
- Large titles are reserved for screen-level hierarchy.
- Compact panels, cards, and toolbars use smaller text that fits.
- Long reading, writing, flashcard, code, and table content stays on stable backgrounds.

## Controls And Symbols

- Platform controls are preferred before custom controls.
- SF Symbols match the command and use consistent weight/scale.
- Icon-only controls have labels and clear hit targets.
- Primary and secondary actions are visually distinct.
- Segmented controls, pickers, toggles, steppers, sliders, menus, and tabs are used for the right interaction model.

## Color And Materials

- Color communicates state or grouping, not decoration alone.
- Materials are used for chrome and transient surfaces, not primary content.
- Contrast is sufficient in normal, Increase Contrast, and Reduce Transparency states.
- Hardcoded colors are avoided unless they are part of an intentional semantic palette.
- Liquid Glass and blur are not used to compensate for unclear hierarchy.
- Clear glass is avoided around text unless extra legibility treatment is present.

## Output Signals

Flag a finding when the UI feels like a web dashboard pasted into SwiftUI, when a custom control replaces a standard platform pattern without benefit, or when visual polish competes with the user's study, reading, writing, or editing task.
