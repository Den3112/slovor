#!/usr/bin/env bash

# Auto-repair script
# Fixes common setup issues with progress reporting

# DON'T exit on errors - we want to continue even if something fails
set +e

GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

repaired=0
failed=0

repair() {
    echo -e "${BLUE}⟳${NC} $1..."
    ((repaired++))
}

repair_ok() {
    echo -e "${GREEN}✓${NC} $1"
}

repair_fail() {
    echo -e "${RED}✗${NC} $1"
    ((failed++))
}

echo -e "${BLUE}Auto-repair starting...${NC}"
echo ""

# Create app directory if missing
if [ ! -d "slovor" ]; then
    repair "Creating application directory"
    if mkdir -p slovor; then
        repair_ok "Created slovor/"
    else
        repair_fail "Failed to create slovor/"
    fi
fi

# Install dependencies if missing
if [ -f "slovor/package.json" ] && [ ! -d "slovor/node_modules" ]; then
    repair "Installing dependencies"
    cd slovor
    if npm install --silent --legacy-peer-deps 2>/dev/null || npm install --silent --force 2>/dev/null; then
        cd ..
        repair_ok "Dependencies installed"
    else
        cd ..
        repair_fail "Failed to install dependencies"
    fi
fi

# Create .env.local if missing
if [ -f "slovor/.env.example" ] && [ ! -f "slovor/.env.local" ]; then
    repair "Creating environment file"
    if cp slovor/.env.example slovor/.env.local; then
        repair_ok "Created .env.local from template"
        echo -e "${YELLOW}⚠${NC} Update .env.local with your credentials"
    else
        repair_fail "Failed to create .env.local"
    fi
fi

# Create necessary directories
for dir in "slovor/src" "slovor/public" "slovor/supabase"; do
    if [ ! -d "$dir" ]; then
        repair "Creating $dir"
        if mkdir -p "$dir"; then
            repair_ok "Created $dir"
        else
            repair_fail "Failed to create $dir"
        fi
    fi
done

echo ""
if [ $failed -gt 0 ]; then
    echo -e "${RED}✗${NC} Completed with $failed error(s)"
    exit 1
elif [ $repaired -eq 0 ]; then
    echo -e "${GREEN}✓${NC} No repairs needed"
    exit 0
else
    echo -e "${GREEN}✓${NC} Completed $repaired repair(s)"
    exit 0
fi
