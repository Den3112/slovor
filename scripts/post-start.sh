#!/usr/bin/env bash

# Post-start help - clear, practical, no bullshit

set -e

GREEN='\033[0;32m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
MAGENTA='\033[0;35m'
RED='\033[0;31m'
NC='\033[0m'

echo ""
echo -e "${CYAN}┌─────────────────────────────────────────────────┐${NC}"
echo -e "${CYAN}│${NC}  ${GREEN}Slovor - Ready to Develop${NC}                  ${CYAN}│${NC}"
echo -e "${CYAN}└─────────────────────────────────────────────────┘${NC}"
echo ""

# Run setup check silently
if bash /app/scripts/setup-check.sh 2>/dev/null; then
    echo -e "${GREEN}✓${NC} Environment OK"
else
    echo -e "${YELLOW}⚠${NC} Running auto-repair..."
    bash /app/scripts/setup-repair.sh 2>/dev/null || true
fi

echo ""
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BLUE}🚀 Start Development${NC}"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "  ${YELLOW}1.${NC} ${MAGENTA}lando dev${NC}"
echo -e "  ${YELLOW}2.${NC} Open ${CYAN}http://localhost:3000${NC} in browser"
echo -e "  ${YELLOW}3.${NC} Edit files in ${CYAN}slovor/src/${NC}"
echo -e "  ${YELLOW}4.${NC} Hot reload works automatically"
echo ""

echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BLUE}📍 Working URLs${NC}"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "  ${GREEN}Local Dev:${NC}    http://localhost:3000"
echo -e "  ${GREEN}API:${NC}          http://localhost:3000/api"
echo -e "  ${GREEN}Production:${NC}   https://slovor.vercel.app"
echo -e "  ${GREEN}Database:${NC}     localhost:5432"
echo -e "                 └─ user: ${YELLOW}postgres${NC} / pass: ${YELLOW}postgres${NC}"
echo ""

echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BLUE}🛠️ Essential Commands${NC}"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""

echo -e "${YELLOW}Development:${NC}"
echo -e "  ${MAGENTA}lando dev${NC}              Start dev server (with hot reload)"
echo -e "  ${MAGENTA}lando npm install${NC}      Install new packages"
echo -e "  ${MAGENTA}lando build${NC}            Build for production"
echo ""

echo -e "${YELLOW}Code Quality:${NC}"
echo -e "  ${MAGENTA}lando lint:fix${NC}         Fix ESLint errors automatically"
echo -e "  ${MAGENTA}lando format${NC}           Format code with Prettier"
echo -e "  ${MAGENTA}lando tsc${NC}              Check TypeScript types"
echo -e "  ${MAGENTA}lando test${NC}             Run tests"
echo ""

echo -e "${YELLOW}Database:${NC}"
echo -e "  ${MAGENTA}lando psql${NC}             Open PostgreSQL shell"
echo -e "  ${MAGENTA}lando db-reset${NC}         Reset database ${RED}(deletes all data!)${NC}"
echo -e "  ${MAGENTA}lando db-migrate${NC}       Run migrations"
echo ""

echo -e "${YELLOW}Troubleshooting:${NC}"
echo -e "  ${MAGENTA}lando doctor${NC}           Full system diagnostics"
echo -e "  ${MAGENTA}lando logs -f${NC}          Watch live logs (Ctrl+C to exit)"
echo -e "  ${MAGENTA}lando restart${NC}          Restart containers"
echo -e "  ${MAGENTA}lando rebuild -y${NC}       Nuclear option: rebuild everything"
echo ""

echo -e "${YELLOW}Help:${NC}"
echo -e "  ${MAGENTA}lando${NC}                  List all commands"
echo -e "  ${MAGENTA}lando urls${NC}             Show URLs and credentials"
echo -e "  ${MAGENTA}lando help${NC}             Show this help again"
echo ""

echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BLUE}📚 Documentation & Resources${NC}"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "  ${GREEN}Local Docs:${NC}      ${CYAN}docs/${NC} folder (PROJECT_ROADMAP.md, TESTING.md, etc)"
echo -e "  ${GREEN}GitHub:${NC}          https://github.com/Den3112/slovor"
echo -e "  ${GREEN}Production:${NC}      https://slovor.vercel.app"
echo -e "  ${GREEN}Supabase DB:${NC}     https://rsywmmnxkvwvhgrgzlei.supabase.co"
echo ""

echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BLUE}🔄 Typical Workflow${NC}"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "  ${YELLOW}Morning:${NC}"
echo -e "    ${GREEN}1.${NC} lando start"
echo -e "    ${GREEN}2.${NC} lando dev"
echo -e "    ${GREEN}3.${NC} Code in slovor/src/"
echo ""
echo -e "  ${YELLOW}Before Commit:${NC}"
echo -e "    ${GREEN}1.${NC} lando lint:fix"
echo -e "    ${GREEN}2.${NC} lando format"
echo -e "    ${GREEN}3.${NC} lando test"
echo -e "    ${GREEN}4.${NC} git add . && git commit"
echo ""
echo -e "  ${YELLOW}Deploy to Production:${NC}"
echo -e "    ${GREEN}1.${NC} git push origin main"
echo -e "    ${GREEN}2.${NC} Vercel auto-deploys to https://slovor.vercel.app"
echo ""
echo -e "  ${YELLOW}End of Day:${NC}"
echo -e "    ${GREEN}1.${NC} git push"
echo -e "    ${GREEN}2.${NC} lando stop"
echo ""

echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BLUE}⚠️  Common Issues${NC}"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "  ${RED}Port 3000 already in use?${NC}"
echo -e "    → ${CYAN}sudo lsof -ti:3000 | xargs kill -9${NC}"
echo ""
echo -e "  ${RED}Containers won't start?${NC}"
echo -e "    → ${CYAN}lando poweroff && sudo service docker restart${NC}"
echo ""
echo -e "  ${RED}Changes not showing?${NC}"
echo -e "    → Check browser console (F12)"
echo -e "    → Hard refresh (Ctrl+Shift+R)"
echo ""
echo -e "  ${RED}Something broken?${NC}"
echo -e "    → ${CYAN}lando doctor${NC} ${GREEN}#${NC} diagnose issues"
echo -e "    → ${CYAN}lando rebuild -y${NC} ${GREEN}#${NC} nuclear option"
echo ""

echo -e "${GREEN}✓${NC} Ready! Run: ${MAGENTA}lando dev${NC}"
echo ""
