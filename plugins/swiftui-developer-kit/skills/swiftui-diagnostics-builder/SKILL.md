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
- `references/report-issue-schema.md`
- `references/privacy-and-redaction.md`
- `../../docs/apple-source-map.md`
- `../../docs/apple-api-inventory.md`
- `references/output-contract.md`
- Worked fictional example: `../../examples/swiftui-diagnostics-example.md`

Use this skill for diagnostic feature work, not general bug fixing. If the user is only asking to diagnose one current build failure, use the build-debugging workflow instead.

## Workflow

1. Identify the bug classes the diagnostics must explain: crashes, hangs, visual glitches, canvas state loss, persistence failures, AI request failures, navigation bugs, or performance regressions.
2. Choose the smallest useful diagnostic surface: structured `Logger` categories, breadcrumbs, app-state snapshot, issue-report export, MetricKit, signposts, TestFlight feedback, UI-test attachments, or optional third-party crash tooling.
3. Define privacy boundaries before collecting anything: local-only storage, export-on-demand, consent for screenshots, redaction rules, retention, and whether remote upload is allowed.
4. Plan the data model for the diagnostic snapshot and report bundle.
5. Require a Report Issue schema before implementation when the user asks for AI-readable bug reports or support exports.
6. Implement in small slices that match the app architecture: logging helpers, breadcrumb store, snapshot provider, report screen, exporter, and tests.
7. Add accessibility identifiers and XCTest attachments for critical reproducible flows when UI tests are stable enough.
8. Verify the report output contains useful state and does not include private user content by default.
9. Correlate feature, state snapshot, breadcrumbs, Logger categories, signpost intervals, MetricKit payload ids, and TestFlight feedback before proposing a root-cause fix.
10. When code changes are made in an Apple app project, build and run only if the user or host repository has approved it; then use the required simulator according to repository instructions. Otherwise record the static verification completed and the approval still needed. Ask before screenshots, Appshots, Computer Use, or Simulator capture.

## Guardrails

- Do not log full note text, handwritten content, prompts, messages, documents, tokens, secrets, or production user data by default.
- Do not add remote upload, session replay, crash SDKs, or analytics without documenting user consent, privacy labels, and release-review impact.
- Do not make screenshots automatic. Ask for consent and confirm no sensitive content is visible.
- Prefer IDs, counts, screen names, feature flags, error domains, and redacted state over raw content.
- Keep diagnostic payloads deterministic enough that a developer can attach them to a bug report and reproduce the issue.
- Mark every user-content field as redacted, hashed, omitted, or explicitly user-attached.
- Hide MetricKit and future diagnostics API choices behind an app diagnostics service rather than coupling feature code to one collection API.

## Do Not Use When

- The user only needs a one-off root-cause diagnosis, build fix, or release review.
- Diagnostics would require collecting private content without a consent and redaction plan.

## Done When

- Bug classes, diagnostic surface, privacy boundaries, schema, retention, and export behavior are defined.
- Redaction and consent rules cover screenshots, logs, user content, tokens, and remote upload.
- Output includes implementation slices, tests, and verification for useful but privacy-safe reports.

## Output

Use `references/output-contract.md`.

Follow `../../docs/skill-quality-standard.md` and compare `../../examples/skill-outputs/swiftui-diagnostics-builder-bad-output.md` with `../../examples/skill-outputs/swiftui-diagnostics-builder-good-output.md`.

Validate compatible report examples with `../../scripts/validate-diagnostic-schema.sh` against `../../schemas/diagnostic-report.schema.json`.
