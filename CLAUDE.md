# Claude Code Instructions

## Project Type
This is a **project template** for starting new projects with Spec-Driven Development.

## Key Files
- `.specify/memory/constitution.md` - Project principles
- `.specify/memory/documentation-strategy.md` - RFC Pattern + Expiry Headers rules
- `.specify/memory/team.md` - Team roster for `/git` command
- `.specify/memory/customizations.md` - Track spec-kit modifications

## Custom Commands
- `/docs-audit` - Scan documentation for freshness and compliance
- `/git` - Interactive git workflow helper

## Documentation Standards
All documents in `.specify/` must include YAML frontmatter with:
- `id`, `type`, `created`, `last_updated`, `review_by`, `status`

Review intervals:
- spec: 90 days
- gap-analysis: 30 days
- research: 180 days
- memory: 90 days

## Immutability Rules
- `spec`, `gap-analysis`, `research` are immutable after approval
- Updates create superseding documents
- `memory` documents are mutable

## Branch Naming
Format: `{username}/{description}`
Team roster in `.specify/memory/team.md`
