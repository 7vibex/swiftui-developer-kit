# Fictional SwiftUI Localization Audit: LumenNotes

## Executive Summary

- Audit scope: iOS app source, String Catalog, widget target source, and unit tests. No build, device, capture, or live content inspection was approved.
- Supported locales discovered: English (`en`), German (`de`), and Arabic (`ar`).
- Runtime language model: `AppLanguageStore` persists a language identifier and applies `.environment(\\.locale, Locale(identifier: selectedLanguage))` at the app scene. The product intent for widgets and notifications is undocumented.
- Overall localization risk: high. The main scene has a locale injection path, but extension and formatter behavior is incomplete or unverified.

## Evidence Inspected

- `FictionalLumenNotes/Resources/Localizable.xcstrings`
- `FictionalLumenNotes/App/AppLanguageStore.swift`
- `FictionalLumenNotes/App/LumenNotesApp.swift`
- `FictionalLumenNotes/Features/Library/LibraryView.swift`
- `FictionalLumenNotes/Features/Canvas/CanvasToolbar.swift`
- `FictionalLumenNotesWidget/WidgetView.swift`
- `FictionalLumenNotesTests/LibraryViewModelTests.swift`

## Not Inspected And Assumptions

- `InfoPlist.strings`, notification-service extension, and App Store Connect metadata were not supplied.
- The test suite was not run; test names are source evidence only.
- No native-language review occurred, so the audit does not approve translation quality.

## Locale Coverage Matrix

| Locale | Resource coverage | Runtime switch | Formatters | RTL | Evidence | Confidence |
| --- | --- | --- | --- | --- | --- | --- |
| English | source language populated | app-scene path found | date uses fixed locale | n/a | catalog and code | high |
| German | 2 new keys remain untranslated | app-scene path found | uninspected | n/a | catalog and code | medium |
| Arabic | all catalog values present | app-scene path found; widget unowned | uninspected | custom toolbar has hard-coded x positions | catalog and code | medium |

## User-Visible String Gaps

### High: Widget language policy is absent

- Flow or key: Home Screen widget title and empty-state label.
- Severity: high.
- Evidence: `WidgetView.swift` creates localized labels from its own extension target without receiving `AppLanguageStore` state or a documented shared preference.
- User impact: an Arabic app can coexist with an English widget, making language selection appear broken.
- Fix direction: choose and document a widget policy. If it follows system language, remove any expectation that it honors the app setting. If it follows the app setting, use an approved shared container, refresh the timeline after language changes, and use the widget target bundle deliberately.
- Verification: after approved runtime setup, test system-English/app-Arabic and system-Arabic/app-German combinations, then reload the timeline and relaunch the app.
- Confidence: medium.
- Missing evidence: app-group entitlement, expected product behavior, and observed runtime output.

### Medium: English-only plural branching bypasses the String Catalog

- Flow or key: Library count.
- Severity: medium.
- Evidence: `LibraryView.swift` concatenates an English singular and `s` suffix based on `notes.count == 1`.
- User impact: German and Arabic cannot use their own plural grammar, and a zero count may read unnaturally.
- Fix direction: make the count a localized String Catalog key with plural variants and an explanatory comment.
- Verification: test zero, one, two, and a locale-specific plural category through the view model and an approved visible Library flow.
- Confidence: high.
- Missing evidence: intended wording and translated plural entries.

### Medium: Due-date formatter ignores the selected language

- Flow or key: Notebook due-date row.
- Severity: medium.
- Evidence: `LibraryView.swift` sets `DateFormatter.locale = Locale(identifier: "en_US")` while `LumenNotesApp.swift` injects the selected locale into SwiftUI.
- User impact: users can select German or Arabic and still receive an American English date layout.
- Fix direction: use a locale-aware `FormatStyle` or pass the product's intended locale into the formatter. Keep language, calendar, and time-zone policy explicit.
- Verification: test a date that distinguishes day/month order and a value that shows locale-specific numerals if the product supports them.
- Confidence: high.
- Missing evidence: product requirements for calendar and time-zone choice.

## Formatting And Pluralization

- Currency and measurement formatters were not found in the inspected Library flow.
- Relative dates and search result counts were not inspected; they remain evidence gaps rather than passing areas.

## Runtime Language Switching

- `AppLanguageStore` restores a selected language at launch and the root app scene injects it into SwiftUI. That is code evidence, not a guarantee that all formatters, UIKit bridges, widgets, or alerts follow it.
- The language-setting screen should disclose whether the choice affects the app only, widgets, notifications, or system permission text.

## RTL, Layout, And Localized Assets

- `CanvasToolbar.swift` positions two drawing controls using literal x offsets. Severity: medium. The custom geometry may remain left-to-right in Arabic. Verify leading/trailing ordering, undo/redo direction, and hit targets in an approved Arabic runtime flow.
- `Assets.xcassets` was not supplied. Localized images and symbols are uninspected.

## Accessibility And System Strings

- Accessibility labels on `CanvasToolbar` and `InfoPlist.strings` were not inspected. They must be reviewed before claiming Arabic or German coverage is complete.

## Recommended Fix Order

1. Decide and implement widget language ownership; it is the broadest visible inconsistency.
2. Replace the hard-coded plural path and fixed date locale.
3. Audit custom RTL geometry and system-facing strings.
4. Run the approved locale-by-flow matrix and seek qualified translation review.

## Verification Matrix

| Locale and flow | Expected behavior | Evidence type | Approval needed |
| --- | --- | --- | --- |
| German Library counts | Correct plural and no English suffix | focused test plus running app | build/run approval |
| Arabic Canvas toolbar | Directional order, labels, and hit targets remain usable | running app | build/run approval; capture only if separately approved |
| App language then widget refresh | Policy is consistent across app and widget | running app | build/run approval |
| Permission prompt | Declared system text matches supported language | running app | build/run approval; do not capture private screens |

## Safety And Scope Boundaries

- No screenshots, Appshots, Simulator captures, private notes, user messages, tokens, or production data were collected.
- This report does not certify translations, server-provided content, App Store metadata, or uninspected extension behavior.
