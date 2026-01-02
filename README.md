# Project Starter Template

A reusable project template combining **Spec-Driven Development** (via [Spec-Kit](https://github.com/github/spec-kit)) with **RFC Pattern + Expiry Headers** for documentation freshness.

## Features

- **Multi-AI Support** - Pre-configured for 6 AI coding assistants
- **Spec-Driven Development** - All features start with specifications
- **Documentation Freshness** - Expiry headers and `/docs-audit` command
- **Git for Teams** - Interactive `/git` helper for non-technical users
- **Upgradeable** - Pull spec-kit updates without losing customizations
- **Tech-Stack Agnostic** - No assumptions about what you're building

## Quick Start

### From GitHub (Recommended)

```bash
# Create a new repo from this template
gh repo create MyNewProject --template Brenton-Thriviti/project-starter --clone
cd MyNewProject
```

### Manual Clone

```bash
git clone https://github.com/Brenton-Thriviti/project-starter.git MyNewProject
cd MyNewProject
rm -rf .git && git init
```

## Supported AI Tools

This template is pre-configured for:

| Tool | Configuration | Status |
|------|--------------|--------|
| Claude Code | `.claude/` | Ready |
| Cursor | `.cursor/` | Ready |
| GitHub Copilot | `.github/copilot-instructions.md` | Ready |
| Gemini CLI | `.gemini/` | Ready |
| OpenAI Codex CLI | `.codex/` | Ready |
| Windsurf | `.windsurf/` | Ready |

### Adding More AI Tools

```bash
specify init . --ai qwen --force
specify init . --ai opencode --force
specify init . --ai amp --force
```

## Slash Commands

### Spec-Kit Commands (All AI Tools)
| Command | Description |
|---------|-------------|
| `/speckit.constitution` | View/establish project principles |
| `/speckit.specify` | Create a new specification |
| `/speckit.plan` | Create implementation plan |
| `/speckit.tasks` | Generate actionable tasks |
| `/speckit.implement` | Execute implementation |

### Custom Commands (Claude Code)
| Command | Description |
|---------|-------------|
| `/docs-audit` | Check documentation freshness |
| `/git` | Interactive git helper |

## Documentation Strategy

### RFC Pattern + Expiry Headers

All documents in `.specify/` include YAML frontmatter:

```yaml
---
id: SPEC-001
type: spec
created: 2025-01-02
last_updated: 2025-01-02
review_by: 2025-04-02
status: active
---
```

### Review Intervals

| Document Type | Review Every |
|--------------|--------------|
| Specifications | 90 days |
| Gap Analyses | 30 days |
| Research | 180 days |
| Memory (project knowledge) | 90 days |

### Immutability Rules

- `spec`, `gap-analysis`, and `research` documents are **immutable** after approval
- Updates create new documents that supersede the originals
- `memory` documents are mutable

## Project Structure

```
project/
├── .claude/                 # Claude Code
│   ├── commands/
│   │   ├── docs-audit.md    # Documentation audit
│   │   ├── git.md           # Interactive git helper
│   │   └── speckit.*.md     # Spec-kit commands
│   └── skills/
│       ├── documentation-audit/
│       └── git-workflow/
├── .codex/                  # OpenAI Codex CLI
├── .cursor/                 # Cursor
├── .gemini/                 # Gemini CLI
├── .github/
│   ├── copilot-instructions.md
│   ├── ISSUE_TEMPLATE/
│   └── PULL_REQUEST_TEMPLATE.md
├── .windsurf/               # Windsurf
├── .specify/                # Spec-Kit core
│   ├── memory/
│   │   ├── constitution.md
│   │   ├── documentation-strategy.md
│   │   ├── team.md
│   │   └── customizations.md
│   ├── specs/               # Feature specifications
│   ├── templates/
│   └── scripts/
├── docs/
│   ├── GIT_GUIDE.md
│   ├── GETTING_STARTED.md
│   └── ENVIRONMENT_SETUP.md
├── scripts/
│   ├── git-helper.sh
│   └── upgrade-speckit.sh
├── CONTRIBUTING.md
├── SECURITY.md
└── README.md
```

## Upgrading Spec-Kit

```bash
./scripts/upgrade-speckit.sh
```

This will:
1. Back up your current configuration
2. Fetch the latest spec-kit templates
3. Show what changed
4. Guide you through re-applying customizations

## Customization

All customizations are tracked in `.specify/memory/customizations.md`. This helps with upgrades and team onboarding.

## Getting Help

- [Git Guide](docs/GIT_GUIDE.md) - Visual git reference
- [Getting Started](docs/GETTING_STARTED.md) - New team member onboarding
- [Environment Setup](docs/ENVIRONMENT_SETUP.md) - Dev environment setup
- [Contributing](CONTRIBUTING.md) - How to contribute

## License

Private/Proprietary - See your organization's licensing policy.
