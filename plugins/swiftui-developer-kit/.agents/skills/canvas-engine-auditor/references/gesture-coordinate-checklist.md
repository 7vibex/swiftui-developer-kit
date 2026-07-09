# Gesture And Coordinate Checklist

## Coordinate Spaces
- Define document space: stable coordinates saved in the model.
- Define viewport space: visible screen after zoom, pan, safe area, and rotation.
- Define page space: coordinates relative to a finite PDF/page/template.
- Define global/local/named SwiftUI spaces used by gestures.
- Convert once at the boundary; do not mix coordinate spaces inside model code.

## Gesture Conflicts
- Test Apple Pencil drawing versus finger pan/zoom.
- Test one-finger selection drag versus ScrollView/PKCanvasView scrolling.
- Test pinch zoom while a selected element is active.
- Test lasso/eraser modes against normal stroke creation.
- Test hover/squeeze/double-tap availability if targeting Apple Pencil Pro behavior.
- Watch for `DragGesture(minimumDistance: 0)` stealing vertical scroll.

## Transform Formula Contract
For every element mutation, verify:
- Screen point → viewport point.
- Viewport point → document/page point.
- Save in document/page point, not transient screen point.
- Render by applying the inverse transform from saved model coordinates.

## Rotation And Multitasking
- Rotate device.
- Enter/exit Split View or Stage Manager where supported.
- Show/hide keyboard.
- Change Dynamic Type if controls overlay the canvas.
- Reopen document after each change and compare saved content alignment.
