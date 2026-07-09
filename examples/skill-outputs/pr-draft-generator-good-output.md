# pr-draft-generator Good Output

This fictional example demonstrates the expected evidence standard.

## PR Title
`Add redacted diagnostic report export`

## Summary
Adds a versioned local report schema and rejects tokens, screenshots, and raw note content by default.

## Testing
- Command: `./scripts/validate-skills.sh`
- Result: passed.

## Risks And Evidence
- Privacy impact: report fixture validates `contains_user_content`, `contains_tokens`, and `contains_screenshots` as false.
- Not inspected: remote upload because it is outside this change.
- Screenshots: not needed and not captured.
