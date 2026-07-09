# SwiftUI Architecture Audit

## Executive Summary

- Overall risk level: high.
- Main architectural theme: one root view owns unrelated navigation, persistence, and async work.
- Recommended first fix: separate route ownership from repository orchestration.
- Evidence gaps: no runtime trace or crash log.

## Critical Issues

None found in the inspected fictional source.

## High Priority Issues

- Issue: root view owns navigation, persistence, and async loading.
- Severity: high.
- Evidence: `FictionalStudyApp/Sources/App/RootView.swift` mutates route state, calls the repository, and starts refresh work.
- Why it matters: failures can diverge and regressions are hard to isolate.
- Fix direction: app coordinator owns routes; `StudyRepository` owns persistence orchestration.
- Boundary affected: navigation and persistence.
- User impact: stale presentation or failed saves.
- Verification: add routing tests and run the approved sample test plan.
- Confidence: high.
- Missing evidence: runtime trace.

## Medium Priority Issues

No additional source-backed findings.

## Ownership Maps

- State ownership: coordinator for route state.
- Navigation ownership: app coordinator.
- Persistence ownership: repository.
- Async boundary: cancellation-aware service/repository boundary.
- Scene/window ownership: not inspected.

## Dead Code / Red Flags

- Item: mixed responsibilities in `RootView`.
- Evidence: view directly starts persistence and refresh work.
- Safe confirmation step: trace call sites before moving code.

## Recommended Fix Order

- Step: isolate route and persistence ownership.
- Why first: protects user-visible transitions and saves.
- Expected blast radius: root coordinator and repository tests.

## Codex Fix Prompts

- Prompt: inspect `RootView` and its repository calls, move only route ownership to a coordinator, preserve public behavior, and add routing tests.
- Files to inspect first: `RootView`, coordinator, repository tests.
