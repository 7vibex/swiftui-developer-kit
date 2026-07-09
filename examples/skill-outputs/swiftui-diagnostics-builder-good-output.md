# swiftui-diagnostics-builder Good Output

This fictional example demonstrates the expected evidence standard.

## Diagnostic design: local redacted report
- Evidence: `schemas/diagnostic-report.schema.json` and `examples/diagnostic-report.sample.json` define the export boundary.
- Data collected: app/build versions, device family, screen identifier, redacted breadcrumbs, and typed error codes.
- Data excluded: note text, prompts, handwriting, tokens, screenshots, and attached files unless the user chooses them.
- Confidence: high for schema validation; runtime retention was not inspected.
- Fix: validate before export and fail closed when privacy flags indicate user content or tokens.
- Verification: run `./scripts/validate-diagnostic-schema.sh` and redaction regression tests.
- Safety: remote upload is out of scope and no capture is automatic.
