# Screenshot Workflow

1. Follow `../../../docs/capture-consent-protocol.md`: confirm method, explicit permission, target screen, privacy state, save location, and inventory consent.
2. Create an audit folder if needed.
4. Capture with Appshots or `xcrun simctl io booted screenshot`.
5. Name files in review order: `01-home.png`, `02-canvas.png`.
6. Create a screenshot inventory.
7. Review screenshots against the UI checklist.

The fallback script does not launch apps and does not delete files.
