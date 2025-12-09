#!/usr/bin/env bash

# Check connectivity to all external services

GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
BOLD='\033[1m'
NC='\033[0m'

echo -e "${BOLD}${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BOLD}${BLUE}📡 System Connectivity Check${NC}"
echo -e "${BOLD}${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""

all_ok=true

# Check Vercel Production
echo -ne "  ${BLUE}⟳${NC} Vercel Production...        "
if curl -s --max-time 5 -o /dev/null -w "%{http_code}" https://slovor.vercel.app | grep -q "200\|301\|302"; then
    echo -e "${GREEN}✓ OK${NC}"
else
    echo -e "${RED}✗ FAILED${NC}"
    all_ok=false
fi

# Check Supabase
echo -ne "  ${BLUE}⟳${NC} Supabase API...             "
if curl -s --max-time 5 -o /dev/null -w "%{http_code}" https://rsywmmnxkvwvhgrgzlei.supabase.co | grep -q "200\|301\|302\|404"; then
    echo -e "${GREEN}✓ OK${NC}"
else
    echo -e "${RED}✗ FAILED${NC}"
    all_ok=false
fi

# Check GitHub
echo -ne "  ${BLUE}⟳${NC} GitHub Repository...         "
if curl -s --max-time 5 -o /dev/null -w "%{http_code}" https://github.com/Den3112/slovor | grep -q "200"; then
    echo -e "${GREEN}✓ OK${NC}"
else
    echo -e "${RED}✗ FAILED${NC}"
    all_ok=false
fi

# Check GitHub Projects (requires auth, so just check if GitHub is up)
echo -ne "  ${BLUE}⟳${NC} GitHub Projects...           "
echo -e "${YELLOW}⚠ REQUIRES AUTH${NC} (manual check needed)"

# Check local PostgreSQL
echo -ne "  ${BLUE}⟳${NC} Local PostgreSQL...          "
if command -v pg_isready > /dev/null 2>&1; then
    if pg_isready -h localhost -p 5432 -U postgres > /dev/null 2>&1; then
        echo -e "${GREEN}✓ RUNNING${NC}"
    else
        echo -e "${YELLOW}⚠ STOPPED${NC} (run 'lando start')"
    fi
else
    # Inside container, check via psql
    if psql -h database -U postgres -d slovor -c 'SELECT 1' > /dev/null 2>&1; then
        echo -e "${GREEN}✓ RUNNING${NC}"
    else
        echo -e "${YELLOW}⚠ STOPPED${NC} (run 'lando start')"
    fi
fi

echo ""
echo -e "${BOLD}${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"

if [ "$all_ok" = true ]; then
    echo -e "  ${GREEN}✓ All public services are reachable${NC}"
    echo ""
    echo -e "  ${BOLD}Manual Checks:${NC}"
    echo -e "    • GitHub Projects: ${BLUE}https://github.com/users/Den3112/projects/3${NC}"
    echo -e "    • Vercel Dashboard: ${BLUE}https://vercel.com/slovors-projects/slovor${NC}"
    echo ""
    exit 0
else
    echo -e "  ${RED}✗ Some services are unreachable${NC}"
    echo -e "  ${YELLOW}→${NC} Check your internet connection"
    echo ""
    exit 1
fi
