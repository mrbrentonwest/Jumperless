# Contributing Guide

Thank you for your interest in contributing! This document provides guidelines and workflows for contributing to this project.

## Getting Started

1. Read the [Environment Setup](docs/ENVIRONMENT_SETUP.md) guide
2. Review the [Project Constitution](.specify/memory/constitution.md)
3. Familiarize yourself with our [Git Guide](docs/GIT_GUIDE.md)

## Development Workflow

### 1. Pick an Issue
- Check the issue tracker for open issues
- Look for issues labeled `good first issue` if you're new
- Comment on the issue to claim it

### 2. Create a Branch
Use the `/git` command or follow our branch naming convention:
```
username/brief-description
```

Examples:
- `john/add-user-auth`
- `jane/fix-login-bug`

### 3. Make Changes
- Follow the code style guidelines
- Write tests for new functionality
- Update documentation as needed

### 4. Commit
Write clear commit messages:
```
type: brief description

Longer explanation if needed.

Fixes #123
```

Types: `feat`, `fix`, `docs`, `style`, `refactor`, `test`, `chore`

### 5. Open a Pull Request
- Fill out the PR template completely
- Link related issues
- Request review from appropriate team members

## Code Style

- Follow existing patterns in the codebase
- Use meaningful variable and function names
- Keep functions small and focused
- Comment complex logic

## Testing

- All new features require tests
- All bug fixes require regression tests
- Run the full test suite before submitting PR

## Documentation

- Update README for user-facing changes
- Update relevant docs in `/docs`
- Add inline comments for complex code

## Need Help?

- Use the `/git` command for interactive git help
- Check existing documentation in `/docs`
- Ask questions in issue discussions

## Code of Conduct

Be respectful and constructive. We're all here to build something great together.
