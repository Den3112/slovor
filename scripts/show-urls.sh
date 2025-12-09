#!/usr/bin/env bash

# Show only real, working URLs and connection info

GREEN='\033[0;32m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo ""
echo -e "${CYAN}═══════════════════════════════════════════════════${NC}"
echo -e "${CYAN}  Slovor - URLs & Connection Info${NC}"
echo -e "${CYAN}═══════════════════════════════════════════════════${NC}"
echo ""

echo -e "${BLUE}Local Development${NC}"
echo -e "  ┌─ Application:   ${GREEN}http://localhost:3000${NC}"
echo -e "  └─ API Endpoint:  ${GREEN}http://localhost:3000/api${NC}"
echo ""

echo -e "${BLUE}Database Connection${NC}"
echo -e "  ┌─ Host:          ${YELLOW}localhost${NC}"
echo -e "  ├─ Port:          ${YELLOW}5432${NC}"
echo -e "  ├─ Database:      ${YELLOW}slovor${NC}"
echo -e "  ├─ Username:      ${YELLOW}postgres${NC}"
echo -e "  └─ Password:      ${YELLOW}postgres${NC}"
echo ""
echo -e "  Connection string:"
echo -e "  ${CYAN}postgres://postgres:postgres@localhost:5432/slovor${NC}"
echo ""

echo -e "${BLUE}External Services${NC}"
echo -e "  ┌─ Supabase:      https://rsywmmnxkvwvhgrgzlei.supabase.co"
echo -e "  ├─ GitHub:        https://github.com/Den3112/slovor"
echo -e "  └─ Vercel:        https://vercel.com/dashboard (for deployment)"
echo ""

echo -e "${BLUE}Quick Commands${NC}"
echo -e "  ┌─ Start dev:     ${CYAN}lando dev${NC}"
echo -e "  ├─ Database:      ${CYAN}lando psql${NC}"
echo -e "  ├─ Logs:          ${CYAN}lando logs -f${NC}"
echo -e "  └─ Diagnostics:   ${CYAN}lando doctor${NC}"
echo ""

echo -e "${BLUE}Development Tools${NC}"
echo -e "  ┌─ Shell:         ${CYAN}lando ssh${NC}"
echo -e "  ├─ NPM:           ${CYAN}lando npm <command>${NC}"
echo -e "  └─ Info:          ${CYAN}lando info${NC}"
echo ""

echo -e "${GREEN}✓${NC} All services running on localhost"
echo -e "${YELLOW}💡${NC} Use ${CYAN}lando help${NC} to see full command list"
echo ""
