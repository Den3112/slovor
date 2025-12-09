#!/usr/bin/env bash

# Quick health check - lint and typecheck
# Safe version that checks for file existence first

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo "Running health check..."
echo ""

# Check if we're in the right directory
if [ ! -d "/app/slovor" ]; then
    echo -e "${RED}✗${NC} slovor/ directory not found"
    exit 1
fi

cd /app/slovor

# Check if package.json exists
if [ ! -f "package.json" ]; then
    echo -e "${YELLOW}⚠${NC} package.json not found - skipping checks"
    exit 0
fi

# Check if node_modules exists
if [ ! -d "node_modules" ]; then
    echo -e "${YELLOW}⚠${NC} node_modules not found - run: lando npm install"
    exit 0
fi

# Check if lint script exists in package.json
if grep -q '"lint"' package.json 2>/dev/null; then
    echo "Checking ESLint..."
    if npm run lint --silent 2>/dev/null; then
        echo -e "${GREEN}✓${NC} ESLint passed"
    else
        echo -e "${RED}✗${NC} ESLint failed"
        echo "  Run: lando lint:fix"
    fi
else
    echo -e "${YELLOW}⚠${NC} ESLint not configured"
fi

echo ""

# Check if TypeScript config exists
if [ -f "tsconfig.json" ]; then
    echo "Checking TypeScript..."
    if npx tsc --noEmit --pretty false 2>/dev/null; then
        echo -e "${GREEN}✓${NC} TypeScript check passed"
    else
        echo -e "${RED}✗${NC} TypeScript check failed"
        echo "  Run: lando tsc"
    fi
else
    echo -e "${YELLOW}⚠${NC} TypeScript not configured"
fi

echo ""
echo -e "${GREEN}Health check complete${NC}"
