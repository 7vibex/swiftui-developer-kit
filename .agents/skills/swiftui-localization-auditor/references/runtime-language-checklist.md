# Runtime Language Verification Checklist

Use this reference after static inspection to plan runtime proof. Do not run or capture the app without the approvals required by the user and host project.

## Identify The Language Model

- System language only: record the expected OS change and restart or refresh behavior from the project rather than assuming it.
- App-selected language: find the setting owner, persistence key, startup restoration, injected locale or bundle, and reset path.
- Mixed model: identify which surfaces follow system language, app language, server content language, keyboard language, calendar, and time zone.
- Extensions and widgets: verify their bundle and locale behavior independently from the main app.

## Minimum Flow Matrix

For each supported locale, mark code evidence, runtime evidence, or uninspected:

| Flow | What to verify |
| --- | --- |
| Launch and onboarding | Initial language, fallback, permission text, and first-run restoration |
| Navigation | Tabs, sidebars, toolbars, menus, titles, and search prompts |
| Core creation and edit flow | Labels, validation, errors, confirmation, plural counts, and formatted values |
| Settings | Language picker, persistence, reset, and descriptions |
| Secondary surfaces | Sheets, alerts, widgets, notifications, empty states, and accessibility labels |
| Directionality | Right-to-left ordering, clipping, directional symbols, and custom drawing controls |

## Locale Selection

- Use locales the product explicitly supports. Test at least one text-expanding supported locale and one supported right-to-left locale when those risks exist.
- Treat pseudolocalization, if supported by the project, as an expansion diagnostic rather than translation proof.
- Verify plural cases appropriate to each tested locale instead of testing only one and many in English.
- Test formatters with values that expose grouping, decimal separators, date order, time format, currency, and relative date behavior.

## Evidence Rules

- Record the locale identifier, target, flow, state transition, expected behavior, observed behavior, and whether a capture was approved.
- A passing catalog compile or unit test is useful static evidence, not proof that every visible screen changed language.
- If runtime testing is unavailable, state the gap and give a narrow manual flow rather than inferring success.
