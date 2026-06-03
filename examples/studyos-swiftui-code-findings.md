# StudyOS SwiftUI Code Findings

Fictional example findings for a code-backed design audit.

## High

- `NotebookCanvasView`: custom material card wraps the entire drawing and writing area.
  - Risk: content readability suffers and Liquid Glass guidance is applied to the content layer.
  - Fix: keep canvas paper opaque; apply material only to `CanvasToolPalette`.

## Medium

- `HomeView`: six dashboard cards use the same visual weight.
  - Risk: users cannot quickly identify the next study action.
  - Fix: make `CurrentSessionSection` primary and move secondary cards into grouped rows.

- `AITutorPanel`: generated answer text shares the same translucent background as the panel header.
  - Risk: long explanations become tiring to read.
  - Fix: keep `AITutorHeader` chrome distinct and render answer body on a solid surface.

- `FlashcardReviewView`: bottom action bar covers long answers at large Dynamic Type sizes.
  - Risk: memorization flow breaks for accessibility settings.
  - Fix: use a safe-area inset with scroll padding and large-content previews.

## Low

- `SettingsView`: destructive reset action appears beside routine preferences.
  - Risk: scan mistakes.
  - Fix: move destructive actions into a separated confirmation section.
