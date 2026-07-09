# Skill Quality Standard

Every skill in this pack must meet the same minimum contract.

## Trigger And Scope

- Frontmatter contains only `name` and `description`.
- The description front-loads concrete trigger terms and stays within 240 characters.
- `Do Not Use When` defines the boundary.
- `Done When` defines observable completion.

## Evidence And Output

- Each finding includes severity, evidence, user impact, a concrete fix or next action, verification, confidence, and missing evidence.
- A routing, planning, or PR decision without a defect uses explicit scope, risk or status, evidence, next action, verification, confidence, and missing evidence instead of inventing severity.
- Findings cite files, symbols, screenshots, logs, tests, commands, or an explicit evidence gap.
- Severity and confidence are separated from taste or preference.
- The output contract requires verification and names unknown or uninspected evidence.
- Good and bad examples exist for the skill.

## Safety

- Build, launch, capture, network, signing, cleanup, and destructive actions follow repository and host-project approval rules.
- Screenshots, Appshots, Simulator capture, and Computer Use always require explicit approval.
- Outputs do not expose secrets, private source, raw user content, tokens, or production data.
- Skills recommend explicit handoffs instead of claiming automatic invocation of another skill.

## Validation

`scripts/lint-skills.sh` enforces the structural parts of this standard. Behavioral benchmarks test whether representative outputs follow it.
