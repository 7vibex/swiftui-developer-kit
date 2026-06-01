---
name: xcode-build-debugger
description: Diagnose Xcode, SwiftUI, iOS, iPadOS, macOS, scheme, simulator, signing, dependency, and build errors using safe project detection and user-approved build/debug workflows.
---

# Xcode Build Debugger

Diagnose Xcode build issues with safe detection first. Do not build when the command would be long-running, destructive, or ambiguous without user approval.

## References

- `references/xcode-build-checklist.md`
- `references/scheme-detection-notes.md`
- `references/output-contract.md`

## Workflow

1. Detect `.xcodeproj`, `.xcworkspace`, and `Package.swift`.
2. List schemes when safe.
3. Ask for scheme, device, or platform if ambiguous.
4. Run the approved build or test command.
5. Parse errors by root cause, not only by last line.
6. Propose a scoped fix plan.
7. Verify with the smallest command that proves the fix.

## Guardrails

- Do not clean DerivedData unless the user approves.
- Do not change signing settings without explaining the risk.
- Do not build or launch the app when the user requested code-only diagnosis.

## Output

Use `references/output-contract.md`.
