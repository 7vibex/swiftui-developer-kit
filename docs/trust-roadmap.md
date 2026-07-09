# Trust Roadmap

Last updated: 2026-07-09

The release sequence prioritizes public proof, measurement, structured analysis, and distribution. Each release is complete only when its acceptance criteria pass.

## v0.3.0 - Proof Release

Required: public synthetic audit fixtures, paired skill outputs, README proof section, issue and PR templates, link checking, and instruction conflict checking.

Acceptance: `./scripts/validate-skills.sh` passes; benchmark outputs cite public fixtures; no private artifacts or captures are required.

## v0.4.0 - Measurement Release

Required: at least eight benchmark tasks, scoring rubrics, behavior validation, expected findings, and with-skill versus baseline fixtures.

Acceptance: the validator rejects hallucinated file paths, missing evidence, missing verification, unsafe capture claims, and unbounded findings.

## v0.5.0 - Scanner Release

Required: SwiftSyntax scanner, versioned JSON schema, baseline and suppression support, CI mode, and positive/negative fixtures.

Acceptance: the shell scanner remains available; the structured scanner covers at least ten rules; suppressions and baselines are tested; false-positive boundaries are documented.

## v0.6.0 - Distribution Release

Required: current Codex plugin package, repo marketplace, compatibility matrix, provider bundle docs, install troubleshooting, and changelog.

Acceptance: local skills, Codex plugin, and non-Codex provider bundle paths are clearly distinct and validated.

## v1.0.0 - Trust Release

Required: published fixture results, stable output examples, threat model, triaged issue backlog, strict output contracts, boundaries, and paired output examples for every skill.

Acceptance: a new user can install the pack, inspect examples and limitations, and reproduce validation in under ten minutes.
