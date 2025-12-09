#!/usr/bin/env bash

# Check connectivity to all external services

GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}Checking connectivity to external services...${NC}"
echo ""

all_ok=true

# Check Vercel
echo -ne "${BLUE}⟳${NC} Vercel Production... "
if curl -s --max-time 5 -o /dev/null -w "%{http_code}" https://slovor.vercel.app | grep -q "200\|301\|302"; then
    echo -e "${GREEN}✓ OK${NC}"
else
    echo -e "${RED}✗ FAILED${NC}"
    all_ok=false
fi

# Check Supabase
echo -ne "${BLUE}⟳${NC} Supabase API... "
if curl -s --max-time 5 -o /dev/null -w "%{http_code}" https://rsywmmnxkvwvhgrgzlei.supabase.co | grep -q "200\|301\|302\|404"; then
    echo -e "${GREEN}✓ OK${NC}"
else
    echo -e "${RED}✗ FAILED${NC}"
    all_ok=false
fi

# Check GitHub
echo -ne "${BLUE}⟳${NC} GitHub Repository... "
if curl -s --max-time 5 -o /dev/null -w "%{http_code}" https://github.com/Den3112/slovor | grep -q "200"; then
    echo -e "${GREEN}✓ OK${NC}"
else
    echo -e "${RED}✗ FAILED${NC}"
    all_ok=false
fi

# Check GitHub Projects
echo -ne "${BLUE}⟳${NC} GitHub Projects... "
if curl -s --max-time 5 -o /dev/null -w "%{http_code}" https://github.com/users/Den3112/projects/3 | grep -q "200"; then
    echo -e "${GREEN}✓ OK${NC}"
else
    echo -e "${RED}✗ FAILED${NC}"
    all_ok=false
fi

# Check local PostgreSQL
echo -ne "${BLUE}⟳${NC} Local PostgreSQL... "
if pg_isready -h localhost -p 5432 -U postgres > /dev/null 2>&1; then
    echo -e "${GREEN}✓ OK${NC}"
else
    echo -e "${YELLOW}⚠ NOT RUNNING${NC} (normal if lando is stopped)"
fi

echo ""
if [ "$all_ok" = true ]; then
    echo -e "${GREEN}✓ All external services are reachable${NC}"
    exit 0
else
    echo -e "${RED}✗ Some services are unreachable${NC}"
    echo -e "${YELLOW}→${NC} Check your internet connection"
    exit 1
fi
