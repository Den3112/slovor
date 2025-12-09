#!/usr/bin/env bash

# Post-start initialization script
# Clean, minimal output with useful information only

set -e

GREEN='\033[0;32m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

echo ""
echo -e "${CYAN}┌─────────────────────────────────────────────────┐${NC}"
echo -e "${CYAN}│${NC}  ${GREEN}Slovor Development Environment${NC}             ${CYAN}│${NC}"
echo -e "${CYAN}└─────────────────────────────────────────────────┘${NC}"
echo ""

# Run setup check (only shows errors/warnings)
if bash scripts/setup-check.sh; then
    echo -e "${GREEN}✓${NC} Environment validated"
else
    echo -e "${BLUE}ℹ${NC} Running auto-repair..."
    bash scripts/setup-repair.sh
fi

echo ""
echo -e "${BLUE}Quick Commands:${NC}"
echo "  lando dev       → Start development server"
echo "  lando doctor    → System diagnostics"
echo "  lando health    → Quick health check"
echo ""
echo -e "${BLUE}URLs:${NC}"
echo "  App:  http://localhost:3000"
echo "  API:  http://localhost:3000/api"
echo ""
