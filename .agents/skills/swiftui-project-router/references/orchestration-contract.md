# Router Orchestration Contract

Use this contract after selecting the narrowest matching command.

## Routing Confidence

- High: the request names a command, specialist domain, or direct artifact.
- Medium: the request spans domains but the first dependency is clear.
- Low: the project type, artifact, or desired outcome is missing.

## Specialist Sequence

List specialists in dependency order. Recommend explicit handoff prompts; do not claim automatic invocation.

1. Start with blockers such as build or project detection.
2. Inspect correctness domains such as architecture and persistence.
3. Inspect user-facing domains such as accessibility and design.
4. Finish with tests, release readiness, or PR drafting.

## Stop Conditions

- Stop when required source, project metadata, or user-provided evidence is unavailable.
- Stop before build or launch when approval is missing.
- Stop before screenshots, Appshots, Simulator capture, or Computer Use until explicit approval is given.
- Stop screenshot review when private data may be visible.
- Stop downstream visual or release conclusions when a blocking build failure invalidates them.

## Evidence Budget

1. Inspect the project map and repository instructions.
2. Read the smallest set of high-risk files that can confirm or reject the route.
3. Run deterministic scanners when local files are available.
4. Expand only when the first evidence pass leaves a material unknown.
5. State what was not inspected.
