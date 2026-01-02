# Git Guide for Teams

A visual, friendly guide to git for team members of all experience levels.

## Quick Reference Card

| I want to... | Command |
|-------------|---------|
| Start new work | `git checkout -b username/description` |
| Save changes | `git add . && git commit -m "message"` |
| Share with team | `git push` |
| Get team's changes | `git pull` |
| See what changed | `git status` |
| Switch branches | `git checkout branch-name` |

Or just use the `/git` command and follow the prompts!

## Core Concepts

### What is Git?

Git tracks changes to your files over time. Think of it like:
- **Track Changes** in Word, but for code
- **Time Machine** for your project
- A way for multiple people to work on the same files

### Branches

```
main ─────●─────●─────●─────●───────────●
                       \               /
feature-1               ●─────●───────●
```

- `main` is the official version everyone shares
- Branches let you work without affecting `main`
- When done, branches merge back into `main`

### The Git Workflow

```
┌─────────────┐     ┌─────────────┐     ┌─────────────┐
│  Your       │     │   Local     │     │   GitHub    │
│  Files      │ ──> │   Git       │ ──> │   (Remote)  │
│             │     │             │     │             │
└─────────────┘     └─────────────┘     └─────────────┘
     edit           commit (save)       push (share)

                    pull (download) <──────────────────
```

## Daily Workflow

### Morning: Get Latest Changes

```bash
git pull
```

This downloads any changes your teammates made.

### During the Day: Save Your Work

```bash
# See what you changed
git status

# Save everything
git add .
git commit -m "Add login form validation"
```

Commit often! It's like saving a game.

### End of Day: Share Your Work

```bash
git push
```

This uploads your commits to GitHub.

## Starting New Work

### 1. Make sure you have the latest code

```bash
git checkout main
git pull
```

### 2. Create your branch

```bash
git checkout -b yourname/what-youre-doing
```

Examples:
- `john/add-dark-mode`
- `jane/fix-signup-bug`

### 3. Do your work, commit often

```bash
# After making changes
git add .
git commit -m "What you did"
```

### 4. Push to GitHub

```bash
git push -u origin yourname/what-youre-doing
```

### 5. Open a Pull Request

Go to GitHub and click "Compare & pull request"

## Common Situations

### "I made changes but I'm on the wrong branch"

```bash
# Stash (temporarily save) your changes
git stash

# Switch to the right branch
git checkout correct-branch

# Get your changes back
git stash pop
```

### "I need to undo my last commit"

```bash
# Keep the changes, just uncommit
git reset --soft HEAD~1

# Throw away the changes completely
git reset --hard HEAD~1
```

### "Someone else changed the same file I did"

This is a merge conflict. Don't panic!

1. Open the file - you'll see markers like this:
```
<<<<<<< HEAD
Your version of the code
=======
Their version of the code
>>>>>>> other-branch
```

2. Edit the file to keep what you want
3. Remove the `<<<<<<<`, `=======`, and `>>>>>>>` markers
4. Save the file
5. `git add .` and `git commit`

### "I want to see what changed"

```bash
# See which files changed
git status

# See exactly what changed
git diff

# See commit history
git log --oneline
```

## Branch Naming

We use this format: `username/brief-description`

| Good | Bad |
|------|-----|
| `john/add-login` | `new-feature` |
| `jane/fix-button-color` | `jane's branch` |
| `alex/update-api-docs` | `stuff` |

## Commit Message Tips

| Good | Bad |
|------|-----|
| "Add email validation to signup form" | "Fixed stuff" |
| "Fix navigation menu closing on mobile" | "Updates" |
| "Update API documentation for v2 endpoints" | "Changes" |

Start with a verb: Add, Fix, Update, Remove, Refactor

## Getting Help

1. Use the `/git` command for interactive guidance
2. Check this guide for common situations
3. Ask a teammate
4. Search the error message online

## Visual: The Complete Picture

```
                    ┌──────────────────────────────────────┐
                    │            GitHub (Remote)            │
                    │  ┌──────────────────────────────────┐│
                    │  │     main branch (official)       ││
                    │  └──────────────────────────────────┘│
                    │  ┌──────────────────────────────────┐│
                    │  │     your-branch (your work)      ││
                    │  └──────────────────────────────────┘│
                    └──────────────────────────────────────┘
                                    ▲ push
                                    │
                                    ▼ pull/clone
                    ┌──────────────────────────────────────┐
                    │         Your Computer (Local)         │
                    │  ┌──────────────────────────────────┐│
                    │  │    Local Repository (.git)        ││
                    │  │    (commit history)              ││
                    │  └──────────────────────────────────┘│
                    │                ▲ commit              │
                    │                │                     │
                    │  ┌──────────────────────────────────┐│
                    │  │      Working Directory            ││
                    │  │      (your actual files)          ││
                    │  └──────────────────────────────────┘│
                    └──────────────────────────────────────┘
```
