# Performance Checklist

## Interaction Budget
- Drawing should not perform expensive persistence or full document recomposition per input point.
- Pan/zoom should update viewport state without rewriting document model.
- Selection movement should batch transient updates and commit final model changes on end.
- Thumbnail generation should be debounced and off the critical drawing path.

## Rendering Risks
- Huge SwiftUI view files combining gesture, persistence, drawing, toolbar, and AI logic.
- Redrawing all pages when one visible page changes.
- Full bitmap re-render on every stroke point.
- Unbounded infinite canvas size with no tiling or paging strategy.
- Excessive use of `drawingGroup()` without measuring memory/GPU cost.
- `TimelineView` used for static drawing.
- MainActor file IO or image encoding in the drawing path.

## Measurement
- Record simulator/device, iPadOS version, document size, page count, stroke count, and reproduction steps.
- Use Xcode Instruments when performance is the reported bug.
- Do not claim performance is fixed without build/run evidence and a repeatable stress case.
