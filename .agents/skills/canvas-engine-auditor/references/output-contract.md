# Canvas Engine Auditor Output Contract

## Required Output
1. **Canvas Architecture Map**
   - Rendering engine(s).
   - Input path.
   - Coordinate spaces.
   - State owners.
   - Persistence path.

2. **Findings Table**
   - Severity: Critical, High, Medium, Low.
   - Area: rendering, gesture, coordinate, tool, persistence, performance, accessibility, test.
   - Evidence: file path, symbol, test, screenshot, or reproducible step.
   - Impact: what breaks for the user.
   - Fix: concrete change.
   - Verification: command/test/manual flow.

3. **Fix Order**
   - First: data loss, restore, crashes, broken drawing.
   - Second: coordinate/gesture correctness.
   - Third: tool behavior and undo/redo.
   - Fourth: performance.
   - Fifth: visual polish and Liquid Glass placement.

4. **Regression Tests To Add**
   - Test file names.
   - Test case names.
   - What bug each test prevents.

5. **Codex Fix Prompts**
   - Separate prompts for safe, small patches.
   - Each prompt must include scope, files to inspect, constraints, tests, and verification.

## Severity Standards
- **Critical**: likely data loss, drawing disappears, broken save/restore, crashes, or unopenable documents.
- **High**: common canvas actions produce wrong coordinates, wrong layers, broken tool state, or blocked drawing/pan/zoom.
- **Medium**: performance, maintainability, missing regression tests, or bugs requiring less common flows.
- **Low**: cleanup, naming, visual polish, or optional enhancements.

## Pass / Fail Criteria
- Pass only when core draw, erase, select, pan, zoom, undo/redo, save, reopen, and page/layer switch flows are verified.
- Fail if the audit cannot identify a single source of truth for canvas state.
- Fail if persistence behavior is untested for at least one draw → close → reopen flow.
- Fail if a proposed fix lacks a verification step.
