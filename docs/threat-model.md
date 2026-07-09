# Security Threat Model

This repository is a skill library for Apple app development workflows. The main risk is not server compromise; it is accidental capture, disclosure, or automation beyond the user's intent while an agent is auditing private app projects.

## Assets To Protect

- Private source code, design files, local documents, app data, and production records.
- API keys, tokens, provisioning files, signing identities, bundle IDs, logs, and crash reports.
- Screenshots, Appshots, Simulator output, Computer Use recordings, and generated audit folders.
- User prompts, bug reports, diagnostics exports, and any copied Apple or OpenAI documentation.

## Primary Threats

- Screenshot leakage from private Simulator screens, personal windows, passwords, chats, or documents.
- Prompt injection through repository files that tell an agent to ignore safety rules, upload data, or run destructive commands.
- Scripts modifying user projects, cleaning DerivedData, changing signing, deleting files, or launching apps without approval.
- Build logs or diagnostics exposing tokens, signing details, private bundle IDs, user content, or production records.
- Network exfiltration through generated scripts, copied commands, issue reports, or remote uploads.
- Overclaiming App Store, accessibility, privacy, or Liquid Glass readiness without inspected evidence.
- Copyright leakage from copied Apple documentation instead of short summaries and official links.

## Security Boundaries

- No automatic screenshot capture, Appshots, Simulator capture, or Computer Use.
- No automatic remote upload, telemetry export, diagnostics submission, or issue filing.
- No destructive commands such as reset, forced checkout, broad delete, signing changes, or DerivedData cleanup without explicit approval.
- No private examples; examples must stay fictional and avoid real project names, secrets, logs, screenshots, or generated audit output.
- No broad build/run assumption for external app projects; follow the user's approval and the host repository's instructions.

## Acceptance Criteria

- Scripts are non-destructive, use explicit target paths, and pass `bash -n`.
- Screenshot-capable scripts require an approval flag and user-visible consent language.
- Validation rejects unfinished markers, dangerous script patterns, broad build/run approval conflicts, and broken local links.
- PRs state safety/privacy impact and confirm no private artifacts are committed.
- Findings and release-readiness claims distinguish inspected evidence from missing evidence and manual verification gaps.
