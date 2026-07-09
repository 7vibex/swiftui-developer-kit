# SwiftUI Project Route

## Selected Command

`detect-risks`

## Routing Confidence

- Level: high.
- Reason: local SwiftUI source and a request for broad risk triage are present.
- Severity: high if scanner-confirmed destructive persistence or ownership findings are present.
- User impact: unstructured triage can waste evidence budget and delay a safety-critical finding.
- Missing evidence: runtime behavior, screenshots, and release configuration.

## Specialist Sequence

1. Run the read-only structured scanner.
2. Route confirmed ownership findings to `swiftui-architecture-auditor`.
3. Route destructive persistence findings to `swiftdata-persistence-auditor`.

## Evidence Reviewed

Project map and available SwiftUI source.

## Evidence Needed

Relevant tests, persistence models, and any approved runtime evidence for high-risk findings.

## Stop Conditions

Stop before build, launch, capture, signing, or destructive work without explicit approval.

## Evidence Budget

Inspect the project map, scanner findings, and five highest-risk files before expanding scope.

## Explicit Unknowns

Runtime behavior, screenshots, and release configuration are uninspected.

## Next Action

- Handoff prompt: run the read-only scanner and inspect only confirmed high-risk files.
- Verification: scanner output plus focused source evidence.
- Approval required: build/run or capture, if later needed.
