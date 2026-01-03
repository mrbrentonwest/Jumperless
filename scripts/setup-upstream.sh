#!/bin/bash
#
# Setup Upstream Remote
# Run once after forking from project-starter to enable template updates
#

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

info() { echo -e "${BLUE}$1${NC}"; }
success() { echo -e "${GREEN}$1${NC}"; }
warn() { echo -e "${YELLOW}$1${NC}"; }
error() { echo -e "${RED}$1${NC}"; }

# Configuration
UPSTREAM_URL="https://github.com/Brenton-Thriviti/project-starter.git"

echo ""
info "=== Setup Upstream Remote ==="
echo ""

# Check if we're in a git repo
if ! git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
    error "Error: Not a git repository."
    exit 1
fi

# Check if upstream already exists
if git remote get-url upstream &>/dev/null; then
    CURRENT_URL=$(git remote get-url upstream)
    if [ "$CURRENT_URL" = "$UPSTREAM_URL" ]; then
        success "Upstream already configured correctly."
    else
        warn "Upstream exists but points to different URL:"
        echo "  Current:  $CURRENT_URL"
        echo "  Expected: $UPSTREAM_URL"
        echo ""
        read -p "Update upstream URL? (y/n): " confirm
        if [ "$confirm" = "y" ]; then
            git remote set-url upstream "$UPSTREAM_URL"
            success "Updated upstream remote."
        else
            echo "Skipped."
        fi
    fi
else
    git remote add upstream "$UPSTREAM_URL"
    success "Added upstream remote: $UPSTREAM_URL"
fi

echo ""
info "Current remotes:"
git remote -v
echo ""

success "Setup complete!"
echo ""
info "To pull template updates into your current branch:"
echo ""
echo "  git fetch upstream"
echo "  git merge upstream/master --allow-unrelated-histories"
echo ""
info "Recommended workflow for feature branches:"
echo ""
echo "  1. Merge upstream into main first:"
echo "     git checkout main"
echo "     git fetch upstream"
echo "     git merge upstream/master"
echo ""
echo "  2. Then merge main into your feature branch:"
echo "     git checkout your-feature-branch"
echo "     git merge main"
echo ""
