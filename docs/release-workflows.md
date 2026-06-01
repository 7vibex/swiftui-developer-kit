# Release Workflows

Use release workflows before TestFlight or App Store submission.

## TestFlight Readiness

Check:

- Bundle identifier is correct.
- Version and build numbers are incremented.
- App icon and launch screen are present.
- Required permission strings are present.
- Debug flags and development endpoints are disabled.
- Build can archive.
- Beta app description and tester notes are drafted.

## App Store Readiness

Check:

- App metadata is complete.
- Screenshots match current UI and supported devices.
- Privacy labels match actual data collection.
- Privacy manifest is present when needed.
- App Review notes explain required accounts, hardware, or demo data.
- Release notes are clear and user-facing.

## Final Checklist

- [ ] Archive build reviewed.
- [ ] TestFlight smoke test completed.
- [ ] Permission prompts tested.
- [ ] Accessibility basics checked.
- [ ] Crash-prone startup flows tested.
- [ ] Metadata and screenshots match the submitted build.
- [ ] App Store Review Guidelines risks documented.
