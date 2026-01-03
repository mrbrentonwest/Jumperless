# Claude Code Instructions

## Project Type
This is a **project template** for starting new projects with Spec-Driven Development.

## Spec-Kit Workflow

### Content Flow
| Content | Location | Purpose |
|---------|----------|---------|
| Specs | `.specify/specs/[FEATURE-NAME]/` | Define what to build |
| Code | Project root (`src/`, `tests/`, etc.) | The actual implementation |

### Per-Feature Folder Structure
Each feature gets its own folder in `.specify/specs/`:
```
.specify/specs/
└── user-authentication/        # Feature folder
    ├── spec.md                 # What to build (user stories, requirements)
    ├── plan.md                 # How to build (architecture, design)
    ├── tasks.md                # Work breakdown (ordered task list)
    ├── research.md             # (optional) Technical research
    └── gap.md                  # (optional) Gap analysis
```

### Command Workflow
```
/speckit.constitution  →  Define project principles (one-time setup)
/speckit.specify       →  Create spec.md (what to build)
/speckit.clarify       →  Ask clarifying questions, refine spec
/speckit.plan          →  Create plan.md (how to build)
/speckit.tasks         →  Create tasks.md (work breakdown)
/speckit.analyze       →  Cross-artifact consistency check
/speckit.implement     →  Execute tasks, write code to PROJECT ROOT
/speckit.checklist     →  Generate verification checklist
```

### Key Insight
The `.specify/` folder contains **planning documents only**. All actual code is written to the main project structure (wherever `src/`, `backend/`, `frontend/`, etc. are located).

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

## Template Updates (For Forked Projects)
Projects forked from `project-starter` can pull template updates.

### First-time setup (run once after forking):
```bash
./scripts/setup-upstream.sh
```

### Pull latest template updates:
```bash
git fetch upstream
git merge upstream/master --allow-unrelated-histories
```

### Recommended flow for feature branches:
1. Merge upstream into main first
2. Then merge main into your feature branch

```bash
git checkout main
git fetch upstream
git merge upstream/master
git checkout your-feature-branch
git merge main
```
