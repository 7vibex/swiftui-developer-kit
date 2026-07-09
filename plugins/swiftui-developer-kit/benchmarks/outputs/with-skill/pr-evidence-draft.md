# Skill-Guided Fixture: pr-evidence-draft

- Severity: Medium
- Evidence: `.github/pull_request_template.md` - The PR draft must distinguish executed validation from screenshots or device proof that still need approval.
- User impact: Reviewers cannot assess release risk if planned proof is presented as completed.
- Fix: List only commands actually run and mark screenshots/device proof as pending approval.
- Verification: Compare the final PR draft with the checked validation output.
- Confidence: high for the evidence boundary.
- Missing evidence: No device proof or screenshot exists for this fixture.
- Safety: Do not capture a screenshot or operate an app to fill a PR template.
