#!/bin/bash
#
# Spec-Kit Upgrade Script
# Safely upgrade spec-kit while preserving customizations
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
BACKUP_DIR=".specify-backup-$(date +%Y%m%d-%H%M%S)"
CUSTOMIZATIONS_FILE=".specify/memory/customizations.md"

echo ""
info "=== Spec-Kit Upgrade Script ==="
echo ""

# Check prerequisites
if ! command -v specify &> /dev/null; then
    error "Error: 'specify' command not found."
    echo "Install with: pip install specify-cli"
    exit 1
fi

# Show current version
info "Current spec-kit version:"
specify version 2>/dev/null || echo "Unknown"
echo ""

# Check for customizations file
if [ -f "$CUSTOMIZATIONS_FILE" ]; then
    info "Customizations documented in: $CUSTOMIZATIONS_FILE"
    echo ""
    warn "The following customizations may be affected:"
    grep -E "^\- \*\*File\*\*:" "$CUSTOMIZATIONS_FILE" 2>/dev/null || echo "  (none found)"
    echo ""
else
    warn "No customizations.md found. Customizations may be overwritten."
fi

# Confirm
read -p "Continue with upgrade? (y/n): " confirm
if [ "$confirm" != "y" ]; then
    echo "Cancelled."
    exit 0
fi

# Create backup
info "Creating backup in $BACKUP_DIR..."
mkdir -p "$BACKUP_DIR"

# Backup key directories
for dir in .specify .claude .cursor .codex .gemini .windsurf .github; do
    if [ -d "$dir" ]; then
        cp -r "$dir" "$BACKUP_DIR/"
        echo "  Backed up: $dir"
    fi
done

success "Backup created: $BACKUP_DIR"
echo ""

# Run upgrades for each AI tool
info "Upgrading spec-kit templates..."
echo ""

TOOLS=("claude" "cursor-agent" "copilot" "gemini" "codex" "windsurf")

for tool in "${TOOLS[@]}"; do
    info "Upgrading $tool..."
    echo "y" | specify init . --ai "$tool" --force 2>&1 | tail -5
    echo ""
done

success "Upgrade complete!"
echo ""

# Show what changed
info "Checking for changes..."
echo ""

if command -v git &> /dev/null && git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
    echo "Modified files:"
    git diff --name-only 2>/dev/null || echo "  (not a git repo or no changes)"
    echo ""
    echo "New files:"
    git ls-files --others --exclude-standard 2>/dev/null || echo "  (none)"
else
    echo "Not a git repo - manually compare with backup in $BACKUP_DIR"
fi

echo ""
warn "Next steps:"
echo "  1. Review the changes (git diff or compare with backup)"
echo "  2. Re-apply any overwritten customizations from $CUSTOMIZATIONS_FILE"
echo "  3. Update $CUSTOMIZATIONS_FILE if you made new customizations"
echo "  4. Commit the changes"
echo ""
echo "If something went wrong, restore from backup:"
echo "  cp -r $BACKUP_DIR/* ."
echo ""
