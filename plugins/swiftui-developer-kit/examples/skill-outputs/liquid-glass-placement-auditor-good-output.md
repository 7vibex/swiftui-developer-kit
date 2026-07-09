# Liquid Glass Placement Audit

## Executive Summary

- Use Liquid Glass selectively for the fictional notebook toolbar.
- Keep notes, forms, warnings, and destructive confirmations opaque.
- Runtime visual evidence is still needed before a final polish decision.

## Review Mode

Code-only. Confidence is medium because no approved screenshots were inspected.

## Screens Reviewed

- Notebook editor — `FictionalStudyApp/Sources/Notebook/NotebookEditorView.swift`; medium confidence.

## Best Places to Use Liquid Glass

- Surface: notebook toolbar.
- Surface classification: chrome.
- Glass variant: regular, subject to SDK verification.
- Reason: fixed controls are separate from editable content.
- Confidence: medium.
- Accessibility risk: low with opaque Reduce Transparency fallback.
- Oldest-supported-OS fallback: existing semantic toolbar material.
- Reduce Transparency fallback: opaque semantic background.
- SwiftUI direction: isolate the toolbar wrapper behind availability checks.
- Pass criteria: toolbar stays readable at Dynamic Type and contrast settings.

## Places to Avoid Liquid Glass

- Surface: note editor and destructive confirmation.
- Surface classification: primary content and warning UI.
- Reason: both need stable contrast and attention.
- Severity: high if glass blurs or reduces legibility.
- Safer alternative: opaque content surface and standard confirmation styling.
- Fail signal: reading fatigue, weak contrast, or obscured destructive action.

## Screen-by-Screen Recommendations

- Screen: notebook editor.
- Use: compact toolbar controls.
- Use carefully: transient inspector.
- Avoid: note body and forms.
- Keep opaque: warnings and deletion confirmation.
- Verification: approved build/run plus accessibility settings; request screenshot approval separately.
- User impact: glass in the editor would reduce reading and writing legibility.
- Missing evidence: approved runtime visual review.

## SwiftUI Implementation Plan

- Files or components likely affected: toolbar wrapper only.
- Minimal change: add a guarded chrome modifier.
- OS availability: verify in the selected SDK.
- Fallback for Reduce Transparency: opaque semantic material.
- Oldest-supported-OS fallback: existing toolbar.
- API verification needed: yes.

## Pass / Fail Criteria

- Pass: controls gain depth without reducing content readability.
- Fail: content receives glass or accessibility contrast regresses.
- Older OS: current toolbar remains intact.
- Reduce Transparency: opaque fallback is used.

## User Feedback Signals

Users may report a harder-to-read editor or unclear destructive actions if the boundary is wrong.

## Before/After Design Notes

- Before: all toolbar surfaces use the same flat material.
- After: only compact chrome gains depth; content stays stable.
- Why it improves the task: it separates controls from writing.

## Codex Fix Prompts

- Prompt 1: inspect the toolbar wrapper and add an availability-safe, opaque-fallback glass treatment only there.
- Prompt 2: with build/run approval, verify contrast and Dynamic Type; do not capture screenshots without separate approval.

## Verification Checklist

- [ ] Reduce Transparency.
- [ ] Reduce Motion.
- [ ] Dynamic Type.
- [ ] VoiceOver labels.
- [ ] iPad layout.
