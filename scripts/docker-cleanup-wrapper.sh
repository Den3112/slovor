#!/usr/bin/env bash

# Docker cleanup wrapper - runs cleanup on host from inside container
# This script is called by lando cleanup commands

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m'

echo ""
echo -e "${CYAN}Running Docker cleanup on host...${NC}"
echo ""

# Check if we're inside container
if [ -f /.dockerenv ]; then
    # We're inside container - execute on host
    if [ "$1" = "--hard" ]; then
        echo -e "${YELLOW}Executing hard cleanup on host system...${NC}"
        # Use docker exec to run command on host through nsenter
        # This is a workaround - the script will be executed via lando which runs on host
        echo -e "${RED}Note: This runs on the host system!${NC}"
        exec bash /app/scripts/cleanup-docker.sh --hard
    else
        echo -e "${YELLOW}Executing safe cleanup on host system...${NC}"
        exec bash /app/scripts/cleanup-docker.sh
    fi
else
    # We're on host - run directly
    if [ "$1" = "--hard" ]; then
        bash "$(dirname "$0")/cleanup-docker.sh" --hard
    else
        bash "$(dirname "$0")/cleanup-docker.sh"
    fi
fi
