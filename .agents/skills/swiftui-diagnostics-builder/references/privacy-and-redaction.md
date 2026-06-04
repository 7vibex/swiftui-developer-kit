# Privacy And Redaction

Diagnostics are useful only if users can trust them.

## Defaults

- Store diagnostics locally unless the user explicitly asks for remote upload.
- Export on demand.
- Ask before screenshots, Appshots, Simulator capture, or Computer Use.
- Treat screenshot capture as sensitive even in internal tools.
- Keep retention short and documented.

## Never Include By Default

- Passwords, tokens, API keys, secrets, cookies, or auth headers.
- Full note text, handwriting, chat transcripts, prompts, private documents, email, or personal files.
- Production user identifiers unless replaced with local redacted IDs.
- Raw network payloads or full AI prompts/responses.
- Private screenshots without explicit consent.

## Prefer

- Screen names.
- Feature names.
- Enum values.
- Counts.
- Boolean state.
- Error domains and codes.
- Redacted IDs.
- Coarse timestamps.
- App version, build number, device, OS, and configuration.

## Consent And Review

Before adding remote upload, analytics, crash SDKs, or session-style replay:

- Document what data leaves the device.
- Update privacy labels and the privacy manifest when required.
- Add a release-review note for TestFlight and App Store readiness.
- Provide an off switch for internal or user-facing diagnostics where appropriate.

## Report Export Review

Before treating the diagnostics feature as done, inspect an exported report. Confirm it explains the bug context and excludes private content unless the user chose to include it.
