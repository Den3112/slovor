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

# Load GitHub token from .env.local if exists
if [ -f "/app/slovor/.env.local" ]; then
    export $(grep -v '^#' /app/slovor/.env.local | grep 'GITHUB_TOKEN' | xargs) 2>/dev/null || true
fi

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

# Check GitHub API Token
echo -ne "  ${BLUE}⟳${NC} GitHub API Token...          "
if [ -n "$GITHUB_TOKEN" ]; then
    HTTP_CODE=$(curl -s --max-time 5 -o /dev/null -w "%{http_code}" \
        -H "Authorization: token $GITHUB_TOKEN" \
        https://api.github.com/user)
    if echo "$HTTP_CODE" | grep -q "200"; then
        echo -e "${GREEN}✓ OK${NC}"
    else
        echo -e "${RED}✗ INVALID${NC}"
        all_ok=false
    fi
else
    echo -e "${YELLOW}⚠ NOT SET${NC}"
    echo ""
    echo -e "    ${YELLOW}→${NC} Add GITHUB_TOKEN to slovor/.env.local"
    echo -e "    ${YELLOW}→${NC} Get token: ${BLUE}https://github.com/settings/tokens/new${NC}"
    echo -e "    ${YELLOW}→${NC} Scopes needed: ${BOLD}repo, project${NC}"
fi

# Check local PostgreSQL
echo -ne "  ${BLUE}⟳${NC} Local PostgreSQL...          "
if command -v docker > /dev/null 2>&1; then
    # Running on host - check docker container
    if docker ps --format '{{.Names}}' 2>/dev/null | grep -q 'slovor_database'; then
        echo -e "${GREEN}✓ RUNNING${NC}"
    else
        echo -e "${YELLOW}⚠ STOPPED${NC} (run 'lando start')"
    fi
else
    # Running inside container - try psql connection
    if psql -h database -U postgres -d slovor -c 'SELECT 1' > /dev/null 2>&1; then
        echo -e "${GREEN}✓ RUNNING${NC}"
    else
        echo -e "${YELLOW}⚠ STOPPED${NC} (run 'lando start')"
    fi
fi

echo ""
echo -e "${BOLD}${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"

if [ "$all_ok" = true ]; then
    echo -e "  ${GREEN}✓ All services are reachable${NC}"
    echo ""
    exit 0
else
    echo -e "  ${RED}✗ Some services are unreachable${NC}"
    echo ""
    if [ -z "$GITHUB_TOKEN" ]; then
        echo -e "  ${BOLD}To enable GitHub API access:${NC}"
        echo -e "    1. Get token: ${BLUE}https://github.com/settings/tokens/new${NC}"
        echo -e "    2. Add to ${GREEN}slovor/.env.local${NC}: ${BOLD}GITHUB_TOKEN=your_token${NC}"
        echo -e "    3. Run: ${YELLOW}lando restart${NC}"
    fi
    echo ""
    exit 1
fi
