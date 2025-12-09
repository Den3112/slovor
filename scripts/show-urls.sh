#!/usr/bin/env bash

# Show all project URLs

GREEN='\033[0;32m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

echo ""
echo -e "${CYAN}═══════════════════════════════════════════════════${NC}"
echo -e "${CYAN}  Slovor - All URLs${NC}"
echo -e "${CYAN}═══════════════════════════════════════════════════${NC}"
echo ""

echo -e "${BLUE}Application${NC}"
echo "  ┌─ Local:         http://localhost:3000"
echo "  ├─ Proxy:         http://slovor.lndo.site"
echo "  ├─ API:           http://localhost:3000/api"
echo "  └─ API (Proxy):   http://slovor-api.lndo.site/api"
echo ""

echo -e "${BLUE}Database${NC}"
echo "  ┌─ PostgreSQL:     localhost:5432"
echo "  ├─ User:          postgres"
echo "  ├─ Password:      postgres"
echo "  └─ Database:      slovor"
echo ""

echo -e "${BLUE}External Services${NC}"
echo "  ┌─ Supabase:       https://rsywmmnxkvwvhgrgzlei.supabase.co"
echo "  ├─ GitHub:        https://github.com/Den3112/slovor"
echo "  └─ Docs:          https://github.com/Den3112/slovor/tree/main/docs"
echo ""

echo -e "${BLUE}Development Tools${NC}"
echo "  ┌─ Lando Info:     lando info"
echo "  ├─ Logs:          lando logs -f"
echo "  ├─ Shell:         lando ssh"
echo "  └─ Database:      lando psql"
echo ""

echo -e "${GREEN}✓${NC} All services running"
echo ""
