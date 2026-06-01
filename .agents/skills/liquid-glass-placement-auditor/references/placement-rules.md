# Liquid Glass Placement Rules

## Core Rule

Use Liquid Glass for controls and chrome. Avoid it for primary content.

## Decision Matrix

| Surface | Default Decision | Reason |
| --- | --- | --- |
| Primary reading, writing, studying, or answering content | Avoid | Content needs stable contrast and low fatigue |
| Navigation chrome and compact controls | Use | Glass can separate controls without adding heavy panels |
| Transient overlays | Use carefully | Works when brief, small, and legible |
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

- Planner cards
- Dashboard widgets
- AI tutor panels
- Onboarding cards
- Settings section headers
- Notebook navigation controls

## Avoid

- Main notebook writing pages
- PDF content areas
- Flashcard question or answer content
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
- High: Glass competes with dense study content or fails Reduce Transparency expectations.
- Medium: Placement is plausible but needs hierarchy, contrast, or safe-area tuning.
- Low: Cosmetic mismatch or minor polish issue.

## Confidence Guidance

- High: Screenshot and SwiftUI code both support the recommendation.
- Medium: Screenshot or code alone strongly indicates the issue.
- Low: Code-only inference about visual placement, or screenshot-only inference about implementation.
