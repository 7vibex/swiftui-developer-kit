# App Store Release Review

## Executive Summary

StudyOS is close to TestFlight-ready but not App Store-ready. Privacy manifest and screenshot metadata need review before submission.

## Blockers

- Missing camera permission explanation for document scan import.
- Privacy manifest does not mention analytics SDK usage.

## High Priority Issues

- Build number was not incremented after the previous TestFlight upload.
- Debug tutor endpoint is still visible in settings.

## Privacy and Permissions

- Confirm document scanning does not upload images unless the user opts in.
- Update privacy labels for diagnostics and analytics.

## Metadata and Screenshots

- iPad screenshots still show the old notebook toolbar.
- App subtitle should mention study planning, not only notes.

## TestFlight Checklist

- Add beta notes for Canvas pencil tools.
- Invite internal testers before external review.

## App Store Checklist

- Verify support URL and privacy policy URL.
- Add App Review notes for demo content.

## Release Notes Draft

StudyOS now includes a redesigned Canvas toolbar, faster notebook search, and improved flashcard review controls.

## Final Go/No-Go

No-go for App Store. Go for internal TestFlight after permission strings, endpoint cleanup, and build number are fixed.
