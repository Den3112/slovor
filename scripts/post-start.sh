#!/usr/bin/env bash

# Post-start welcome message with all essential info
# This script runs inside the container after lando start

set +e  # Don't exit on errors

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
MAGENTA='\033[0;35m'
BOLD='\033[1m'
NC='\033[0m'

echo ""
echo -e "${CYAN}┌─────────────────────────────────────────────────┐${NC}"
echo -e "${CYAN}│${NC}  ${BOLD}${BLUE}Slovor - Ready to Develop${NC}                  ${CYAN}│${NC}"
echo -e "${CYAN}└─────────────────────────────────────────────────┘${NC}"
echo ""

# Check if auto-repair is needed
REPAIR_STATUS="ok"
REPAIR_MESSAGE=""

if [ ! -f "/app/slovor/.env.local" ]; then
    echo -e "${BLUE}⟳${NC} Running auto-repair..."
    echo ""
    if bash /app/scripts/setup-repair.sh 2>&1; then
        REPAIR_STATUS="ok"
        REPAIR_MESSAGE="Auto-repair completed successfully"
    else
        REPAIR_STATUS="error"
        REPAIR_MESSAGE="Auto-repair failed - environment setup incomplete"
    fi
    echo ""
fi

echo -e "${BOLD}${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BOLD}${GREEN}🚀 Quick Start${NC}"
echo -e "${BOLD}${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "  ${YELLOW}lando dev${NC}          Start development server"
echo -e "  ${YELLOW}lando psql${NC}         Open database shell"
echo -e "  ${YELLOW}lando doctor${NC}       Run diagnostics"
echo -e "  ${YELLOW}lando${NC}              Show all commands"
echo ""

echo -e "${BOLD}${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BOLD}${GREEN}🛠️  Essential Commands${NC}"
echo -e "${BOLD}${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "${BOLD}Development:${NC}"
echo -e "  ${YELLOW}lando dev${NC}              Start dev server with hot reload"
echo -e "  ${YELLOW}lando npm install${NC}      Install packages"
echo -e "  ${YELLOW}lando build${NC}            Build for production"
echo ""
echo -e "${BOLD}Code Quality:${NC}"
echo -e "  ${YELLOW}lando lint:fix${NC}         Auto-fix ESLint errors"
echo -e "  ${YELLOW}lando format${NC}           Format code with Prettier"
echo -e "  ${YELLOW}lando test${NC}             Run tests"
echo ""
echo -e "${BOLD}Database:${NC}"
echo -e "  ${YELLOW}lando psql${NC}             PostgreSQL shell"
echo -e "  ${YELLOW}lando db-reset${NC}         Reset database"
echo ""
echo -e "${BOLD}Troubleshooting:${NC}"
echo -e "  ${YELLOW}lando doctor${NC}           Full diagnostics"
echo -e "  ${YELLOW}lando restart${NC}          Restart containers"
echo -e "  ${YELLOW}lando rebuild -y${NC}       Rebuild from scratch"
echo ""

echo -e "${BOLD}${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BOLD}${GREEN}🔄 Typical Workflow${NC}"
echo -e "${BOLD}${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "  ${BOLD}1.${NC} Start:        ${YELLOW}lando start${NC} → ${YELLOW}lando dev${NC}"
echo -e "  ${BOLD}2.${NC} Code:         Edit files in ${GREEN}slovor/src/${NC}"
echo -e "  ${BOLD}3.${NC} Test:         ${YELLOW}lando lint:fix${NC} → ${YELLOW}lando test${NC}"
echo -e "  ${BOLD}4.${NC} Deploy:       ${YELLOW}git push origin main${NC}"
echo -e "  ${BOLD}5.${NC} Stop:         ${YELLOW}lando stop${NC}"
echo ""

echo -e "${BOLD}${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BOLD}${GREEN}📚 Resources${NC}"
echo -e "${BOLD}${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "  ${BOLD}Docs:${NC}        ${GREEN}docs/${NC} folder (ROADMAP, TESTING, etc)"
echo -e "  ${BOLD}GitHub:${NC}      ${MAGENTA}https://github.com/Den3112/slovor${NC}"
echo ""

# ==========================================
# SYSTEM STATUS - показываем в конце!
# ==========================================

echo -e "${BOLD}${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BOLD}${BLUE}📡 System Status${NC}"
echo -e "${BOLD}${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""

if [ "$REPAIR_STATUS" = "ok" ]; then
    echo -e "  ${GREEN}✓${NC} ${BOLD}Status:${NC}      All systems operational"
    if [ -n "$REPAIR_MESSAGE" ]; then
        echo -e "  ${GREEN}✓${NC} ${BOLD}Setup:${NC}       $REPAIR_MESSAGE"
    fi
    echo ""
    echo -e "  ${GREEN}→${NC} Ready to code! Run: ${YELLOW}lando dev${NC}"
else
    echo -e "  ${RED}✗${NC} ${BOLD}Status:${NC}      Issues detected"
    echo -e "  ${RED}✗${NC} ${BOLD}Problem:${NC}     $REPAIR_MESSAGE"
    echo ""
    echo -e "  ${YELLOW}→${NC} ${BOLD}Action needed:${NC}"
    echo -e "     1. Check errors above"
    echo -e "     2. Run: ${YELLOW}lando rebuild -y${NC}"
    echo -e "     3. If still broken: ${YELLOW}lando doctor${NC}"
fi

echo ""

# ==========================================
# QUICK START LINKS - в самом конце!
# ==========================================

echo -e "${BOLD}${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BOLD}${GREEN}🚀 Quick Start Links${NC}"
echo -e "${BOLD}${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "  ${BOLD}💻 Local:${NC}"
echo -e "     ${BLUE}http://localhost:3000${NC}           Main app"
echo -e "     ${BLUE}http://localhost:3000/api${NC}       API"
echo ""
echo -e "  ${BOLD}🌐 Production:${NC}"
echo -e "     ${MAGENTA}https://slovor.vercel.app${NC}       Live site"
echo ""
echo -e "  ${BOLD}🗃️ Database:${NC}"
echo -e "     ${CYAN}postgresql://postgres:postgres@localhost:5432/slovor${NC}"
echo ""
echo -e "  ${BOLD}📦 External:${NC}"
echo -e "     ${MAGENTA}https://github.com/Den3112/slovor${NC}              GitHub"
echo -e "     ${MAGENTA}https://rsywmmnxkvwvhgrgzlei.supabase.co${NC}     Supabase"
echo ""
echo -e "${BOLD}${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""

exit 0
