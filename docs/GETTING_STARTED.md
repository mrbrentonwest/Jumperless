# Getting Started

Welcome to the team! This guide will help you get up and running.

## Day 1 Checklist

- [ ] Get access to the GitHub repository
- [ ] Set up your development environment (see [Environment Setup](ENVIRONMENT_SETUP.md))
- [ ] Clone the repository
- [ ] Read the [Project Constitution](../.specify/memory/constitution.md)
- [ ] Read the [Contributing Guide](../CONTRIBUTING.md)
- [ ] Join team communication channels

## Repository Structure

```
project/
├── .claude/          # Claude Code configuration
├── .cursor/          # Cursor configuration
├── .codex/           # OpenAI Codex configuration
├── .gemini/          # Gemini CLI configuration
├── .github/          # GitHub configuration + Copilot
├── .windsurf/        # Windsurf configuration
├── .specify/         # Spec-Driven Development core
│   ├── memory/       # Project knowledge and decisions
│   ├── specs/        # Feature specifications
│   ├── templates/    # Document templates
│   └── scripts/      # Automation scripts
├── docs/             # Documentation
├── scripts/          # Project scripts
└── src/              # Source code (when added)
```

## Key Concepts

### Spec-Driven Development
All significant changes start with a specification. Use `/speckit.specify` to create specs.

### Documentation Freshness
All documents have expiry dates. Run `/docs-audit` to check for stale documentation.

### Branch Naming
Use the format: `username/description`
The `/git` command will guide you through this.

## Useful Commands

| Command | Description |
|---------|-------------|
| `/speckit.constitution` | View project principles |
| `/speckit.specify` | Create a new specification |
| `/speckit.plan` | Create implementation plan |
| `/docs-audit` | Check documentation freshness |
| `/git` | Interactive git helper |

## Getting Help

1. Check the documentation in `/docs`
2. Read the specs in `.specify/specs/`
3. Ask team members
4. Open an issue for persistent problems

## Your First Contribution

1. Find an issue labeled `good first issue`
2. Read the linked spec (if any)
3. Use `/git` to create a branch
4. Make your changes
5. Open a pull request

Good luck and welcome aboard!
