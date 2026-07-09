# Query Performance Checklist

- Use predicates instead of fetching all rows and filtering in memory.
- Use sort descriptors for stable display order.
- Limit result sets where screens only show a subset.
- Avoid recomputing expensive derived values in list rows.
- Avoid nested queries inside row views.
- Avoid heavy `@Query` orchestration in oversized root views.
- Check whether search should debounce input.
- Keep indexes or model structure in mind for frequently filtered fields.
- Prefer explicit fetch/service layers when filtering, grouping, sectioning, caching, or cross-model joins outgrow straightforward view-facing streams.
