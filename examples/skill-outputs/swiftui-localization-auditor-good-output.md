# swiftui-localization-auditor Good Output

This fictional example demonstrates a complete, evidence-based audit.

## Executive Summary

- Audit scope: `LumenNotes` iOS app and widget source/resources; no running app was inspected.
- Supported locales discovered: English, German, and Arabic in `Localizable.xcstrings`.
- Runtime language model: a persisted in-app language preference injects `Locale` into `LumenNotesApp`; the widget target was not included in that path.
- Overall localization risk: high because an exposed language selector can leave a visible surface in English.

## Evidence Inspected

- `LumenNotes/Resources/Localizable.xcstrings`
- `LumenNotes/App/LumenNotesApp.swift`
- `LumenNotes/Features/Library/LibraryView.swift`
- `LumenNotesWidget/WidgetView.swift`

## Not Inspected And Assumptions

- No build, Simulator language change, screenshot, or device testing was approved.
- Linguistic quality and App Store metadata were not reviewed.

## Locale Coverage Matrix

| Locale | Resource coverage | Runtime switch | Formatters | RTL | Evidence | Confidence |
| --- | --- | --- | --- | --- | --- | --- |
| English | catalog entries present | code path found | one date formatter inspected | n/a | source | medium |
| German | two untranslated catalog entries | code path found | uninspected | n/a | source | medium |
| Arabic | catalog entries present | widget gap found | uninspected | custom canvas uninspected | source | medium |

## User-Visible String Gaps

### High: Widget ignores the selected app language

- Severity: high.
- Evidence: `LumenNotesWidget/WidgetView.swift` creates text with the default bundle and has no shared language or locale input, while `LumenNotesApp.swift` injects the selected locale only into the app scene.
- User impact: a person selecting Arabic can see English widget labels beside Arabic app screens.
- Fix direction: decide whether widgets follow system language or a safely shared app preference; pass the chosen locale and resource lookup through the widget timeline and document the fallback.
- Verification: with approved runtime testing, change language, reload the widget timeline, and check launch, widget, and return-to-app behavior.
- Confidence: medium; source proves different ownership paths, but the widget's observed runtime fallback is untested.
- Missing evidence: target membership, app-group entitlement, and runtime behavior.

### Medium: Count is manually pluralized in English

- Severity: medium.
- Evidence: `LibraryView.swift` renders an English singular branch and `s` suffix based on `notes.count == 1`.
- User impact: languages with other plural categories receive English grammar or cannot translate the count naturally.
- Fix direction: move the count into a String Catalog plural variation with translator context.
- Verification: add catalog variations and exercise zero, one, two, and a locale-specific plural case in a focused test or approved runtime flow.
- Confidence: high from source inspection.
- Missing evidence: catalog extraction and translations after the change.

## Formatting And Pluralization

### Medium: Due date uses a fixed English locale

- Severity: medium.
- Evidence: `LibraryView.swift` configures its due-date `DateFormatter` with `en_US` while the app exposes German and Arabic.
- User impact: a selected language can leave dates in a different language and date order, reducing trust in the language setting.
- Fix direction: use the product's intended locale-aware format style or explicitly pass the selected locale; document calendar and time-zone policy separately.
- Verification: exercise a date whose ordering differs in German and Arabic after approved runtime testing.
- Confidence: high from source inspection.
- Missing evidence: product date-format, calendar, and time-zone requirements.

## Runtime Language Switching

- The app scene has a visible locale injection path; the widget does not. Treat catalog coverage as static evidence only until the approved flow matrix runs.

## RTL, Layout, And Localized Assets

- `CanvasToolbar.swift` was not inspected. No RTL success claim is made for the custom drawing controls.

## Accessibility And System Strings

- `InfoPlist.strings`, permission text, and accessibility labels were not inspected. They remain explicit evidence gaps.

## Recommended Fix Order

1. Make widget language ownership explicit, because it causes cross-surface inconsistency. Verify the app/widget transition in all declared locales.
2. Replace manual English pluralization. Verify locale-specific plural forms.
3. Remove fixed date locale. Verify formatted values against the selected-language policy.

## Verification Matrix

| Locale and flow | Expected behavior | Evidence type | Approval needed |
| --- | --- | --- | --- |
| German Library count | A localized plural form replaces the English suffix | focused test plus running app | build/run approval |
| Arabic widget refresh | Widget follows the documented language policy | running app | build/run approval |
| German due date | Date order and punctuation follow product locale policy | running app | build/run approval |

## Safety And Scope Boundaries

- Privacy and approval: no captures or private data were collected, and runtime verification needs the required build/run approval. Translation writing and linguistic approval require a qualified language reviewer.
