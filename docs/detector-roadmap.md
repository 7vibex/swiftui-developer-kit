# SwiftUI Detector And Structured Scanner

`scripts/detect-swiftui-antipatterns.sh` remains the dependency-light shell fallback. `scripts/run-structured-scanner.sh` uses SwiftSyntax 603.x for syntax-scoped rules, stable JSON fingerprints, inline suppressions, baselines, and CI severity exits.

## Structured Scanner

```bash
scripts/run-structured-scanner.sh --format json scanner/Fixtures
scripts/run-structured-scanner.sh --baseline scanner/Fixtures/baseline.json scanner/Fixtures
scripts/run-structured-scanner.sh --write-baseline /path/to/baseline.json scanner/Fixtures
scripts/run-structured-scanner.sh --ci scanner/Fixtures
```

Inline suppression:

```swift
// swiftui-kit:disable fixed-frame-dynamic-type-risk
.frame(width: 80)
```

Use suppression only after documenting why the flagged behavior is safe. Baselines contain stable fingerprints and should be reviewed like source changes.

## Current Rules

- Large SwiftUI view files.
- Symbol-only image buttons without nearby accessibility labels.
- Unstructured `Task {}` launched from `.onAppear`.
- Hardcoded foreground, style, or background colors.
- SwiftData delete paths without nearby confirmation, alert, undo, or recovery signals.
- Liquid Glass usage without an availability policy in the same file.
- Liquid Glass near scrolling, document, PDF, flashcard, transcript, or long-form content surfaces.
- Clear glass without obvious legibility or Reduce Transparency treatment.
- Deprecated `PKToolPicker.shared(for:)` usage.
- `PKCanvasView` without a drawing-change hook in the same file.
- PDF overlay providers without an obvious annotation, export, save, or reopen path.
- Heavy SwiftUI files that use `@Query`.
- Logger usage near sensitive fields without obvious privacy handling.
- multiple booleans controlling SwiftUI sheets.

## Remaining Candidate Rules

Add these only when the scanner can keep false positives low:

- Duplicate `.sheet(isPresented:)` modifiers in one view.
- `.onChange` blocks that start heavy work without debouncing or cancellation.
- Huge `body` builders even when the surrounding file is not large.
- Unstable identity such as `.id(UUID())`.
- Full-table SwiftData fetches or queries without predicates in obviously large collections.
- iPad-oriented apps with no likely `NavigationSplitView`, sidebar, or split navigation path.
- Hardcoded frame sizes that are likely to break Dynamic Type.
- Toolbars implemented as ad hoc `HStack` controls where `.toolbar` would fit better.
- Menu or command groups that appear and disappear based on minor view state.
- Missing descriptive window titles in document or multiwindow flows.
- Direct MetricKit manager use in feature code without a diagnostics abstraction.

## Rule Quality Bar

Each new rule should include:

- A stable rule name.
- Severity.
- A low-noise grep or parser signal.
- One synthetic positive fixture in `tests/run-tests.sh`.
- A recommendation that points to the right skill or reference.
- A short explanation when the rule is intentionally heuristic.
