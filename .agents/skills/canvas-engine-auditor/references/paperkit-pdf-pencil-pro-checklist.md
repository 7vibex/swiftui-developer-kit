# PaperKit, PDF Overlay, And Apple Pencil Pro Checklist

Use this reference when a canvas app includes PDF markup, Notes-like markup, custom Pencil tools, hover, squeeze, roll, or rich annotation objects.

## PaperKit Adoption Questions

- Does the product need drawings plus shapes, images, and text boxes as first-class markup?
- Does the app need a stored markup document that can be saved, loaded, duplicated, exported, and migrated?
- Would PencilKit-only drawing force the app to invent a parallel object model for shapes and text?
- Can the app adopt PaperKit without breaking existing PencilKit drawing data or PDF annotation flows?
- What older-OS behavior is expected if PaperKit is unavailable?

When PaperKit is a candidate, report it as an adoption decision with migration, fallback, and file-format risk. Do not imply adoption is free.

## PDF Overlay Round Trip

For any `PDFPageOverlayViewProvider` or PDF overlay architecture, require evidence for:

- Page identity and page index stability.
- Coordinate conversion between PDF page bounds, visible viewport, zoom, rotation, crop, and overlay view.
- Overlay creation and teardown for reused pages.
- Drawing or markup save path.
- Export path when users share or duplicate the PDF.
- Close and reopen verification.
- Reorder, rotate, crop, and mixed page-size verification.

Fail the audit if annotations can be created but no save/export/reopen path is identifiable.

## Apple Pencil Pro And Hardware Input

Check:

- Preferred double-tap and squeeze actions are respected before custom palettes appear.
- Hover preview does not mutate committed model state.
- Roll or barrel-aware behavior has non-Pencil fallback.
- Haptic or canvas feedback is used sparingly and never as the only confirmation.
- Finger, pointer, keyboard, and VoiceOver users can still reach core tools.
- Hardware-only behavior is marked as requiring device verification, not Simulator-only proof.

## Verification Matrix

| Area | Must Verify |
| --- | --- |
| Zoom and pan | Draw at 50%, 100%, 250%, and 400%; pan while drawing; reopen at expected viewport if the app promises restore. |
| Persistence | Draw, background, force quit, reopen; duplicate notebook or page; verify stroke ownership. |
| PDF overlays | Annotate rotated page, cropped page, mixed page-size document, page reorder, export, close, and reopen. |
| Tooling | Change tool in native picker, custom palette, hover preview, squeeze action, roll-aware behavior, and non-Pencil fallback. |
| Undo and redo | Canvas edits, PDF-overlay edits, cross-page edits, layer changes, delete page then undo. |
| Performance | Long stroke sessions, thumbnail generation, autosave frequency, memory pressure, and main-thread stalls. |
| Accessibility | VoiceOver on floating toolbars, Larger Text in labels, Reduce Motion, Reduce Transparency, keyboard and pointer access. |
