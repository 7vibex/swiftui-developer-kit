# xcode-build-debugger Good Output

This fictional example demonstrates the expected evidence standard.

## Root cause: test target imports a product it does not link
- Evidence: the build log reports `No such module 'FictionalStudyApp'` for `FictionalStudyAppTests`; project settings show the test target lacks the app dependency.
- Confidence: high from the exact compiler diagnostic and target graph.
- User impact: CI and local tests cannot compile.
- Fix: add the app target dependency and host application setting; do not change signing.
- Missing evidence: archive and device builds were not run.
- Verification: rerun the failing `xcodebuild test` command on the approved simulator destination.
- Safety: no DerivedData cleanup, launch, screenshot, or signing change is required.
