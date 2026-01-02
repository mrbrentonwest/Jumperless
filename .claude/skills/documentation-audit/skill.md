# Documentation Audit Skill

This skill provides context for interpreting and acting on documentation audit results.

## Overview

The documentation audit system enforces the RFC Pattern + Expiry Headers strategy to maintain documentation freshness and integrity.

## Key Concepts

### Document Types

| Type | Purpose | Mutability |
|------|---------|------------|
| `spec` | Feature specifications | Immutable after approval |
| `gap-analysis` | Gap between current and desired state | Immutable |
| `research` | Technical investigations | Immutable |
| `memory` | Project knowledge, decisions | Mutable |

### Review Intervals

- **spec**: 90 days - Feature specs should be reviewed quarterly
- **gap-analysis**: 30 days - Gaps should be addressed quickly
- **research**: 180 days - Research may become outdated
- **memory**: 90 days - Project knowledge should stay current

## Interpreting Audit Results

### Expired Documents
These documents have passed their `review_by` date. Actions:
1. **Still accurate**: Update `review_by` to new date
2. **Needs updates**: For mutable docs, update content and dates
3. **Outdated**: For immutable docs, create superseding document

### Missing Frontmatter
Documents without proper frontmatter can't be tracked. Actions:
1. Add required YAML frontmatter block
2. Assign appropriate `id` following TYPE-XXX pattern
3. Set correct `type` based on document purpose
4. Calculate `review_by` based on type interval

### Ready to Supersede
Gap analyses with all gaps resolved should be superseded:
1. Create new document if needed
2. Update original status to `superseded`
3. Add `superseded_by` field pointing to new doc

## Immutability Rules

### When NOT to Edit
Never modify content of:
- Approved specifications
- Finalized gap analyses
- Completed research documents

### Allowed Updates
Even for immutable docs, you may update:
- `status` field (to `superseded` or `deprecated`)
- `superseded_by` field (to reference new document)

### Resolution Protocol
1. Create new document with incremented ID
2. Reference new doc in old doc's `superseded_by`
3. Update old doc's status to `superseded`

## Common Scenarios

### Scenario: Expired Spec
```yaml
# Old
review_by: 2025-01-01  # Past due
status: active

# Option 1: Still valid, extend review
review_by: 2025-04-01  # New date

# Option 2: Needs update, supersede
status: superseded
superseded_by: SPEC-002
```

### Scenario: Missing ID
```yaml
# Add frontmatter
---
id: SPEC-001
type: spec
created: 2025-01-02
last_updated: 2025-01-02
review_by: 2025-04-02
status: active
---
```

### Scenario: Gap Analysis Complete
```yaml
# Original gap doc
status: superseded
superseded_by: SPEC-005  # The spec that resolved the gaps
```

## Best Practices

1. Run `/docs-audit` weekly
2. Address expired documents within 1 week
3. Never skip adding frontmatter to new documents
4. Use consistent ID numbering within types
5. Document supersession chains for traceability
