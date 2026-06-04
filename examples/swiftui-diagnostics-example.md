# SwiftUI Diagnostics Example

This fictional example shows the shape of a diagnostics plan for a study app with a canvas and AI tutor.

## Prompt

```text
Use the swiftui-diagnostics-builder skill. Add an AI-readable diagnostics and report issue workflow for my SwiftUI iPad study app. It should help debug canvas, SwiftData, and AI tutor bugs without exposing private notes by default.
```

## Summary

Goal: add local diagnostics export for visual, persistence, and AI request bugs.

Evidence reviewed: app architecture notes, canvas feature list, and release constraints. Confidence is medium until code paths are inspected.

## Diagnostic Design

- Logging categories: Canvas, Persistence, AI, Navigation, UI, Performance.
- Breadcrumbs: keep the last 150 actions with timestamp, category, message, and redacted metadata.
- Snapshot fields: active screen, selected document ID, selected page ID, selected tool, zoom, pan, layer count, element count, undo count, redo count, pending save state, last AI request status, app version, build, OS, and device.
- Report issue flow: observed behavior, expected behavior, reproduction steps, include logs, include app state, include screenshot after consent.
- Export bundle: `issue-report.json`, `recent-actions.json`, `diagnostic-snapshot.json`, `app-logs.txt`, `device-info.json`, and optional `screenshot.png`.

## Privacy And Consent

- Do not include note text, handwriting, prompts, AI responses, API keys, auth headers, or raw user documents by default.
- Use redacted document IDs, counts, enum values, error domains, and app state.
- Screenshot attachment requires explicit consent and a visible-content check.
- Remote upload is deferred until privacy labels and release notes are reviewed.

## Implementation Plan

1. Add `AppLogger` categories.
2. Add `BreadcrumbStore` with bounded in-memory history.
3. Add `DiagnosticSnapshotProvider` that reads current app state without owning business logic.
4. Add `IssueReportExporter` that writes JSON files locally.
5. Add a developer-only Report Issue sheet.
6. Add accessibility identifiers for critical canvas and tutor controls.
7. Add a UI test that attaches the exported report after reproducing a highlighter flow.

## Verification

- Build and run on the required iPad simulator.
- Export a report from the canvas screen.
- Inspect the JSON and confirm it includes state, breadcrumbs, app version, build, OS, and device.
- Confirm the export excludes note text and handwriting unless explicitly enabled.
- Run focused tests for exporter encoding and breadcrumb bounds.
