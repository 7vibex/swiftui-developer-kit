# Security Policy

This repository is a workflow and skill library. It may guide agents that inspect local SwiftUI projects, run safe scripts, or capture screenshots only after explicit user approval.

## Reporting Security Issues

Report vulnerabilities through the GitHub repository's security advisory flow when available, or open a minimal issue that does not include secrets, private source, screenshots, tokens, passwords, personal data, or production details.

## Sensitive Data Rules

- Do not include API keys, tokens, passwords, signing assets, private project files, personal documents, private chats, or production data in issues, examples, prompts, or audit artifacts.
- Do not upload screenshots that show private notes, documents, chats, credentials, account identifiers, unreleased product data, or customer data.
- Redact local paths, bundle identifiers, and project names when they could identify private work.

## Screenshot And App Capture

Do not capture screenshots, Appshots, Simulator output, or private windows without explicit user approval and a privacy check. Users should bring only the intended app or Simulator screen forward and confirm that no sensitive information is visible.

Generated audit folders, screenshots, logs, build output, and local captures should not be committed.

## Script Safety

Scripts in this repository should remain non-destructive. They may inspect, list, validate, create local audit folders, generate provider bundles, or capture screenshots only behind approval flags. They must not delete source, reset git state, alter signing, clean DerivedData, or launch private apps without approval.

Run validation before publishing changes:

```bash
./scripts/validate-skills.sh
```
