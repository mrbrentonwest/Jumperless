#!/bin/bash
#
# Git Helper Script
# Interactive git workflow for teams
# Use this when not in a Claude Code session
#

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Print colored output
info() { echo -e "${BLUE}$1${NC}"; }
success() { echo -e "${GREEN}$1${NC}"; }
warn() { echo -e "${YELLOW}$1${NC}"; }
error() { echo -e "${RED}$1${NC}"; }

# Check if we're in a git repo
check_git_repo() {
    if ! git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
        error "This folder isn't set up for git yet."
        exit 1
    fi
}

# Main menu
show_menu() {
    echo ""
    info "=== Git Helper ==="
    echo ""
    echo "What would you like to do?"
    echo ""
    echo "  1) Create a new branch"
    echo "  2) Save my work (commit)"
    echo "  3) Share my work (push)"
    echo "  4) Get latest changes (pull)"
    echo "  5) Check status"
    echo "  6) Switch branch"
    echo "  7) Exit"
    echo ""
    read -p "Choose an option (1-7): " choice

    case $choice in
        1) create_branch ;;
        2) commit_changes ;;
        3) push_changes ;;
        4) pull_changes ;;
        5) check_status ;;
        6) switch_branch ;;
        7) exit 0 ;;
        *) warn "Invalid option. Please choose 1-7." && show_menu ;;
    esac
}

# Option 1: Create a new branch
create_branch() {
    echo ""
    read -p "Enter your username (e.g., john): " username
    read -p "Briefly describe what you're working on (e.g., add login page): " description

    # Convert description to branch-friendly format
    branch_desc=$(echo "$description" | tr '[:upper:]' '[:lower:]' | tr ' ' '-' | tr -cd '[:alnum:]-')
    branch_name="${username}/${branch_desc}"

    info "Creating branch: $branch_name"

    git checkout -b "$branch_name"

    success "Created and switched to branch '$branch_name'"
    show_menu
}

# Option 2: Commit changes
commit_changes() {
    echo ""

    # Check for changes
    if git diff --quiet && git diff --cached --quiet; then
        warn "No changes to save. Make some changes first!"
        show_menu
        return
    fi

    info "Changed files:"
    git status --short
    echo ""

    read -p "What did you change? " message

    git add .
    git commit -m "$message"

    success "Saved! Your changes are committed locally."
    show_menu
}

# Option 3: Push changes
push_changes() {
    echo ""

    branch=$(git branch --show-current)

    # Check if remote tracking exists
    if ! git config --get "branch.${branch}.remote" > /dev/null 2>&1; then
        info "First time pushing this branch..."
        git push -u origin "$branch"
    else
        git push
    fi

    success "Shared! Your changes are now on GitHub."
    show_menu
}

# Option 4: Pull changes
pull_changes() {
    echo ""

    # Check for uncommitted changes
    if ! git diff --quiet || ! git diff --cached --quiet; then
        warn "You have unsaved changes. Stashing them temporarily..."
        git stash
        STASHED=true
    else
        STASHED=false
    fi

    info "Getting latest changes..."
    git pull

    if [ "$STASHED" = true ]; then
        info "Restoring your unsaved changes..."
        git stash pop
    fi

    success "You're up to date!"
    show_menu
}

# Option 5: Check status
check_status() {
    echo ""

    branch=$(git branch --show-current)
    info "You're on branch: $branch"
    echo ""

    # Count changes
    modified=$(git diff --name-only | wc -l | tr -d ' ')
    staged=$(git diff --cached --name-only | wc -l | tr -d ' ')
    untracked=$(git ls-files --others --exclude-standard | wc -l | tr -d ' ')

    if [ "$modified" -gt 0 ]; then
        echo "  - $modified file(s) with unsaved changes"
    fi
    if [ "$staged" -gt 0 ]; then
        echo "  - $staged file(s) ready to commit"
    fi
    if [ "$untracked" -gt 0 ]; then
        echo "  - $untracked new file(s) not being tracked"
    fi
    if [ "$modified" -eq 0 ] && [ "$staged" -eq 0 ] && [ "$untracked" -eq 0 ]; then
        success "  Everything is clean!"
    fi

    echo ""
    show_menu
}

# Option 6: Switch branch
switch_branch() {
    echo ""
    info "Available branches:"
    git branch -a | head -20
    echo ""

    read -p "Which branch do you want to switch to? " branch

    # Check for uncommitted changes
    if ! git diff --quiet || ! git diff --cached --quiet; then
        warn "You have unsaved changes."
        read -p "Stash them and continue? (y/n): " stash_choice
        if [ "$stash_choice" = "y" ]; then
            git stash
        else
            warn "Cancelled. Save your work first."
            show_menu
            return
        fi
    fi

    git checkout "$branch"
    success "Switched to branch '$branch'"
    show_menu
}

# Main
check_git_repo
show_menu
