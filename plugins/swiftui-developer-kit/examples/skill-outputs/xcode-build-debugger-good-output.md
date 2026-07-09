# Xcode Build Debug Report

## Project Detected

`FictionalStudyApp.xcworkspace` with `FictionalStudyAppTests`.

## Build Command Used

The reported failing `xcodebuild test` command was inspected; it was not rerun without approval.

## Error Summary

`FictionalStudyAppTests` reports `No such module 'FictionalStudyApp'`.

- Severity: high.
- Evidence: exact compiler diagnostic and fictional target graph.

## Root Cause

The test target imports the app product but does not link the app target or host application.

## Fix Plan

Add the app target dependency and host application setting. Do not change signing or clean DerivedData.

## Verification Steps

- Re-run the exact failing test command on the approved simulator destination.
- Confirm the module loads and focused tests start.
- Confidence: high from compiler diagnostic and target graph.
- User impact: CI and local tests cannot compile.
- Missing evidence: archive and device builds.
- Safety: no launch, screenshot, capture, signing change, or cleanup is required.
