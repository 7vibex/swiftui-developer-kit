---
name: swiftui-diagnostics-builder
description: Build or review privacy-safe SwiftUI, iOS, iPadOS, or macOS diagnostics, issue reports, logs, breadcrumbs, MetricKit, signposts, and AI-readable bug reports.
---

# SwiftUI Diagnostics Builder

Build or review app diagnostics that make SwiftUI bugs observable, reproducible, privacy-safe, and useful to humans or AI assistants.

## References

- `references/apple-doc-links.md`
- `references/diagnostics-checklist.md`
- `references/issue-report-format.md`
- `references/privacy-and-redaction.md`
- `references/output-contract.md`

Use this skill for diagnostic feature work, not general bug fixing. If the user is only asking to diagnose one current build failure, use the build-debugging workflow instead.

## Workflow

1. Identify the bug classes the diagnostics must explain: crashes, hangs, visual glitches, canvas state loss, persistence failures, AI request failures, navigation bugs, or performance regressions.
2. Choose the smallest useful diagnostic surface: structured `Logger` categories, breadcrumbs, app-state snapshot, issue-report export, MetricKit, signposts, TestFlight feedback, UI-test attachments, or optional third-party crash tooling.
3. Define privacy boundaries before collecting anything: local-only storage, export-on-demand, consent for screenshots, redaction rules, retention, and whether remote upload is allowed.
4. Plan the data model for the diagnostic snapshot and report bundle.
5. Implement in small slices that match the app architecture: logging helpers, breadcrumb store, snapshot provider, report screen, exporter, and tests.
6. Add accessibility identifiers and XCTest attachments for critical reproducible flows when UI tests are stable enough.
7. Verify the report output contains useful state and does not include private user content by default.
8. When code changes are made in an Apple app project, build and run on the required simulator according to repository instructions. Ask before screenshots, Appshots, Computer Use, or Simulator capture.

## Guardrails

- Do not log full note text, handwritten content, prompts, messages, documents, tokens, secrets, or production user data by default.
- Do not add remote upload, session replay, crash SDKs, or analytics without documenting user consent, privacy labels, and release-review impact.
- Do not make screenshots automatic. Ask for consent and confirm no sensitive content is visible.
- Prefer IDs, counts, screen names, feature flags, error domains, and redacted state over raw content.
- Keep diagnostic payloads deterministic enough that a developer can attach them to a bug report and reproduce the issue.

## Output

Use `references/output-contract.md`.
