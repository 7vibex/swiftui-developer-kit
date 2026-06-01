# Liquid Glass Placement Audit

## Executive Summary

StudyOS should use Liquid Glass for secondary controls and navigation chrome, not for the reading or writing surfaces. The strongest candidates are the Canvas tool palette, Notebook mode switcher, AI Tutor mini panel header, and compact bottom navigation.

## Review Mode

Screenshot-plus-code example.

## Screens Reviewed

- Home
- Canvas
- Notebook
- AI Tutor
- Flashcards
- Planner
- Settings

## Best Places to Use Liquid Glass

- Floating Canvas tool palette.
- Notebook search and mode switcher.
- AI Tutor compact prompt bar.
- Sheet headers for study set actions.

## Places to Avoid Liquid Glass

- Notebook writing area.
- PDF reading pane.
- Flashcard question and answer text.
- Planner task forms.
- Error and destructive action areas.

## Screen-by-Screen Recommendations

- Home: use glass for the small filter control, keep study cards solid.
- Canvas: use glass for pencil tools and zoom controls.
- Notebook: keep pages solid; use glass only for navigation and search.
- AI Tutor: use glass for the collapsed assistant handle, not answer text.
- Flashcards: keep cards opaque for memory work.
- Planner: avoid glass on dense task rows.
- Settings: use standard grouped forms.

## SwiftUI Implementation Plan

Replace custom blur backgrounds on content cards with solid system backgrounds. Introduce a reusable chrome style only for compact toolbars and transient panels.

## User Feedback Signals

Watch for reports of unreadable text, visual fatigue, and difficulty distinguishing controls from content.

## Before/After Design Notes

Before: blur appears behind study content. After: content stays stable while controls gain depth.

## Codex Fix Prompts

```text
Use the liquid-glass-placement-auditor skill. Convert only the Canvas floating tool palette to Liquid Glass and leave the drawing canvas opaque.
```

## Verification Checklist

- Reduce Transparency checked.
- Dynamic Type large sizes checked.
- iPad split view checked.
- Destructive controls remain solid.
