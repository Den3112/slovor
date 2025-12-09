#!/usr/bin/env bash

# Shell setup script - configures terminal to always start in slovor_dev

set -e

GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${BLUE}Setting up shell configuration...${NC}"
echo ""

# Detect shell
SHELL_RC="$HOME/.bashrc"
if [ -f "$HOME/.zshrc" ]; then
    SHELL_RC="$HOME/.zshrc"
fi

echo "Shell config: $SHELL_RC"

# Backup existing config
if [ -f "$SHELL_RC" ]; then
    cp "$SHELL_RC" "${SHELL_RC}.backup.$(date +%Y%m%d_%H%M%S)"
    echo -e "${GREEN}✓${NC} Backup created"
fi

# Add Slovor section
if ! grep -q "# Slovor Project" "$SHELL_RC" 2>/dev/null; then
    cat >> "$SHELL_RC" <<'EOF'

# ============================================
# Slovor Project Configuration
# ============================================

# Project directory
export SLOVOR_DIR="$HOME/slovor_dev"

# Auto-navigate to project on terminal start
if [ "$PWD" = "$HOME" ] && [ -d "$SLOVOR_DIR" ]; then
    cd "$SLOVOR_DIR"
    echo "📂 Switched to Slovor project"
fi

# Aliases
alias slovor="cd $SLOVOR_DIR"
alias sdev="cd $SLOVOR_DIR && lando dev"
alias sstart="cd $SLOVOR_DIR && lando start"
alias sstop="cd $SLOVOR_DIR && lando stop"
alias sdoctor="cd $SLOVOR_DIR && lando doctor"
alias shealth="cd $SLOVOR_DIR && lando health"
alias slogs="cd $SLOVOR_DIR && lando logs"

# Lando shortcuts
alias l="lando"
alias ld="lando dev"
alias ls="lando start"
alias lst="lando stop"
alias lr="lando restart"
alias lb="lando rebuild -y"
alias li="lando info"

# Git shortcuts for Slovor
alias sgit="cd $SLOVOR_DIR && git"
alias spull="cd $SLOVOR_DIR && git pull origin main"
alias spush="cd $SLOVOR_DIR && git push origin main"
alias sstatus="cd $SLOVOR_DIR && git status"

EOF
    echo -e "${GREEN}✓${NC} Slovor configuration added to $SHELL_RC"
else
    echo -e "${YELLOW}⚠${NC} Slovor configuration already exists"
fi

# Source the config
source "$SHELL_RC" 2>/dev/null || true

echo ""
echo -e "${GREEN}✓${NC} Shell configured successfully!"
echo ""
echo -e "${BLUE}Available aliases:${NC}"
echo "  slovor      → cd to project"
echo "  sdev        → start dev server"
echo "  sstart      → start Lando"
echo "  sstop       → stop Lando"
echo "  sdoctor     → run diagnostics"
echo "  shealth     → quick health check"
echo ""
echo -e "${BLUE}Lando shortcuts:${NC}"
echo "  l           → lando"
echo "  ld          → lando dev"
echo "  ls          → lando start"
echo "  lst         → lando stop"
echo "  lr          → lando restart"
echo "  lb          → lando rebuild -y"
echo ""
echo -e "${YELLOW}Reload shell:${NC} source $SHELL_RC"
echo -e "${YELLOW}Or:${NC} Close and reopen terminal"
