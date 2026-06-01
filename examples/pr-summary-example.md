# Pull Request Draft

## Branch Name

`feature/studyos-canvas-toolbar`

## PR Title

Improve Canvas toolbar hierarchy and accessibility

## Summary

Updates the StudyOS Canvas toolbar so drawing controls are easier to scan, labeled for VoiceOver, and visually separated from the canvas content.

## Changes

- Reworked Canvas floating toolbar layout.
- Added accessibility labels to Pencil, Eraser, Lasso, and Color controls.
- Kept the drawing canvas opaque while applying glass only to toolbar chrome.

## Testing

- Ran unit tests for Canvas tool selection.
- Captured Simulator screenshots for Canvas portrait and landscape.
- Reviewed VoiceOver labels manually.

## Risks

- Toolbar spacing may need more tuning on smaller iPads.

## Screenshots Needed

- Canvas portrait.
- Canvas landscape.
- Canvas with color picker open.

## Reviewer Checklist

- Verify labels match visible actions.
- Verify glass does not reduce canvas readability.
- Verify Pencil controls are reachable.

## Release Notes

Improved Canvas drawing controls for readability and accessibility.
