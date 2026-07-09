# SwiftUI Diagnostics Plan

## Summary

- Goal: export a local, redacted report for fictional canvas failures.
- App area or bug class: persistence and drawing diagnostics.
- Confidence and evidence reviewed: high for schema fixtures; runtime retention uninspected.
- Severity: medium because an unsafe export would expose private content.
- Evidence: `schemas/diagnostic-report.schema.json` and `examples/diagnostic-report.sample.json`.
- User impact: a diagnostic export must not reveal notes, handwriting, or tokens.
- Missing evidence: runtime retention and host-app integration.

## Diagnostic Design

- Logging categories: canvas persistence and export.
- Breadcrumb events: open, draw, save, reopen, export.
- Snapshot fields: app/build version, device family, screen identifier, typed error code.
- Report issue flow: explicit local export.
- Report Issue schema version: current checked-in schema.
- Export bundle files: validated JSON report only.
- MetricKit, signpost, TestFlight, or third-party tooling decisions: optional signposts; no third-party SDK.
- Correlation strategy: feature ID plus redacted breadcrumbs and typed error codes.

## Privacy And Consent

- Data excluded by default: note text, prompts, handwriting, tokens, screenshots, attachments.
- Redacted fields: user-facing labels.
- Hashed fields: stable non-content identifiers if needed.
- Never-collected fields: secrets and raw user content.
- User consent points: explicit export and any later attachment.
- Redaction strategy: fail closed when privacy flags indicate content or tokens.
- Remote upload or SDK implications: out of scope.

## Implementation Plan Or Changes

- Files to add or modify: report builder, redaction validator, export action.
- State ownership and data flow: diagnostics service owns report assembly.
- Tests or identifiers to add: redaction and schema-invalid fixtures.
- Release-review impacts: privacy review before remote upload exists.

## Verification

- Build, run, or test commands: `./scripts/validate-diagnostic-schema.sh` plus redaction tests.
- Exported report inspection result: fictional sample contains no content/tokens/screenshots.
- Reproduction flow: create a non-sensitive error, export locally, inspect flags.
- Remaining risks: runtime retention policy uninspected.

## Follow-Up

- Optional production tooling: MetricKit/signposts behind the diagnostics service.
- Additional UI tests: export consent and error handling.
- More diagnostics needed for hard-to-reproduce bugs: timing markers for save/reopen.
