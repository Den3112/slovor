#!/usr/bin/env bash

# Pre-start check - ensures Docker is ready
# Silent on success, reports errors clearly

set -e

RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

if ! docker info &> /dev/null 2>&1; then
    echo -e "${YELLOW}⚠${NC} Docker not running, starting..." >&2
    
    if command -v systemctl &> /dev/null; then
        sudo systemctl start docker 2>/dev/null || true
    elif command -v service &> /dev/null; then
        sudo service docker start 2>/dev/null || true
    fi
    
    sleep 2
    
    if ! docker info &> /dev/null 2>&1; then
        echo -e "${RED}✗${NC} Failed to start Docker" >&2
        echo "  → Run: sudo service docker start" >&2
        exit 1
    fi
fi

exit 0
