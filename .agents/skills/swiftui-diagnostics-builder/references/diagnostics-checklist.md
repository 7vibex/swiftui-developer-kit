# Diagnostics Checklist

Use this checklist when adding or auditing an app diagnostics system.

## Priority Order

1. Structured `Logger` categories.
2. Breadcrumb recorder for recent user and app actions.
3. Diagnostic snapshot of current app state.
4. In-app report issue flow and local export bundle.
5. Privacy and redaction defaults.
6. MetricKit for crashes, hangs, and performance diagnostics.
7. TestFlight feedback workflow for beta testers.
8. XCTest attachments and stable accessibility identifiers for reproducible UI bugs.
9. Signposts around expensive render, save, load, export, and AI request operations.
10. Optional Crashlytics, Sentry, or remote upload after privacy review.

## Architecture Contract

- Keep diagnostics behind an app diagnostics service or similarly narrow boundary.
- Do not scatter `MXMetricManager`, signpost setup, or export assembly through feature views.
- Use one subsystem naming policy and stable category names such as `canvas`, `persistence`, `navigation`, `ai`, `rendering`, and `release`.
- Make the report bundle reproducible from local data and user-approved attachments.
- Treat MetricKit and future metric APIs as replaceable collection layers.

## Structured Logs

Use Apple `Logger` categories that match app subsystems. Typical categories:

- Canvas or editor.
- Persistence.
- AI or networking.
- Navigation.
- UI state.
- Performance.

Log state changes, failures, and transitions. Prefer public values for coarse state and private values for identifiers or error text. Avoid raw content.

Good log subjects:

- Selected tool, page change, zoom change, undo or redo.
- Document open, save start, save failure, restore result.
- AI request start, provider/model choice, request failure.
- Tab change, sheet open, toolbar mode, crash-prone screen entry.
- Render, export, load, or save duration through signposts.

## Breadcrumbs

Record the last 50 to 200 meaningful actions in memory and include them in exported reports. A breadcrumb should include:

- Timestamp.
- Category.
- Message.
- Redacted metadata.

Metadata should use IDs, counts, enum names, booleans, and small numeric state. Do not store full content. For a canvas app, breadcrumbs should make flows readable, such as open document, select highlighter, zoom, draw stroke, undo, reopen document, stroke missing.

## Diagnostic Snapshot

Capture app state at report time. Useful fields:

- App version, build number, OS version, device model, screen size, build configuration.
- Active screen, current tab, current sheet or popover, sidebar selection.
- Selected document, page, layer, tool, selection, zoom scale, pan offset, undo count, redo count.
- Canvas element count, visible layer IDs, page template, pending unsaved changes, last save time.
- SwiftData or persistence object counts, last load result, last error domain and code.
- AI provider/model, document attached yes/no, last request status.
- Memory warning or MetricKit diagnostics available yes/no.

## Report Issue Flow

The in-app flow should ask:

- What went wrong?
- What did you expect?
- Can you reproduce it?
- Include logs?
- Include current app state?
- Attach screenshot after consent?
- Include crash, hang, or MetricKit diagnostics when available?

Export a local bundle such as:

```text
app-issue-report.zip
├── issue-report.json
├── recent-actions.json
├── diagnostic-snapshot.json
├── app-logs.txt
├── crash-or-hang-diagnostics.json
├── device-info.json
└── screenshot.png
```

Only include `screenshot.png` after explicit consent.

The `issue-report.json` file should follow `report-issue-schema.md` when the report is intended for AI-assisted debugging or support triage.

## MetricKit And Signposts

Use MetricKit for crashes, hangs, watchdog terminations, CPU issues, memory pressure, launch performance, and responsiveness. Use signposts to measure expensive operations:

- Canvas render.
- Document load.
- SwiftData save.
- Thumbnail generation.
- AI request.
- Export diagnostics.

Signpost summaries should include interval name, subsystem/category, start/end timestamps, duration, success/failure state, and redacted correlation ids.

## TestFlight And UI Tests

Use TestFlight feedback for beta tester comments, screenshots, crash reports, build details, and device details. Keep custom diagnostics for app-specific visual, canvas, persistence, and state bugs that TestFlight cannot explain.

Add accessibility identifiers to critical controls and screens so UI tests and bug reports have stable names. Attach screenshots, strings, files, or folders to XCTest failures when that evidence materially helps reproduction.

## Optional Production Tooling

Crashlytics or Sentry can help with dashboards, custom keys, breadcrumbs, non-fatal errors, hangs, and performance. Treat them as optional production choices with privacy, SDK, data-sharing, and App Store disclosure implications.
