---
id: MEM-002
type: memory
created: 2026-01-02
last_updated: 2026-01-02
review_by: 2026-04-02
status: active
---

# Team Members

Configuration for `/git` command team member selection.

## Team Roster

Add team members below. The `/git` command will use these for branch naming.

| Name | Username | Role | Active |
|------|----------|------|--------|
| Example User | example | Developer | true |

## Branch Naming Convention

Format: `{username}/{description}`

Examples:
- `john/add-user-auth`
- `jane/fix-login-bug`
- `alex/update-api-docs`

## How to Update

1. Add new team members to the roster table
2. Set `Active` to `false` when someone leaves (don't delete)
3. Update `last_updated` and `review_by` dates
