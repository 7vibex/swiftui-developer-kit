# Liquid Glass Placement Rules

## Core Rule

Use Liquid Glass for controls and chrome. Avoid it for primary content. For learning, notes, PDF, tutor, flashcard, and planner apps, treat the rule as chrome-only unless code, screenshots, and product intent prove a narrow exception.

## Surface Classification Rule

Classify the surface before recommending glass:

- **Primary content**: reading, writing, drawing, PDF, transcript, flashcard, form, table, and warning text. Default: avoid.
- **Chrome**: toolbars, tab bars, command bars, filters, sidebars, and compact mode switchers. Default: use when useful.
- **Transient overlay**: popovers, inspectors, search, minimaps, and short-lived palettes. Default: use carefully.
- **Navigation**: sidebars, split-view chrome, page switchers, and document switchers. Default: use system components first.
- **Warning or destructive UI**: alerts, destructive confirmations, error banners, billing/privacy text. Default: avoid.

If a surface mixes content and chrome, split it before adding glass. Do not wrap the whole mixed surface in one translucent container.

## OS Availability Rule

Liquid Glass and iOS 26 UI changes need an explicit older-OS decision before implementation. If the project still supports iOS 17 or similar older targets, ask the user whether to:

- Keep the existing UI path on the app's oldest supported OS and add Liquid Glass only where the new API is available.
- Build a separate non-glass fallback for the oldest supported OS when the new feature needs one.
- Raise the minimum OS and replace the old UI path intentionally.

Do not silently delete the older implementation or assume the fallback is unwanted.

## Decision Matrix

| Surface | Default Decision | Reason |
| --- | --- | --- |
| Primary reading, writing, studying, or answering content | Avoid | Content needs stable contrast and low fatigue |
| Navigation chrome and compact controls | Use | Glass can separate controls without adding heavy panels |
| Transient overlays | Use carefully | Works when brief, small, and legible |
| Canvas, PDF, or document body | Avoid | The work surface needs stable coordinates, contrast, and visual ownership |
| Transcript, flashcard, and long explanation text | Avoid | Text comprehension should not depend on what is behind the surface |
| Dense forms, tables, and long lists | Avoid | Transparency makes scanning harder |
| Destructive or warning actions | Avoid | These need stable, unmistakable emphasis |

## Strong Candidates

- Floating canvas tool palettes
- Compact toolbars above content
- Bottom navigation chrome
- Sidebars
- Inspectors
- Contextual editing menus
- Transient panels
- AI assistant mini panels
- Media or control overlays
- Sheet headers
- Search bars over content
- Document or canvas mode switchers

## Use Carefully

- Clear glass variants, especially around text.
- Planner cards
- Dashboard widgets
- AI tutor panels
- Onboarding cards
- Settings section headers
- Notebook navigation controls

## Avoid

- Main notebook writing pages
- PDF content areas
- Canvas drawing planes
- Flashcard question or answer content
- AI tutor transcripts and generated answer bodies
- Long text explanations
- Forms with many fields
- Primary study content
- Code blocks
- Tables
- Dense lists
- Warning or error messages
- Destructive action areas

## Severity Guidance

- Critical: Glass or blur makes primary content unreadable, hides destructive actions, or breaks accessibility.
- High: Glass competes with dense study content, appears inside scrolling reading content, lacks API availability policy, or fails Reduce Transparency expectations.
- Medium: Placement is plausible but needs hierarchy, contrast, or safe-area tuning.
- Low: Cosmetic mismatch or minor polish issue.

## Fail Signals

- Paragraph text, PDF pages, note bodies, flashcard faces, or transcript rows sit directly on glass.
- `.glassEffect`, `GlassEffectContainer`, or glass button styles appear without an explicit availability and fallback policy.
- Clear glass is used behind text without a legibility treatment.
- Glass appears inside `ScrollView`, `List`, `TextEditor`, or document body containers instead of fixed chrome.
- Reduce Transparency collapses hierarchy or makes controls/content indistinguishable.

## Confidence Guidance

- High: Screenshot and SwiftUI code both support the recommendation.
- Medium: Screenshot or code alone strongly indicates the issue.
- Low: Code-only inference about visual placement, or screenshot-only inference about implementation.
