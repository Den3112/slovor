#!/usr/bin/env bash

# Quick health check - lint + typecheck
# Only outputs errors/warnings

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

cd slovor

echo "Running health check..."

# ESLint
if npm run lint --silent 2>&1 | grep -q "error\|warning"; then
    echo -e "${YELLOW}⚠${NC} ESLint found issues"
    echo "  Fix: lando lint:fix"
else
    echo -e "${GREEN}✓${NC} ESLint passed"
fi

# TypeScript
if npx tsc --noEmit 2>&1 | grep -q "error"; then
    echo -e "${RED}✗${NC} TypeScript errors found"
    echo "  Review output above"
else
    echo -e "${GREEN}✓${NC} TypeScript passed"
fi
