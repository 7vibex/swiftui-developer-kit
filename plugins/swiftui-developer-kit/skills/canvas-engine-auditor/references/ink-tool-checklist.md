# Ink And Tool Checklist

## Tool Defaults
- Pen/pencil should default to readable width and full opacity unless design says otherwise.
- Marker/highlighter should default to translucent opacity and preserve text readability when strokes overlap.
- Eraser should define vector erase, pixel erase, or element erase.
- Lasso should define selection hit testing, movement, resize, and commit behavior.
- Text/image/sticky/AI elements should have stable ids and transform handles.

## Highlighter Rules
- Do not use a 100% opacity marker as the default study highlighter.
- Define expected overlap behavior: natural darkening, capped alpha, blend mode, or dedicated highlighter render pass.
- Test highlight over black text, colored text, PDF text, dark mode, and grid/ruled backgrounds.
- Test repeated strokes and undo/redo.

## Tool State
- One selected tool source of truth.
- Tool changes should not clear current page/layer selection.
- Switching documents/pages should restore appropriate tool and not mutate old pages.
- Toolbar UI, keyboard shortcuts, PencilKit picker, and canvas renderer should agree.

## Custom Canvas Tools
- Define whether tools create vector model elements, raster pixels, PencilKit strokes, or overlays.
- Avoid mixing vector and raster paths without a clear export and persistence strategy.
