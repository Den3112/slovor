#!/usr/bin/env bash

# Post-start initialization script
# Clean, minimal output with useful information only

set -e

GREEN='\033[0;32m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo ""
echo -e "${CYAN}┌─────────────────────────────────────────────────┐${NC}"
echo -e "${CYAN}│${NC}  ${GREEN}Slovor Development Environment${NC}             ${CYAN}│${NC}"
echo -e "${CYAN}└─────────────────────────────────────────────────┘${NC}"
echo ""

# Run setup check (only shows errors/warnings)
if bash /app/scripts/setup-check.sh 2>/dev/null; then
    echo -e "${GREEN}✓${NC} Environment validated"
else
    echo -e "${BLUE}ℹ${NC} Running auto-repair..."
    bash /app/scripts/setup-repair.sh 2>/dev/null || true
fi

echo ""
echo -e "${BLUE}Quick Commands:${NC}"
echo "  lando dev       → Start development server"
echo "  lando doctor    → System diagnostics"
echo "  lando health    → Quick health check"
echo "  lando urls      → Show all URLs"
echo ""
echo -e "${BLUE}Access URLs:${NC}"
echo "  Local:    http://localhost:3000"
echo "  Proxy:    http://slovor.lndo.site"
echo "  API:      http://localhost:3000/api"
echo "  Database: localhost:5432"
echo ""
echo -e "${BLUE}External Services:${NC}"
echo "  Supabase: https://rsywmmnxkvwvhgrgzlei.supabase.co"
echo "  GitHub:   https://github.com/Den3112/slovor"
echo ""
echo -e "${YELLOW}💡 Tip:${NC} Run 'lando urls' to see all available endpoints"
echo ""
