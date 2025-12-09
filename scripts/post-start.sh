#!/usr/bin/env bash

# Post-start initialization script
# Shows comprehensive help and usage instructions

set -e

GREEN='\033[0;32m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
MAGENTA='\033[0;35m'
NC='\033[0m'

echo ""
echo -e "${CYAN}┌─────────────────────────────────────────────────┐${NC}"
echo -e "${CYAN}│${NC}  ${GREEN}Slovor Development Environment${NC}             ${CYAN}│${NC}"
echo -e "${CYAN}└─────────────────────────────────────────────────┘${NC}"
echo ""

# Run setup check silently
if bash /app/scripts/setup-check.sh 2>/dev/null; then
    echo -e "${GREEN}✓${NC} Environment validated"
else
    echo -e "${BLUE}ℹ${NC} Running auto-repair..."
    bash /app/scripts/setup-repair.sh 2>/dev/null || true
fi

echo ""
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BLUE}📍 Access URLs${NC}"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "  ${GREEN}Local:${NC}    http://localhost:3000"
echo -e "  ${GREEN}Proxy:${NC}    http://slovor.lndo.site"
echo -e "  ${GREEN}API:${NC}      http://localhost:3000/api"
echo -e "  ${GREEN}DB:${NC}       localhost:5432 (postgres/postgres)"
echo ""

echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BLUE}🚀 Quick Start${NC}"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "  ${YELLOW}1.${NC} ${MAGENTA}lando dev${NC}        → Start development server"
echo -e "  ${YELLOW}2.${NC} Open http://localhost:3000"
echo -e "  ${YELLOW}3.${NC} Start coding in ${CYAN}slovor/src/${NC}"
echo ""

echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BLUE}📚 Available Commands${NC}"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""

echo -e "${YELLOW}Development:${NC}"
echo -e "  ${MAGENTA}lando dev${NC}         Start Next.js dev server"
echo -e "  ${MAGENTA}lando build${NC}       Build for production"
echo -e "  ${MAGENTA}lando start${NC}       Start production server"
echo ""

echo -e "${YELLOW}Code Quality:${NC}"
echo -e "  ${MAGENTA}lando lint${NC}        Run ESLint"
echo -e "  ${MAGENTA}lando lint:fix${NC}    Auto-fix lint issues"
echo -e "  ${MAGENTA}lando format${NC}      Format with Prettier"
echo -e "  ${MAGENTA}lando test${NC}        Run tests"
echo -e "  ${MAGENTA}lando tsc${NC}         TypeScript check"
echo ""

echo -e "${YELLOW}Database:${NC}"
echo -e "  ${MAGENTA}lando psql${NC}        PostgreSQL shell"
echo -e "  ${MAGENTA}lando db-dump${NC}     Export database"
echo -e "  ${MAGENTA}lando db-reset${NC}    Reset database"
echo -e "  ${MAGENTA}lando db-migrate${NC}  Run migrations"
echo ""

echo -e "${YELLOW}Diagnostics:${NC}"
echo -e "  ${MAGENTA}lando doctor${NC}      Full system check"
echo -e "  ${MAGENTA}lando health${NC}      Quick health check"
echo -e "  ${MAGENTA}lando urls${NC}        Show all URLs"
echo -e "  ${MAGENTA}lando info${NC}        Container info"
echo -e "  ${MAGENTA}lando logs${NC}        View logs"
echo ""

echo -e "${YELLOW}Project Management:${NC}"
echo -e "  ${MAGENTA}lando stop${NC}        Stop containers"
echo -e "  ${MAGENTA}lando restart${NC}     Restart containers"
echo -e "  ${MAGENTA}lando rebuild${NC}     Rebuild from scratch"
echo -e "  ${MAGENTA}lando ssh${NC}         Shell into container"
echo ""

echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BLUE}🔄 Common Workflows${NC}"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""

echo -e "${YELLOW}Start Development:${NC}"
echo -e "  ${GREEN}1.${NC} lando start"
echo -e "  ${GREEN}2.${NC} lando dev"
echo -e "  ${GREEN}3.${NC} Open http://localhost:3000"
echo ""

echo -e "${YELLOW}Before Commit:${NC}"
echo -e "  ${GREEN}1.${NC} lando lint:fix"
echo -e "  ${GREEN}2.${NC} lando format"
echo -e "  ${GREEN}3.${NC} lando test"
echo -e "  ${GREEN}4.${NC} git commit"
echo ""

echo -e "${YELLOW}Database Reset:${NC}"
echo -e "  ${GREEN}1.${NC} lando db-reset"
echo -e "  ${GREEN}2.${NC} lando db-migrate"
echo -e "  ${GREEN}3.${NC} lando restart"
echo ""

echo -e "${YELLOW}Troubleshooting:${NC}"
echo -e "  ${GREEN}1.${NC} lando doctor      ${GREEN}#${NC} Diagnose issues"
echo -e "  ${GREEN}2.${NC} lando logs -f     ${GREEN}#${NC} Watch logs"
echo -e "  ${GREEN}3.${NC} lando rebuild -y  ${GREEN}#${NC} Fresh start"
echo ""

echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BLUE}🔗 Resources${NC}"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "  ${GREEN}GitHub:${NC}    https://github.com/Den3112/slovor"
echo -e "  ${GREEN}Docs:${NC}      ${CYAN}docs/${NC} folder in project root"
echo -e "  ${GREEN}Supabase:${NC}  https://rsywmmnxkvwvhgrgzlei.supabase.co"
echo ""

echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${YELLOW}💡 Tips${NC}"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "  • Run ${MAGENTA}lando${NC} to see all available commands"
echo -e "  • Use ${MAGENTA}lando <command> --help${NC} for command details"
echo -e "  • Check ${CYAN}README.md${NC} for full documentation"
echo -e "  • All code goes in ${CYAN}slovor/src/${NC} directory"
echo ""
echo -e "${GREEN}✓${NC} Ready to develop! Start with: ${MAGENTA}lando dev${NC}"
echo ""
