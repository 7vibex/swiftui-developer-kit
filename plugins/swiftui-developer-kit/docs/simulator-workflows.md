# Simulator Workflows

Simulator screenshots are useful when layout, visual hierarchy, clipping, Liquid Glass placement, Dynamic Type, or readability needs visual evidence.

## Consent First

Follow the shared [capture consent protocol](capture-consent-protocol.md): explicit method permission, exact screen, privacy state, save location, and inventory consent.

## Capture Fallback

When the user approves capture and a booted Simulator exists, the fallback command is:

```bash
xcrun simctl io booted screenshot <output-path>
```

The scripts in this repository do not launch apps and do not delete screenshots.

## Naming

Use stable names:

```text
01-home.png
02-canvas.png
03-notebook.png
04-ai-tutor.png
05-flashcards.png
06-planner.png
07-settings.png
```

## Screenshot Inventory

Create a Markdown inventory that records:

- File name
- Screen name
- Device and orientation if known
- Capture date
- Notes

The inventory should live beside the screenshots in the generated audit folder and should not be committed if it contains private app data.
