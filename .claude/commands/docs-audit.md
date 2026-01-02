# Documentation Audit

Scan all documentation for freshness and compliance with documentation standards.

## Instructions

Perform a comprehensive audit of all documents in the `.specify/` directory:

### 1. Scan Documents
Find all markdown files in `.specify/` and check for YAML frontmatter.

### 2. Check Expiry
For each document with `review_by` date:
- Compare against today's date
- Flag if past due
- Calculate days overdue

### 3. Validate Frontmatter
Required fields for all documents:
- `id`: Unique identifier (TYPE-XXX format)
- `type`: One of `spec`, `gap-analysis`, `research`, `memory`
- `created`: Creation date
- `last_updated`: Last modification date
- `review_by`: Review due date
- `status`: One of `draft`, `active`, `deprecated`, `superseded`

### 4. Check Gap Analyses
For documents of type `gap-analysis`:
- Check if all gaps are resolved
- Flag for superseding if complete

### 5. Generate Report

Format output as:

```markdown
## Doc Audit Report

**Scan Date**: YYYY-MM-DD
**Documents Scanned**: X

### Expired (Need Review)
| File | Type | Review By | Days Overdue |
|------|------|-----------|--------------|
| path/to/file.md | spec | 2025-01-01 | 30 |

### Missing Frontmatter
| File | Missing Fields |
|------|----------------|
| path/to/file.md | id, type, review_by |

### Invalid Frontmatter
| File | Issues |
|------|--------|
| path/to/file.md | Invalid status value |

### Ready to Supersede
| File | Reason |
|------|--------|
| path/to/gap.md | All gaps resolved |

### Summary
- **Total Documents**: X
- **Compliant**: X
- **Need Attention**: X
- **Ready to Archive**: X
```

### 6. Suggest Actions
For each issue found, suggest the appropriate action:
- Expired: Update `review_by` or create superseding document
- Missing frontmatter: Add required fields
- Ready to supersede: Create new document and update status

## Review Intervals Reference
| Type | Interval |
|------|----------|
| spec | 90 days |
| gap-analysis | 30 days |
| research | 180 days |
| memory | 90 days |
