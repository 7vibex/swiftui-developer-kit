# Reopen, Delete, And Save Contract

Use this reference when auditing destructive flows, document-like apps, canvas data, imported files, or any feature where silent data loss is plausible.

## Delete Contract

For user-created data, a safe delete flow has:

- User-visible confirmation when the action is destructive or hard to recover from.
- Clear object scope: model id, relationship cascade, attachments, and derived caches.
- Explicit `ModelContext.delete(_:)` or batch delete site.
- Save or transaction boundary that makes the commit point obvious.
- Undo, restore, soft-delete, trash, or recovery explanation where reasonable.
- Error handling if save fails.
- Test or manual flow for delete → close → reopen.

Flag high risk when delete mutates the context directly from a button without confirmation, recovery, or save-error handling.

## Save Boundary Contract

Autosave helps, but it is not a correctness plan for important edits. Require an explicit save, transaction, or durable write boundary when:

- A destructive action completes.
- A document, notebook, page, or canvas edit must survive backgrounding or force quit.
- Imported files, images, PDFs, or attachments become part of user data.
- A multi-model change must succeed or fail together.
- A migration, duplicate, merge, or sync operation rewrites user-visible data.

## Reopen Contract

For each high-value object, require a reopen test:

- Create or edit.
- Save or wait for the documented commit point.
- Close the screen or background the app.
- Relaunch or reopen the object.
- Verify identity, relationships, attachments, ordering, and derived caches.

For canvas and document apps, include page order, zoom-relevant state when promised, PDF annotation alignment, thumbnails, and layer ownership.

## Migration Contract

- Version schema when model shape changes can affect existing stores.
- Add migration stages for renamed, removed, newly required, relationship-changing, or type-changing properties.
- Keep fixture stores for at least the most recent shipped schema.
- Test migration success, failure handling, and user-visible data meaning.
- Mark future SwiftData APIs as future-looking until the app targets the matching SDK and OS family.
