# Git Workflow Skill

This skill provides context for helping users with git operations, especially those who aren't comfortable with command-line git.

## Philosophy

Git is powerful but intimidating. This skill helps translate git concepts into plain language and guides users through common workflows without requiring them to memorize commands.

## Key Concepts to Explain Simply

### Branches
- **What they are**: "A separate workspace where you can make changes without affecting the main code"
- **Why we use them**: "So multiple people can work at the same time without stepping on each other's toes"

### Commits
- **What they are**: "A save point for your work, like saving a game"
- **Why we use them**: "So you can go back if something breaks, and so others can see what changed"

### Push/Pull
- **Push**: "Sending your saved work to GitHub so others can see it"
- **Pull**: "Downloading everyone else's changes to your computer"

### Merge Conflicts
- **What they are**: "Two people changed the same part of a file"
- **How to fix**: "We need to decide which changes to keep (or combine them)"

## Branch Naming Convention

Format: `{username}/{brief-description}`

Rules:
- All lowercase
- Use dashes instead of spaces
- Keep it short but descriptive
- Username from team.md roster

Examples:
- `john/add-user-login`
- `jane/fix-checkout-bug`
- `alex/update-readme`

## Common Workflows

### Starting New Work
1. Pull latest from main
2. Create feature branch
3. Make changes
4. Commit regularly
5. Push to share
6. Open pull request

### Daily Routine
1. Pull latest changes
2. Work on your branch
3. Commit when you reach a good stopping point
4. Push at end of day

### Handling Conflicts
1. Don't panic
2. Look at the conflicting files
3. Find the conflict markers (`<<<<<<<`, `=======`, `>>>>>>>`)
4. Decide what to keep
5. Remove the markers
6. Save and commit

## Friendly Error Messages

### "Your branch is behind"
"The team has made changes since you last pulled. Run 'Get latest changes' to catch up."

### "Merge conflict in file.txt"
"Someone else changed file.txt in the same place you did. Let's look at both versions and decide what to keep."

### "Permission denied"
"GitHub needs to verify it's you. Check that you're logged in to GitHub CLI or that your SSH key is set up."

### "Detached HEAD"
"You're looking at old code, not the latest. Let's get you back to your branch."

## Best Practices

### Commit Messages
- Start with what you did: "Add", "Fix", "Update", "Remove"
- Be specific: "Fix login button not responding" not "Fix bug"
- Keep it short (50 chars or less for the first line)

### When to Commit
- After completing a logical unit of work
- Before switching tasks
- Before taking a break
- When tests pass

### When to Push
- At least once per day
- Before asking for help
- Before starting something risky
- After finishing a feature

## Team Roster Location

Team members are defined in `.specify/memory/team.md` with this structure:

```markdown
| Name | Username | Role | Active |
|------|----------|------|--------|
| John Smith | john | Developer | true |
```

Use the username for branch naming. Only show active members.
