# Capture Consent Protocol

Use this protocol before any Simulator screenshot, Appshot, or Computer Use capture. It applies even when an app is already running.

## Required Confirmation

Ask for and record all of the following before capture:

1. Explicit permission for the capture method: Simulator screenshot, Appshot, or Computer Use.
2. The exact app or Simulator screen and state to capture.
3. Confirmation that no passwords, private chats, personal documents, tokens, API keys, customer data, or unrelated windows are visible.
4. The save location and filename convention for the audit artifacts.
5. Whether the user approves an inventory containing filename, screen, device/orientation, date, and non-sensitive notes.

## During Capture

- Capture only the approved screen and number of images.
- Stop if the visible privacy state changes.
- Do not launch apps, operate other windows, or upload artifacts unless separately approved.

## After Capture

- Create or update the approved inventory.
- Mark the review as screenshot-only when source was not inspected.
- Do not commit captures, inventories containing private data, logs, or generated audit folders.
