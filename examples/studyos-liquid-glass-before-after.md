# StudyOS Liquid Glass Before / After

Fictional implementation example for Liquid Glass recommendations.

## Before

- Notebook page, PDF pane, AI answer text, and toolbar all share `.ultraThinMaterial`.
- Delete and reset actions appear inside the same translucent control cluster as routine actions.
- Older OS fallback is implicit and not reviewed.

## After

- Notebook, PDF, flashcard, and AI answer content use opaque backgrounds.
- Canvas tool palette, mode switcher, sheet header, and compact assistant header use chrome treatment.
- Destructive actions use solid warning styling and confirmation.
- iOS/iPadOS 26+ glass APIs are availability-gated; iOS 17/18 fallback preserves existing UI or uses approved system material.
- Reduce Transparency uses solid system backgrounds.

## Pass / Fail Criteria

Pass:

- Glass is limited to controls, navigation, and transient chrome.
- Primary content remains readable with Increase Contrast and Reduce Transparency.
- Older deployment targets build and preserve an intentional non-glass path.

Fail:

- Long text, PDF pages, notebook writing, or flashcard answers sit on translucent material.
- Custom blur is used to imitate Liquid Glass on unsupported OS versions.
- Destructive actions lose contrast or hierarchy.
