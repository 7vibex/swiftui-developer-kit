# Pull Request Draft

## Branch Name

`feature/redacted-diagnostic-export`

## PR Title

Add redacted diagnostic report export

## Summary

Adds a versioned local report schema and rejects tokens, screenshots, and raw note content by default.

## Changes

- Add a redaction-aware export boundary.
- Validate the report before writing it.

## Testing

- Commands: `./scripts/validate-skills.sh`
- Manual or device proof: none needed; no capture was performed.

## Risks

- Severity: medium.
- Evidence: `schemas/diagnostic-report.schema.json` and the checked validation output.
- User impact: reviewers could approve a privacy regression if planned proof is presented as completed.
- Accessibility impact: report UI labels still need review if a screen is added.
- Release metadata impact: privacy review required before remote upload is ever introduced.
- Apple-source claims: none.

## Screenshots Needed

None for this source/schema change. Any later capture needs explicit approval.

## Reviewer Checklist

- [ ] Confirm redaction defaults fail closed.
- [ ] Confirm no remote upload was added.
- [ ] Confirm validation output passed.

## Verification Boundaries

- Verification: `./scripts/validate-skills.sh` passed in this fictional change.
- Confidence: high for checked-in schema evidence.
- Missing evidence: device proof and screenshots are intentionally not claimed.

## Release Notes

Adds a privacy-safe diagnostic export for troubleshooting.
