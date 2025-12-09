#!/usr/bin/env bash

# Post-start welcome message
# Runs after lando start

set +e

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
        REPAIR_MESSAGE="Environment setup completed"
    else
        REPAIR_STATUS="error"
        REPAIR_MESSAGE="Environment setup incomplete"
    fi
    echo ""
fi

echo -e "${BOLD}${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BOLD}${GREEN}🚀 Quick Start${NC}"
echo -e "${BOLD}${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "  ${YELLOW}lando dev${NC}          Start development server"
echo -e "  ${YELLOW}lando status${NC}       Check all services"
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
echo -e "  ${YELLOW}lando psql${NC}             PostgreSQL shell (local dev DB)"
echo -e "  ${YELLOW}lando db-reset${NC}         Reset local database"
echo ""
echo -e "${BOLD}Troubleshooting:${NC}"
echo -e "  ${YELLOW}lando status${NC}           Check connectivity"
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
# SYSTEM STATUS CHECK
# ==========================================

echo -e "${BOLD}${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BOLD}${BLUE}📡 System Status${NC}"
echo -e "${BOLD}${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""

# Load GitHub token
if [ -f "/app/slovor/.env.local" ]; then
    export $(grep -v '^#' /app/slovor/.env.local | grep 'GITHUB_TOKEN' | xargs) 2>/dev/null || true
fi

# Check external services
echo -e "  ${BOLD}External Services:${NC}"

# Vercel
echo -ne "    ${BLUE}⟳${NC} Vercel Production...        "
if curl -s --max-time 3 -o /dev/null -w "%{http_code}" https://slovor.vercel.app 2>/dev/null | grep -q "200\|301\|302"; then
    echo -e "${GREEN}✓ OK${NC}"
else
    echo -e "${RED}✗ FAILED${NC}"
fi

# Supabase
echo -ne "    ${BLUE}⟳${NC} Supabase API...             "
if curl -s --max-time 3 -o /dev/null -w "%{http_code}" https://rsywmmnxkvwvhgrgzlei.supabase.co 2>/dev/null | grep -q "200\|301\|302\|404"; then
    echo -e "${GREEN}✓ OK${NC}"
else
    echo -e "${RED}✗ FAILED${NC}"
fi

# GitHub
echo -ne "    ${BLUE}⟳${NC} GitHub Repository...         "
if curl -s --max-time 3 -o /dev/null -w "%{http_code}" https://github.com/Den3112/slovor 2>/dev/null | grep -q "200"; then
    echo -e "${GREEN}✓ OK${NC}"
else
    echo -e "${RED}✗ FAILED${NC}"
fi

# GitHub Projects
echo -ne "    ${BLUE}⟳${NC} GitHub Projects...           "
if [ -n "$GITHUB_TOKEN" ]; then
    HTTP_CODE=$(curl -s --max-time 3 -o /dev/null -w "%{http_code}" \
        -H "Authorization: token $GITHUB_TOKEN" \
        https://api.github.com/users/Den3112/projects 2>/dev/null)
    if echo "$HTTP_CODE" | grep -q "200"; then
        echo -e "${GREEN}✓ OK${NC}"
    else
        echo -e "${RED}✗ FAILED${NC} (token invalid?)"
    fi
else
    echo -e "${YELLOW}⚠ NO TOKEN${NC}"
fi

# PostgreSQL
echo -ne "    ${BLUE}⟳${NC} Local PostgreSQL...          "
if psql -h database -U postgres -d slovor -c 'SELECT 1' > /dev/null 2>&1; then
    echo -e "${GREEN}✓ RUNNING${NC}"
else
    echo -e "${YELLOW}⚠ STOPPED${NC} (run 'lando start')"
fi

echo ""
echo -e "  ${BOLD}Setup Status:${NC}"

if [ "$REPAIR_STATUS" = "ok" ]; then
    echo -e "    ${GREEN}✓${NC} Environment ready"
    if [ -n "$REPAIR_MESSAGE" ]; then
        echo -e "    ${GREEN}✓${NC} $REPAIR_MESSAGE"
    fi
    echo ""
    echo -e "  ${GREEN}→${NC} Ready to code! Run: ${YELLOW}lando dev${NC}"
else
    echo -e "    ${RED}✗${NC} Issues detected: $REPAIR_MESSAGE"
    echo ""
    echo -e "  ${YELLOW}→${NC} ${BOLD}Action needed:${NC}"
    echo -e "       1. Check errors above"
    echo -e "       2. Run: ${YELLOW}lando rebuild -y${NC}"
    echo -e "       3. If still broken: ${YELLOW}lando doctor${NC}"
fi

echo ""

# ==========================================
# QUICK START LINKS
# ==========================================

echo -e "${BOLD}${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BOLD}${GREEN}🚀 Quick Start Links${NC}"
echo -e "${BOLD}${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "  ${BOLD}💻 Local Development:${NC}"
echo -e "     ${BLUE}http://localhost:3000${NC}           Main app"
echo -e "     ${BLUE}http://localhost:3000/api${NC}       API"
echo ""
echo -e "  ${BOLD}🌐 Production:${NC}"
echo -e "     ${MAGENTA}https://slovor.vercel.app${NC}       Live site"
echo ""
echo -e "  ${BOLD}🗃️  Database:${NC}"
echo -e "     ${CYAN}postgresql://postgres:postgres@localhost:5432/slovor${NC}"
echo -e "     ${YELLOW}↳${NC} Local development database (auto-starts with lando)"
echo ""
echo -e "  ${BOLD}📊 Project Management:${NC}"
echo -e "     ${MAGENTA}https://github.com/Den3112/slovor${NC}              GitHub"
echo -e "     ${MAGENTA}https://github.com/users/Den3112/projects/3${NC}    Project Board"
echo -e "     ${MAGENTA}https://vercel.com/slovors-projects/slovor${NC}     Vercel Dashboard"
echo ""
echo -e "  ${BOLD}☁️  Backend Services:${NC}"
echo -e "     ${MAGENTA}https://rsywmmnxkvwvhgrgzlei.supabase.co${NC}     Supabase"
echo ""
echo -e "${BOLD}${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""

exit 0
