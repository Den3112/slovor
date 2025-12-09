#!/usr/bin/env bash

# Lando update script - checks and updates Lando packages

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m'

echo ""
echo -e "${CYAN}╔═══════════════════════════════════════════════╗${NC}"
echo -e "${CYAN}║${NC}  ${BOLD}${BLUE}Lando Update${NC}                              ${CYAN}║${NC}"
echo -e "${CYAN}╚═══════════════════════════════════════════════╝${NC}"
echo ""

echo -e "${YELLOW}Checking for Lando updates...${NC}"
echo ""

# Check if lando command is available
if ! command -v lando &> /dev/null; then
    echo -e "${RED}✗ Lando not found!${NC}"
    echo -e "${YELLOW}Please install Lando first${NC}"
    exit 1
fi

# Run lando update
echo -e "${CYAN}Running lando update...${NC}"
echo ""

lando update

echo ""
echo -e "${GREEN}✓${NC} Update complete!"
echo ""
echo -e "${YELLOW}💡 Tips:${NC}"
echo -e "  - Updates fix bugs, security issues and bring new features"
echo -e "  - Run ${CYAN}lando update${NC} regularly to stay up to date"
echo -e "  - If you encounter issues after update, run ${CYAN}lando rebuild -y${NC}"
echo ""
