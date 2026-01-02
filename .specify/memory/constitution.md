# Project Constitution

## Core Principles

### I. Spec-Driven Development
All significant features and changes must be specified before implementation. Specifications serve as the source of truth and contract between stakeholders.

### II. Documentation Freshness
Documentation is a living asset. All documents must include expiry headers and be reviewed on schedule. Stale documentation is worse than no documentation.

### III. Immutable Records
Gap analyses, research documents, and resolved specs are immutable once finalized. Updates create new documents that supersede, never modify, the originals.

### IV. Test-First Development
Tests are written before implementation. Red-Green-Refactor cycle is strictly enforced for all code changes.

### V. Simplicity
Start simple, evolve as needed. YAGNI (You Aren't Gonna Need It) principles apply. Complexity must be justified.

## Documentation Standards

### Required Frontmatter
All documents in `.specify/` must include YAML frontmatter:
```yaml
---
id: TYPE-XXX
type: spec | gap-analysis | research | memory
created: YYYY-MM-DD
last_updated: YYYY-MM-DD
review_by: YYYY-MM-DD
status: draft | active | deprecated | superseded
superseded_by: TYPE-XXX  # If applicable
---
```

### Review Schedule
| Document Type | Review Interval |
|--------------|-----------------|
| `spec` | 90 days |
| `gap-analysis` | 30 days |
| `research` | 180 days |
| `memory` | 90 days |

## Governance

- Constitution supersedes all other practices
- Amendments require documentation, approval, and migration plan
- All PRs/reviews must verify compliance with these principles
- Run `/docs-audit` regularly to ensure documentation freshness

**Version**: 1.0.0 | **Ratified**: 2026-01-02 | **Last Amended**: 2026-01-02
