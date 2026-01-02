# Git Helper

Interactive git workflow for teams. No commands to remember.

## Instructions

Present an interactive menu to help the user with common git operations. This is designed for team members who may not be comfortable with git commands.

### Main Menu

Ask the user what they want to do:

1. **Create a new branch** - Start working on something new
2. **Save my work (commit)** - Save changes with a message
3. **Share my work (push)** - Send changes to GitHub
4. **Get latest changes (pull)** - Download team's changes
5. **Check status** - See what's changed
6. **Switch branch** - Move to a different branch

### Option 1: Create a New Branch

1. Read `.specify/memory/team.md` to get the team roster
2. Ask: "Who is working on this?" and present team member options
3. Ask: "Briefly describe what you're working on" (e.g., "add login page")
4. Create branch: `{username}/{description-with-dashes}`
5. Confirm: "Created branch `john/add-login-page` and switched to it"

### Option 2: Save My Work (Commit)

1. Run `git status` to show changes
2. If no changes: "No changes to save. Make some changes first!"
3. If changes exist:
   - Show what files changed
   - Ask: "What did you change?" for commit message
   - Stage all changes: `git add .`
   - Commit with message
   - Confirm: "Saved! Your changes are committed locally."

### Option 3: Share My Work (Push)

1. Check if branch exists on remote
2. If first push: `git push -u origin {branch}`
3. If exists: `git push`
4. Confirm: "Shared! Your changes are now on GitHub."
5. If there are conflicts, explain in simple terms

### Option 4: Get Latest Changes (Pull)

1. Check current branch
2. Stash any uncommitted changes if present
3. Run `git pull`
4. Restore stashed changes if any
5. If merge conflicts:
   - Explain in simple terms
   - List conflicting files
   - Offer to help resolve

### Option 5: Check Status

1. Run `git status`
2. Translate into plain English:
   - "You're on branch X"
   - "You have X files with unsaved changes"
   - "You have X new files not being tracked"
   - "You're X commits ahead/behind the team"

### Option 6: Switch Branch

1. Show available branches
2. Ask which branch to switch to
3. Handle uncommitted changes (stash or warn)
4. Switch and confirm

## Error Handling

Always translate git errors into friendly language:

| Git Error | Friendly Message |
|-----------|-----------------|
| merge conflict | "Someone else changed the same file. Let me help you combine the changes." |
| uncommitted changes | "You have unsaved work. Want to save it first?" |
| not a git repo | "This folder isn't set up for git yet." |
| authentication failed | "GitHub needs you to log in. Check your credentials." |

## Team Configuration

Team members are configured in `.specify/memory/team.md`. The roster table contains:
- Name
- Username (for branch naming)
- Role
- Active status

Only show active team members in selection.
