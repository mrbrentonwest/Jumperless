---
id: MEM-003
type: memory
created: 2026-01-02
last_updated: 2026-01-02
review_by: 2026-04-02
status: active
---

# Spec-Kit Customizations

Track all modifications to spec-kit defaults for upgrade compatibility.

## Purpose

When upgrading spec-kit, this document helps identify:
- What was customized and why
- Which files might have merge conflicts
- What needs to be re-applied after upgrade

## Customizations Applied

### 1. Enhanced Constitution
- **File**: `.specify/memory/constitution.md`
- **Change**: Replaced template with project-specific principles including documentation freshness
- **Reason**: Establish documentation standards as core principle

### 2. Documentation Strategy
- **File**: `.specify/memory/documentation-strategy.md`
- **Change**: Added RFC Pattern + Expiry Headers documentation
- **Reason**: Enforce documentation freshness and immutability rules

### 3. Team Configuration
- **File**: `.specify/memory/team.md`
- **Change**: Added team roster for `/git` command
- **Reason**: Support interactive git workflow with team member selection

### 4. Custom Commands
- **File**: `.claude/commands/docs-audit.md`
- **Change**: Added documentation audit command
- **Reason**: Enforce documentation freshness

- **File**: `.claude/commands/git.md`
- **Change**: Added interactive git helper
- **Reason**: Simplify git for non-technical team members

### 5. Custom Skills
- **Directory**: `.claude/skills/documentation-audit/`
- **Change**: Added doc audit skill
- **Reason**: Provide context for audit results

- **Directory**: `.claude/skills/git-workflow/`
- **Change**: Added git workflow skill
- **Reason**: Provide context for git operations

## Upgrade Procedure

1. Run `scripts/upgrade-speckit.sh`
2. Review diff for conflicts with customizations listed above
3. Re-apply customizations if overwritten
4. Update this file with any new customizations
5. Commit changes
