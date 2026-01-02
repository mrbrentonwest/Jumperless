---
id: MEM-001
type: memory
created: 2026-01-02
last_updated: 2026-01-02
review_by: 2026-04-02
status: active
---

# Documentation Strategy

RFC Pattern + Expiry Headers for documentation freshness and integrity.

## Document Types

| Type | Purpose | Mutability | Review Interval |
|------|---------|------------|-----------------|
| `spec` | Feature specifications, requirements | Immutable after approval | 90 days |
| `gap-analysis` | Gaps between current and desired state | Immutable | 30 days |
| `research` | Technical research, investigations | Immutable | 180 days |
| `memory` | Project knowledge, decisions, context | Mutable | 90 days |

## YAML Frontmatter Requirements

Every document MUST include:

```yaml
---
id: TYPE-XXX           # Unique identifier (e.g., SPEC-001, GAP-003)
type: spec             # One of: spec, gap-analysis, research, memory
created: 2026-01-02    # Creation date
last_updated: 2026-01-02  # Last modification date
review_by: 2026-04-02  # Expiry date (auto-calculated based on type)
status: draft          # One of: draft, active, deprecated, superseded
superseded_by: null    # ID of superseding document (if applicable)
---
```

## Immutability Rules

### Immutable Documents (spec, gap-analysis, research)
Once status changes from `draft` to `active`:
- Content MUST NOT be modified
- Typo fixes require a new document that supersedes
- Updates require a new document with incremented ID
- Original document status changes to `superseded`
- `superseded_by` field references the new document

### Mutable Documents (memory)
- Can be updated at any time
- `last_updated` must reflect each change
- `review_by` recalculated on each update

## Resolution Protocol

When a gap-analysis identifies issues:

1. **Document the Gap**: Create `GAP-XXX` with findings
2. **Plan Resolution**: Create `SPEC-XXX` for each gap to be addressed
3. **Implement**: Follow spec-driven development
4. **Verify**: Confirm gap is resolved
5. **Supersede**: Mark original gap-analysis as `superseded`
6. **Create New Baseline**: If needed, create new gap-analysis for remaining items

## Review Schedule

| Interval | Document Types | Action |
|----------|---------------|--------|
| 30 days | gap-analysis | Review or supersede |
| 90 days | spec, memory | Review and update review_by or supersede |
| 180 days | research | Review relevance, archive if outdated |

## Calculating review_by

```
review_by = last_updated + review_interval

Where review_interval is:
- spec: 90 days
- gap-analysis: 30 days
- research: 180 days
- memory: 90 days
```

## Document Lifecycle

```
draft → active → deprecated/superseded
         ↓
    [review_by date passes]
         ↓
    /docs-audit flags for review
         ↓
    Update review_by OR supersede
```

## File Organization

```
.specify/
├── memory/               # Mutable project knowledge
│   ├── constitution.md
│   ├── documentation-strategy.md  (this file)
│   ├── team.md
│   └── customizations.md
├── specs/                # Per-feature specifications
│   └── FEATURE-NAME/
│       ├── spec.md
│       ├── gap.md        # Gap analysis if applicable
│       └── research.md   # Research if applicable
├── templates/            # Document templates
└── scripts/              # Automation scripts
```

## Enforcement

- Run `/docs-audit` to check for expired documents
- CI can fail on expired critical documents
- Stale documentation should be addressed in each sprint
