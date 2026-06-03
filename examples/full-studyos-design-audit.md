# SwiftUI Design System Audit

## Executive Summary

- StudyOS has a strong task model, but the visual system mixes iPad productivity patterns with web-dashboard card density.
- The notebook and PDF surfaces should remain quiet and opaque; the design polish belongs in navigation, toolbars, inspectors, and mode switching.
- The app needs clearer empty states, stronger sidebar-detail hierarchy, and better keyboard/pointer affordances for repeated study work.

## Review Mode

Code-only plus fictional screenshot inventory. Confidence: medium because no real screenshots were captured.

## Screens Or Components Reviewed

- Home dashboard: `HomeView`, fictional screenshot `01-home-dashboard.png`, medium confidence.
- Notebook canvas: `NotebookCanvasView`, fictional screenshot `02-notebook-canvas.png`, medium confidence.
- AI tutor panel: `AITutorPanel`, fictional screenshot `03-ai-tutor-panel.png`, medium confidence.
- Flashcard review: `FlashcardReviewView`, fictional screenshot `04-flashcard-review.png`, medium confidence.

## Pass Criteria

- Sidebar navigation groups the main study modes clearly.
- Canvas tools are compact enough to float above content.
- Flashcard content uses stable text surfaces and avoids decorative material behind answer text.

## Findings

### High

- Issue: Notebook, PDF, and AI answer areas use the same card styling as navigation chrome.
- Evidence: `NotebookCanvasView`, `PDFReaderPane`, `AITutorPanel`.
- User impact: primary study content competes with decoration and becomes harder to scan.
- Recommended fix: reserve material/glass for toolbars and panel headers; keep long content on solid backgrounds.
- SwiftUI direction: use standard scroll, text, and document containers with semantic toolbar or inspector chrome.

### Medium

- Issue: Home dashboard cards are equal weight, so the next study action is not obvious.
- Evidence: `HomeView`.
- User impact: users must read every card before choosing what to do next.
- Recommended fix: make the current study session the primary region, then group secondary actions below.
- SwiftUI direction: use a stable `NavigationSplitView` sidebar plus one primary content section.

### Medium

- Issue: Icon-only canvas controls rely on shape and position but lack visible grouping.
- Evidence: `NotebookCanvasView`.
- User impact: repeated Pencil use becomes slower and harder to learn.
- Recommended fix: group tools by mode, edit, and view commands; add hover and keyboard affordances.
- SwiftUI direction: use platform buttons, SF Symbols, labels for accessibility, and a compact floating palette.

## Platform Fit

- iPhone: collapse dashboard sections and avoid persistent sidebars.
- iPad: prefer sidebar-detail layout, floating canvas tools, and inspector panels.
- macOS: use toolbar/sidebar/inspector commands instead of bottom navigation as the main pattern.
- Keyboard/pointer/Pencil: add shortcuts for mode switching, hover affordances for tool buttons, and Pencil-specific canvas tool persistence.

## Design-System Fix Order

1. Reframe primary content as solid reading/writing surfaces.
2. Normalize navigation, mode switching, and inspector chrome.
3. Add empty, loading, and long-title preview states for Home, Canvas, AI, and Flashcards.

## Verification

- Dynamic Type: preview dashboard cards and tutor answers at large sizes.
- Increase Contrast / Reduce Transparency: confirm primary content and warnings stay readable.
- Keyboard and pointer: test tab order, hover states, and shortcuts.
- iPad split view or macOS resize: verify sidebar-detail behavior at compact and expanded widths.
- Screenshot or preview states: capture Home, Notebook, AI tutor, and Flashcard screens after privacy approval.
