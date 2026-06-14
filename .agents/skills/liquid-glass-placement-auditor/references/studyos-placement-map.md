# StudyOS Liquid Glass Placement Map

Use this reference for StudyOS-style learning, note-taking, flashcard, planner, PDF, and AI tutor apps. Treat names as fictional examples and adapt them to the project being reviewed.

## Use

- Canvas floating tool palette for pen, highlighter, eraser, color, width, undo, and lasso controls.
- Compact notebook mode switcher for write, read, review, and organize modes.
- Page switcher, page thumbnails chrome, and page navigation controls outside the page content.
- Search overlay and filter chips when they float above content briefly.
- Sidebar or binder navigation chrome.
- Inspector popovers for tool settings, object properties, or export controls.
- AI tutor compact panel header, grab handle, close button, and action strip.
- Sheet headers and compact command bars.

## Use Carefully

- Dashboard widgets that mix status and study content.
- Planner cards with dense dates, tasks, and deadlines.
- AI tutor panels that include generated answers or citations.
- Onboarding cards and empty states.
- Settings section headers.
- Export and share controls.

## Avoid

- Actual notebook paper.
- Handwriting strokes, typed notes, highlights, and annotation content.
- PDF pages and scanned document content.
- Flashcard question and answer text.
- AI tutor long explanations, citations, and source quotes.
- Tables, dense lists, and planner timelines.
- Error banners, warnings, and destructive confirmation areas.
- Privacy, account, permission, or billing text.

## Screen Map

| Screen | Recommended Glass Surface | Keep Opaque |
| --- | --- | --- |
| Canvas | Floating tool palette, color popover, compact page controls | Paper, ink, PDF page, selection handles that need contrast |
| Notebook | Mode switcher, search field, sidebar chrome | Note body, headings, code blocks, tables |
| Flashcards | Navigation controls and progress chrome | Prompt, answer, explanation, grading feedback |
| AI Tutor | Header chrome and action strip | Generated answer, citations, transcript body |
| Planner | Top filters and compact navigation | Task rows, deadlines, calendar text |
| Library | Sidebar and sort/filter controls | Document cards with dense metadata |
| Settings | Toolbar accessory controls only when useful | Lists, forms, account, privacy, billing, and destructive actions |

## Before / After Patterns

- **Tutor**: replace glass chat bubbles with stable transcript rows; keep only composer chrome, mode picker, and session controls glass-aware.
- **Flashcards**: keep the card face opaque; use normal buttons or compact chrome for grading and navigation.
- **Canvas**: remove frosted containers behind the drawing plane; keep the tool palette, page scrubber, and minimap as floating chrome.
- **Notebook**: keep the page body and text editor opaque; use glass only for mode switching, page navigation, or transient search.
- **Planner**: keep event rows and long agenda text opaque; use glass-aware filters or date controls only at chrome level.

## Fix Prompt Example

```text
Use the swiftui-feature-builder skill. Convert only the Canvas floating tool palette to Liquid Glass, keep the drawing canvas opaque, preserve the iOS 17 UI path, add a Reduce Transparency fallback, then build and run the app in Simulator.
```
