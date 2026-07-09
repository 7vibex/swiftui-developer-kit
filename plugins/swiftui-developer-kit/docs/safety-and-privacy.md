# Safety And Privacy

This skill pack must protect user data first.

## Before Screenshots Or Appshots

Ask before capturing. Confirm:

- The intended app or Simulator screen is visible.
- No private chats, personal documents, passwords, API keys, access tokens, customer data, or production secrets are visible.
- The user understands what will be captured and where it will be saved.

## Sensitive Data Rules

- Do not upload API keys.
- Do not include private production data in examples or reports.
- Do not capture password managers, terminal secrets, private messages, documents, or unrelated windows.
- Redact screenshots before sharing them publicly.
- Keep generated audit folders out of git.

## Computer Use

Do not use Computer Use unless the user gives permission for the specific task. If a task can be done with code inspection or a safe script, prefer that first.

## Script Safety

Scripts in this repository are non-destructive by design. They may create folders, list files, detect projects, or capture screenshots after user approval. They must not delete files, reset git state, launch apps, or build projects without explicit approval.
