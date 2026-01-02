# Environment Setup

This guide covers setting up your development environment.

## Prerequisites

### Required
- Git 2.30+
- Your preferred code editor (VS Code recommended)

### Optional (based on project needs)
Uncomment and configure based on your tech stack:

```bash
# Node.js projects
# - Node.js 18+ (LTS recommended)
# - pnpm 8+ (preferred) or npm/yarn

# Python projects
# - Python 3.10+
# - pip or poetry

# Go projects
# - Go 1.21+

# Rust projects
# - Rust (latest stable)
# - cargo
```

## Setup Steps

### 1. Clone the Repository

```bash
git clone https://github.com/YOUR_ORG/YOUR_REPO.git
cd YOUR_REPO
```

### 2. Install Dependencies

```bash
# Node.js (uncomment what applies)
# pnpm install
# npm install
# yarn install

# Python
# pip install -r requirements.txt
# poetry install

# Go
# go mod download

# Rust
# cargo build
```

### 3. Environment Configuration

```bash
# Copy example environment file
cp .env.example .env

# Edit with your local settings
# Never commit .env files!
```

### 4. Verify Setup

```bash
# Run tests to verify everything works
# pnpm test
# npm test
# pytest
# go test ./...
# cargo test
```

## Editor Setup

### VS Code (Recommended)

The repository includes recommended settings and extensions.

1. Open the project in VS Code
2. Accept the prompt to install recommended extensions
3. Settings are automatically applied from `.vscode/settings.json`

### Other Editors

See `.editorconfig` for formatting rules that work across editors.

## AI Assistant Setup

This project supports multiple AI coding assistants:

| Tool | Configuration | Setup |
|------|---------------|-------|
| Claude Code | `.claude/` | Install Claude Code CLI |
| Cursor | `.cursor/` | Open project in Cursor |
| GitHub Copilot | `.github/copilot-instructions.md` | Enable in VS Code |
| Gemini CLI | `.gemini/` | Install Gemini CLI |
| OpenAI Codex | `.codex/` | Set CODEX_HOME env var |
| Windsurf | `.windsurf/` | Open project in Windsurf |

## Common Issues

### Permission Denied
```bash
# Make scripts executable
chmod +x scripts/*.sh
chmod +x .specify/scripts/bash/*.sh
```

### Dependencies Won't Install
- Clear package manager cache
- Delete lock file and node_modules/vendor folder
- Try again

### Tests Failing
- Ensure all dependencies are installed
- Check environment variables
- Verify database connections (if applicable)

## Next Steps

1. Read [Getting Started](GETTING_STARTED.md)
2. Review the [Contributing Guide](../CONTRIBUTING.md)
3. Explore the codebase
