# Detect Risks Example

Fictional worked output for a code-only scan of a SwiftUI study planner app.

## Prompt

```text
Use the swiftui-project-router skill. detect-risks in this SwiftUI project.
```

## Local Command

```bash
scripts/swiftui-kit.sh detect --format markdown StudyOS/Sources
```

## Scenario

The project has a `StudyPlanDashboard.swift` screen that grew from a simple session list into a dashboard with sync, destructive actions, and toolbar controls. Before asking for a deeper audit, the deterministic scanner is run to find concrete source risks.

## Worked Scanner Output

```markdown
# SwiftUI Anti-Pattern Scan

- **large-swiftui-file** `StudyOS/Sources/StudyPlanDashboard.swift:1` [medium]: SwiftUI view file has 148 lines. Split rendering, state, and helper views before adding more behavior.
- **image-button-missing-accessibility-label** `StudyOS/Sources/StudyPlanDashboard.swift:42` [high]: A button appears to rely on an SF Symbol without an accessibility label. Add a clear .accessibilityLabel or use a Label with visible text.
- **unstructured-task-in-view-lifecycle** `StudyOS/Sources/StudyPlanDashboard.swift:67` [medium]: View lifecycle starts an unstructured Task. Prefer .task(id:), cancellation-aware view models, or explicit task storage.
- **hardcoded-foreground-color** `StudyOS/Sources/StudyPlanDashboard.swift:88` [low]: View uses a hardcoded semantic-hostile color. Use asset colors, semantic roles, or environment-aware styles.
- **swiftdata-delete-without-recovery-signal** `StudyOS/Sources/StudyPlanDashboard.swift:112` [high]: SwiftData delete path has no nearby confirmation or recovery signal. Verify destructive actions have confirmation, undo, or a clear recovery path.

Findings: 5
```

## Routed Review Summary

Selected workflow: `swiftui-architecture-auditor`, with targeted follow-up from `accessibility-auditor` and `swiftdata-persistence-auditor` if the high-severity findings are confirmed in source.

High-priority risks:

- Add an accessibility label or visible `Label` for the symbol-only dashboard action.
- Add confirmation, undo, or another recovery path before deleting persisted study sessions.

Medium-priority risks:

- Split `StudyPlanDashboard` into smaller rendering components before adding more dashboard behavior.
- Replace the `.onAppear { Task { ... } }` sync path with `.task(id:)` or a cancellation-aware model.

Low-priority risk:

- Replace hardcoded color usage with semantic styling or asset colors that adapt across appearance and accessibility settings.

## Follow-Up Fix Prompt

```text
Use the swiftui-feature-builder skill. Fix the detect-risks findings in StudyPlanDashboard.swift. Preserve behavior, add accessible labels, make delete recovery explicit, replace lifecycle-created Task usage, and keep refactors local to the dashboard flow.
```
