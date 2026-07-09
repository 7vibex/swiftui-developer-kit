# Localization Audit Checklist

## Scope And Resources

- Identify every app, extension, widget, watch, and package target that renders user-visible text.
- Record the development region, declared localizations, bundle ownership, and whether resources are included in each target.
- Inspect `Localizable.xcstrings`, additional `.xcstrings`, `.strings`, `.stringsdict`, `InfoPlist.strings`, localized storyboards or XIBs, and localized asset catalogs where present.
- Check that user-visible permission text, notification categories, widget labels, Siri or intent text, shortcut phrases, and error copy have an owned localization path when the product exposes them.
- Treat App Store Connect copy and screenshots as release-review scope; note their relationship but do not claim they were inspected without evidence.

## Code Paths

- Trace `Text`, `Label`, button titles, menu commands, alerts, sheets, accessibility labels and hints, error messages, empty states, and generated strings.
- Inspect `String(localized:)`, `LocalizedStringResource`, `LocalizedStringKey`, `NSLocalizedString`, explicit table or bundle parameters, and custom resource wrappers.
- Check package and framework strings use the intended bundle instead of accidentally falling back to the app bundle.
- Flag raw values, enum descriptions, `String(describing:)`, debug messages, and server error text only when they can reach the UI.
- Do not flag user-entered text, opaque identifiers, source code labels, analytics event names, or intentional `Text(verbatim:)` without user-visible evidence.

## Translation And Variants

- Compare declared locales with catalog language coverage, translation state, missing keys, and source-language fallback behavior.
- Review interpolation arguments and format specifiers for translator context and matching types.
- Check pluralized concepts use catalog or strings-dictionary plural variations rather than English-only singular/plural branching.
- Review device- or platform-specific wording when the interaction differs, such as tap, click, or press.
- Include translator comments when a short or ambiguous key needs UI context.

## Formatting And Cultural Behavior

- Trace dates, times, time zones, numbers, percentages, measurements, currencies, lists, names, and relative dates to locale-aware APIs or documented product rules.
- Check custom app-language selection reaches formatters as well as `Text` views; `Locale.current` alone may not follow an in-app setting.
- Check calendar and time-zone choices separately from language. A language selection does not automatically define a calendar, numbering system, or time zone.
- Flag hand-built formatting, fixed English punctuation, and locale-insensitive `String(format:)` only when an equivalent user-visible formatter is needed.

## Direction And Assets

- Test or map `layoutDirection`, leading and trailing placement, navigation affordances, disclosure indicators, swipe actions, drawing tools, and directional SF Symbols for right-to-left locales.
- Inspect custom Canvas, UIKit bridges, geometry, and image transforms for hard-coded left/right assumptions.
- Check locale-specific images, symbols, audio, and other assets where the product presents language-dependent content.
- Treat text expansion and truncation as localization risks even for left-to-right languages.
