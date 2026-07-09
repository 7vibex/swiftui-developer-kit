# Issue Report Format

Use a stable report format so a developer or AI assistant can reason from the same evidence every time.

## JSON Shape

```json
{
  "title": "Highlighter opacity increases too quickly",
  "observed": "Repeated strokes make text unreadable.",
  "expected": "Highlighted text remains readable after repeated strokes.",
  "reproductionSteps": [
    "Open a study note",
    "Select highlighter",
    "Draw over the same sentence several times",
    "Observe text readability"
  ],
  "environment": {
    "appVersion": "1.4.0",
    "build": "142",
    "osVersion": "iPadOS 26.0",
    "device": "iPad Pro 13-inch",
    "configuration": "Debug",
    "dynamicType": "AX3",
    "reduceMotion": true,
    "reduceTransparency": true,
    "voiceOverRunning": false,
    "inputMode": "apple-pencil-pro"
  },
  "snapshot": {
    "activeScreen": "Canvas",
    "selectedTool": "Highlighter",
    "zoomScale": 1.8,
    "canvasElementCount": 42,
    "undoCount": 3,
    "redoCount": 0
  },
  "attachments": {
    "logs": true,
    "breadcrumbs": true,
    "screenshot": false,
    "signpostSummary": true,
    "metricKitDiagnostics": false
  },
  "privacy": {
    "redactedFields": ["noteText", "accountEmail"],
    "hashedFields": ["documentID"],
    "neverCollected": ["fullNoteBody", "clipboardContents"]
  }
}
```

For larger support exports or AI-debugging bundles, use `report-issue-schema.md`.

## AI Debugging Prompt

```text
You are debugging a SwiftUI Apple app.

Problem:
[short title]

Observed behavior:
[what happened]

Expected behavior:
[what should happen]

Reproduction steps:
1. ...
2. ...
3. ...

Environment:
- App version:
- Build:
- OS version:
- Device:
- Xcode version:
- Build configuration:

Current app state:
[DiagnosticSnapshot JSON]

Recent actions:
[Breadcrumb JSON]

Logs:
[relevant log excerpt]

Screenshots:
[attach only after consent]

Relevant files:
[paths or attached files]

Task:
Find the most likely root cause. Keep the fix scoped. Propose tests that prove the bug is fixed.
```

## Good Reports

- Describe observed and expected behavior separately.
- Include exact reproduction steps.
- Include environment and app-state snapshot.
- Include accessibility state for visual, input, and layout bugs.
- Include recent breadcrumbs and relevant logs.
- Include signpost summaries for performance, save/load, render, export, or AI request bugs.
- Include screenshots only after consent.
- Include redaction and never-collected fields.
- Point to likely files when known.

## Weak Reports

- Say only that something is broken.
- Include raw private content.
- Omit app version, build, device, and OS.
- Omit recent actions before the issue.
- Mix unrelated bugs into one report.
