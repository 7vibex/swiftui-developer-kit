# Data Flow And Storage Checklist

## Map Each Sensitive Category

For credentials, user content, identifiers, diagnostics, attachments, purchases, or other sensitive data in scope, record:

- Source and consent point.
- In-memory handling and whether it can appear in UI, logs, errors, or analytics.
- At-rest locations: Keychain, `UserDefaults`, files, caches, temporary folders, URL cache, database, app group, iCloud, CloudKit, or third-party SDK storage.
- Transport, recipient, purpose, retention, deletion, export, backup, restore, and user controls.
- Target ownership: app, extension, widget, helper, framework, or package.

## Storage Review

- Keep short secrets and credentials in Keychain rather than `UserDefaults`, plist files, source code, bundled configuration, or logs.
- Check Keychain accessibility, access-control requirements, sharing groups, synchronizable behavior, lifecycle, rotation, and logout or account-switch cleanup where relevant.
- Check file and database locations, protection strategy, backups, cloud sync, temporary copies, previews, exports, and deletion semantics for sensitive content.
- Inspect app groups and shared containers independently; a shared container broadens the set of entitled targets that can read the data.
- Check pasteboard, drag and drop, share sheets, notification previews, widgets, Spotlight, and Quick Look for unintended disclosure of private content.
- Check crash reports, analytics, diagnostics, and `Logger` calls for raw content, identifiers, credentials, request bodies, or response bodies.

## Evidence Boundaries

- Do not open production databases, keychains, private documents, or credential stores to prove a finding.
- Treat encryption, backup, retention, and deletion guarantees as unverified when their implementation or vendor policy is outside the supplied evidence.
- Do not equate a file extension, a database type, or an encrypted transport connection with complete protection at rest.
