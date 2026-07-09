# Xcode Build Debug Report

## Project Detected

- `StudyOS.xcworkspace`
- Scheme candidate: `StudyOS`

## Build Command Used

```bash
xcodebuild -workspace StudyOS.xcworkspace -scheme StudyOS -destination 'platform=iOS Simulator,name=iPad mini (A17 Pro)' build
```

## Error Summary

The build fails in `NotebookSearchView.swift` because `SearchScope.allNotes` no longer exists.

## Root Cause

The enum case was renamed to `all` in the search model, but one view still uses the old case.

## Fix Plan

1. Replace `SearchScope.allNotes` with `SearchScope.all`.
2. Add a small test for default search scope if the project has ViewModel tests.
3. Rebuild the app target.

## Verification Steps

```bash
xcodebuild -workspace StudyOS.xcworkspace -scheme StudyOS -destination 'platform=iOS Simulator,name=iPad mini (A17 Pro)' build
```
