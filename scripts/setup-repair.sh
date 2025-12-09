#!/usr/bin/env bash

# Auto-repair script
# Fixes common setup issues with progress reporting

set -e

GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

repaired=0

repair() {
    echo -e "${BLUE}⟳${NC} $1..."
    ((repaired++))
}

repair_ok() {
    echo -e "${GREEN}✓${NC} $1"
}

echo -e "${BLUE}Auto-repair starting...${NC}"
echo ""

# Create app directory if missing
if [ ! -d "slovor" ]; then
    repair "Creating application directory"
    mkdir -p slovor
    repair_ok "Created slovor/"
fi

# Install dependencies if missing
if [ -f "slovor/package.json" ] && [ ! -d "slovor/node_modules" ]; then
    repair "Installing dependencies"
    cd slovor
    npm install --silent --legacy-peer-deps || npm install --silent --force
    cd ..
    repair_ok "Dependencies installed"
fi

# Create .env.local if missing
if [ -f "slovor/.env.example" ] && [ ! -f "slovor/.env.local" ]; then
    repair "Creating environment file"
    cp slovor/.env.example slovor/.env.local
    repair_ok "Created .env.local from template"
    echo -e "${YELLOW}⚠${NC} Update .env.local with your credentials"
fi

# Create necessary directories
for dir in "slovor/src" "slovor/public" "slovor/supabase"; do
    if [ ! -d "$dir" ]; then
        repair "Creating $dir"
        mkdir -p "$dir"
        repair_ok "Created $dir"
    fi
done

echo ""
if [ $repaired -eq 0 ]; then
    echo -e "${GREEN}✓${NC} No repairs needed"
else
    echo -e "${GREEN}✓${NC} Completed $repaired repair(s)"
fi
