# Report Issue Schema

Use this schema for AI-readable diagnostics exports, support bundles, and TestFlight follow-up. Keep the exported shape stable so reports can be compared across builds.

```json
{
  "schema_version": "1.0",
  "app": {
    "bundle_id": "com.example.studyos",
    "version": "2.3.0",
    "build": "412",
    "configuration": "Debug"
  },
  "environment": {
    "platform": "iPadOS",
    "os_version": "26.4",
    "device_model": "iPad Pro 13-inch",
    "locale": "en-US",
    "appearance": "dark",
    "dynamic_type": "AX3",
    "reduce_motion": true,
    "reduce_transparency": true,
    "voiceover_running": false,
    "input_mode": "apple-pencil-pro"
  },
  "feature": "canvas-pdf-overlay",
  "reproduction_steps": [
    "Open Biology notebook",
    "Open attached PDF",
    "Zoom to 250%",
    "Draw highlight on page 3",
    "Close and reopen document"
  ],
  "expected_result": "Highlight remains aligned and crisp",
  "actual_result": "Highlight reopens offset and blurry",
  "artifacts": {
    "screenshots": [],
    "screen_recording": null,
    "recent_logs": ["canvas.log"],
    "breadcrumbs": ["recent-actions.json"],
    "signpost_summary": ["autosave.json"],
    "metric_payload_ids": ["mx-2026-06-13-1"]
  },
  "state_snapshot": {
    "document_id_hash": "hash-local-123",
    "page_index": 2,
    "zoom_scale": 2.5,
    "selected_tool": "highlighter",
    "unsaved_changes": true
  },
  "privacy": {
    "redacted_fields": ["document_title", "note_text", "account_email"],
    "hashed_fields": ["document_id"],
    "never_collected": ["full_note_body", "prompt_history", "clipboard_contents"]
  }
}
```

## Required Fields

- `schema_version`, `app`, `environment`, `feature`, `reproduction_steps`, `expected_result`, and `actual_result`.
- `environment` must include accessibility state when the bug is visual, input, layout, or interaction-related.
- `artifacts` must distinguish user-approved attachments from logs, breadcrumbs, signpost summaries, and MetricKit payload references.
- `state_snapshot` must use IDs, hashes, counts, enum values, booleans, and small numeric state instead of raw content.
- `privacy` must list redacted, hashed, and never-collected data categories.

## Correlation Rules

- Match `feature` to Logger subsystem/category names.
- Compare `state_snapshot` to recent breadcrumbs before proposing a root cause.
- Use signpost intervals for slow save, load, render, export, startup, and AI request bugs.
- Use MetricKit payload ids as supporting evidence, not as the only reproduction path.
- Include TestFlight feedback ids when the report comes from a beta tester.
