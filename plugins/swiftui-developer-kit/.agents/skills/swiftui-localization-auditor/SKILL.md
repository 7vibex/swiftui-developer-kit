---
name: swiftui-localization-auditor
description: Audit SwiftUI, iOS, iPadOS, and macOS localization for String Catalog coverage, runtime language switching, pluralization, locale-aware formatting, RTL, accessibility strings, and localized assets.
---

# SwiftUI Localization Auditor

Audit user-visible language behavior across bundle resources, system language, and any app-selected language. Catalog completeness alone does not prove that a language works at runtime.

## References

- `references/localization-audit-checklist.md`
- `references/runtime-language-checklist.md`
- `references/apple-localization-sources.md`
- `../../../docs/apple-source-map.md`
- `references/output-contract.md`
- Worked fictional example: `../../../examples/swiftui-localization-audit-example.md`

## Check

- String Catalogs, `.strings`, `.stringsdict`, `InfoPlist.strings`, target membership, and declared localizations.
- SwiftUI labels, accessibility text, alerts, menus, errors, empty states, widgets, notifications, and user-visible fallback strings.
- Plural, interpolation, date, time, number, list, measurement, currency, and relative-date behavior.
- App-selected language propagation versus system-language behavior.
- Right-to-left layout, directional icons, and locale-specific assets where relevant.
- Translation coverage, missing keys, untranslated fallbacks, and source-language leaks.

## Workflow

1. Identify targets, supported locales, development region, resource bundles, and the app's language-selection model.
2. Map user-facing string APIs and resource files before flagging literals; distinguish user content, identifiers, debug text, and intentionally verbatim text.
3. Trace selected language from its source of truth through `Locale`, resource lookup, formatters, persisted settings, previews, widgets, extensions, and settings screens where present.
4. Audit locale-sensitive formatting and plural rules separately from translation coverage.
5. Inspect right-to-left layout and localized assets when supported locales or visual structure make them relevant.
6. Build an evidence matrix that separates static resource coverage from observed runtime behavior.
7. Recommend the smallest safe fix order and verification matrix.

## Evidence Standards

Every finding should cite a key, resource, target, symbol, formatter, locale path, test, screenshot supplied by the user, or an explicit evidence gap. Do not call a locale complete merely because a catalog entry exists. Do not judge linguistic quality without qualified language review.

## Guardrails

- Do not build, launch, change device or Simulator language, or inspect live user content unless the user or host project approves that workflow.
- Ask before screenshots, Appshots, Simulator capture, or Computer Use; verify that no private content is visible before capture.
- Do not translate, export, upload, or share private strings, user documents, messages, tokens, or production data without explicit scope and consent.
- Do not replace intentional `Text(verbatim:)`, stable identifiers, user-entered content, or protocol values with localization calls without evidence that they are user-facing UI.
- State separately what was inspected in code, resource files, tests, and a running app.

## Do Not Use When

- The task is only translation writing, App Store submission metadata, screenshot aesthetics, or a general SwiftUI architecture review.
- The project has no Apple app localization surface to inspect.

## Done When

- Supported locales, resource coverage, runtime language ownership, formatting, RTL, and relevant extension surfaces are mapped or marked uninspected.
- Findings separate static gaps from runtime proof and include severity, evidence, impact, fix direction, verification, confidence, and missing evidence.
- The output gives a safe fix order and a locale-by-flow verification matrix without claiming untested languages work.

## Output

Use `references/output-contract.md`.

Follow `../../../docs/skill-quality-standard.md` and compare `../../../examples/skill-outputs/swiftui-localization-auditor-bad-output.md` with `../../../examples/skill-outputs/swiftui-localization-auditor-good-output.md`.
