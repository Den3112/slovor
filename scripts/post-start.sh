#!/usr/bin/env bash

# Post-start welcome message with all essential info
# This script runs inside the container after lando start

# Don't exit on errors - we want to show the welcome message anyway
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

# Check if auto-repair is needed (only if .env is missing)
REPAIR_FAILED=0
if [ ! -f "/app/slovor/.env.local" ]; then
    echo -e "${YELLOW}⚠${NC} Running auto-repair..."
    # Run repair and capture exit code
    if bash /app/scripts/setup-repair.sh 2>&1; then
        echo -e "${GREEN}✓${NC} Auto-repair completed successfully"
    else
        REPAIR_FAILED=1
        echo -e "${RED}✗${NC} Auto-repair failed (see above for details)"
        echo -e "${YELLOW}→${NC} You may need to run: ${CYAN}lando rebuild -y${NC}"
    fi
    echo ""
fi

echo -e "${BOLD}${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BOLD}${GREEN}🚀 Start Development${NC}"
echo -e "${BOLD}${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "  ${BOLD}1.${NC} ${YELLOW}lando dev${NC}"
echo -e "  ${BOLD}2.${NC} Open ${BLUE}http://localhost:3000${NC} in browser"
echo -e "  ${BOLD}3.${NC} Edit files in ${GREEN}slovor/src/${NC}"
echo -e "  ${BOLD}4.${NC} Hot reload works automatically"
echo ""

echo -e "${BOLD}${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BOLD}${GREEN}📍 Working URLs${NC}"
echo -e "${BOLD}${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "  ${BOLD}Local Dev:${NC}    ${BLUE}http://localhost:3000${NC}"
echo -e "  ${BOLD}API:${NC}          ${BLUE}http://localhost:3000/api${NC}"
echo -e "  ${BOLD}Production:${NC}   ${MAGENTA}https://slovor.vercel.app${NC}"
echo -e "  ${BOLD}Database:${NC}     ${CYAN}localhost:5432${NC}"
echo -e "                 ${CYAN}└─${NC} user: ${GREEN}postgres${NC} / pass: ${GREEN}postgres${NC}"
echo ""

echo -e "${BOLD}${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BOLD}${GREEN}🛠️  Essential Commands${NC}"
echo -e "${BOLD}${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "${BOLD}Development:${NC}"
echo -e "  ${YELLOW}lando dev${NC}              Start dev server (with hot reload)"
echo -e "  ${YELLOW}lando npm install${NC}      Install new packages"
echo -e "  ${YELLOW}lando build${NC}            Build for production"
echo ""
echo -e "${BOLD}Code Quality:${NC}"
echo -e "  ${YELLOW}lando lint:fix${NC}         Fix ESLint errors automatically"
echo -e "  ${YELLOW}lando format${NC}           Format code with Prettier"
echo -e "  ${YELLOW}lando tsc${NC}              Check TypeScript types"
echo -e "  ${YELLOW}lando test${NC}             Run tests"
echo ""
echo -e "${BOLD}Database:${NC}"
echo -e "  ${YELLOW}lando psql${NC}             Open PostgreSQL shell"
echo -e "  ${YELLOW}lando db-reset${NC}         Reset database (deletes all data!)"
echo -e "  ${YELLOW}lando db-migrate${NC}       Run migrations"
echo ""
echo -e "${BOLD}Troubleshooting:${NC}"
echo -e "  ${YELLOW}lando doctor${NC}           Full system diagnostics"
echo -e "  ${YELLOW}lando logs -f${NC}          Watch live logs (Ctrl+C to exit)"
echo -e "  ${YELLOW}lando restart${NC}          Restart containers"
echo -e "  ${YELLOW}lando rebuild -y${NC}       Nuclear option: rebuild everything"
echo ""
echo -e "${BOLD}Help:${NC}"
echo -e "  ${YELLOW}lando${NC}                  List all commands"
echo -e "  ${YELLOW}lando urls${NC}             Show URLs and credentials"
echo -e "  ${YELLOW}lando help${NC}             Show this help again"
echo ""

echo -e "${BOLD}${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BOLD}${GREEN}📚 Documentation & Resources${NC}"
echo -e "${BOLD}${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "  ${BOLD}Local Docs:${NC}      ${GREEN}docs/${NC} folder (PROJECT_ROADMAP.md, TESTING.md, etc)"
echo -e "  ${BOLD}GitHub:${NC}          ${MAGENTA}https://github.com/Den3112/slovor${NC}"
echo -e "  ${BOLD}Production:${NC}      ${MAGENTA}https://slovor.vercel.app${NC}"
echo -e "  ${BOLD}Supabase DB:${NC}     ${MAGENTA}https://rsywmmnxkvwvhgrgzlei.supabase.co${NC}"
echo ""

echo -e "${BOLD}${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BOLD}${GREEN}🔄 Typical Workflow${NC}"
echo -e "${BOLD}${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "  ${BOLD}Morning:${NC}"
echo -e "    ${YELLOW}1.${NC} lando start"
echo -e "    ${YELLOW}2.${NC} lando dev"
echo -e "    ${YELLOW}3.${NC} Code in slovor/src/"
echo ""
echo -e "  ${BOLD}Before Commit:${NC}"
echo -e "    ${YELLOW}1.${NC} lando lint:fix"
echo -e "    ${YELLOW}2.${NC} lando format"
echo -e "    ${YELLOW}3.${NC} lando test"
echo -e "    ${YELLOW}4.${NC} git add . && git commit"
echo ""
echo -e "  ${BOLD}Deploy to Production:${NC}"
echo -e "    ${YELLOW}1.${NC} git push origin main"
echo -e "    ${YELLOW}2.${NC} Vercel auto-deploys to ${MAGENTA}https://slovor.vercel.app${NC}"
echo ""
echo -e "  ${BOLD}End of Day:${NC}"
echo -e "    ${YELLOW}1.${NC} git push"
echo -e "    ${YELLOW}2.${NC} lando stop"
echo ""

echo -e "${BOLD}${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BOLD}${RED}⚠️  Common Issues${NC}"
echo -e "${BOLD}${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "  ${BOLD}Port 3000 already in use?${NC}"
echo -e "    ${CYAN}→${NC} sudo lsof -ti:3000 | xargs kill -9"
echo ""
echo -e "  ${BOLD}Containers won't start?${NC}"
echo -e "    ${CYAN}→${NC} lando poweroff && sudo service docker restart"
echo ""
echo -e "  ${BOLD}Changes not showing?${NC}"
echo -e "    ${CYAN}→${NC} Check browser console (F12)"
echo -e "    ${CYAN}→${NC} Hard refresh (Ctrl+Shift+R)"
echo ""
echo -e "  ${BOLD}Something broken?${NC}"
echo -e "    ${CYAN}→${NC} lando doctor # diagnose issues"
echo -e "    ${CYAN}→${NC} lando rebuild -y # nuclear option"
echo ""

if [ $REPAIR_FAILED -eq 1 ]; then
    echo -e "${RED}✗${NC} Ready with warnings! Run: ${YELLOW}lando dev${NC}"
else
    echo -e "${GREEN}✓${NC} Ready! Run: ${YELLOW}lando dev${NC}"
fi
echo ""

echo -e "${BOLD}${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BOLD}${GREEN}🚀 Quick Start Links${NC}"
echo -e "${BOLD}${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "  ${BOLD}💻 Local Development:${NC}"
echo -e "     ${BLUE}http://localhost:3000${NC}           Main application"
echo -e "     ${BLUE}http://localhost:3000/api${NC}       API endpoints"
echo ""
echo -e "  ${BOLD}🌐 Production:${NC}"
echo -e "     ${MAGENTA}https://slovor.vercel.app${NC}       Live site"
echo ""
echo -e "  ${BOLD}🗃️ Database:${NC}"
echo -e "     ${CYAN}postgresql://postgres:postgres@localhost:5432/slovor${NC}"
echo ""
echo -e "  ${BOLD}📦 GitHub:${NC}"
echo -e "     ${MAGENTA}https://github.com/Den3112/slovor${NC}"
echo ""
echo -e "  ${BOLD}☁️ Supabase:${NC}"
echo -e "     ${MAGENTA}https://rsywmmnxkvwvhgrgzlei.supabase.co${NC}"
echo ""
echo -e "${BOLD}${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""

# Exit with success so lando start doesn't fail
# But the warning above will make it visible if repair failed
exit 0
