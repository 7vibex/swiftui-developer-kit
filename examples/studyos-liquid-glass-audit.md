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

- Floating Canvas tool palette. Confidence: high. Accessibility risk: medium until labels are verified.
- Notebook search and mode switcher. Confidence: medium. Keep the writing page opaque.
- AI Tutor compact prompt bar. Confidence: medium. Do not apply glass behind generated answer text.
- Sheet headers for study set actions. Confidence: high when the sheet body remains solid.

## Places to Avoid Liquid Glass

- Notebook writing area. Severity: high because text entry needs stable contrast.
- PDF reading pane. Severity: high because document content is the primary task.
- Flashcard question and answer text. Severity: high because memorization depends on readability.
- Planner task forms. Severity: medium because dense form fields lose hierarchy over blur.
- Error and destructive action areas. Severity: critical because user intent must be unmistakable.

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

Likely file targets in a real app:

- `CanvasToolbar`: apply Liquid Glass or system material to compact controls.
- `NotebookPageView`: remove custom material from writing surface.
- `FlashcardReviewView`: use solid card backgrounds.
- `AITutorPanel`: separate header chrome from generated answer body.

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
