#!/usr/bin/env bash

# One-time setup script - sets executable permissions on all scripts
# Run this once after git clone: bash scripts/setup.sh

set -e

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m'

echo ""
echo -e "${CYAN}Setting up executable permissions...${NC}"
echo ""

# Make all scripts executable
chmod +x scripts/*.sh

echo -e "${GREEN}✓${NC} All scripts are now executable"
echo ""
echo -e "${YELLOW}You can now run:${NC}"
echo -e "  ${CYAN}lando start${NC}"
echo ""
