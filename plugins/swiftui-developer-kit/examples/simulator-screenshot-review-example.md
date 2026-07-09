# Simulator Screenshot Review

## Capture Mode

Approved Simulator fallback capture with `xcrun simctl io booted screenshot`.

## Screens Captured

| File | Screen | Notes |
| --- | --- | --- |
| `01-home.png` | Home | Portrait iPad |
| `02-canvas.png` | Canvas | Pencil toolbar open |
| `03-notebook.png` | Notebook | Long note visible |

## Visual Issues

- Home cards compete with the bottom navigation because both use translucent backgrounds.
- Canvas zoom controls overlap the safe area in landscape.

## Layout Issues

- Notebook toolbar wraps poorly at larger Dynamic Type sizes.
- Planner preview cards have inconsistent vertical spacing.

## Readability Issues

- Flashcard answer text is too low contrast over a blurred background.
- AI Tutor suggestions use small secondary text for primary actions.

## Accessibility Risks

- Icon-only Canvas tools need accessibility labels.
- The selected tab uses color only.

## Recommended Fixes

1. Keep study cards opaque.
2. Add labels to Canvas controls.
3. Increase contrast for tutor suggestions.
4. Test Notebook at accessibility text sizes.

## Follow-up Screenshots Needed

- Canvas landscape.
- Notebook with extra-large Dynamic Type.
