#!/usr/bin/env bash

# Setup validation script
# Silent on success, reports issues with recommendations

set -e

RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

issues=0

check_fail() {
    echo -e "${RED}✗${NC} $1" >&2
    echo "  → $2" >&2
    ((issues++))
}

check_warn() {
    echo -e "${YELLOW}⚠${NC} $1" >&2
    echo "  → $2" >&2
}

# Check Node.js
if ! command -v node &> /dev/null; then
    check_fail "Node.js not found in PATH" "Using container version (OK)"
fi

# Check npm
if ! command -v npm &> /dev/null; then
    check_fail "npm not found in PATH" "Using container version (OK)"
fi

# Check project structure
if [ ! -d "slovor" ]; then
    check_fail "Application directory missing" "Expected: slovor/"
fi

if [ ! -f "slovor/package.json" ]; then
    check_fail "package.json not found" "Initialize: cd slovor && npm init"
fi

# Check dependencies
if [ -f "slovor/package.json" ] && [ ! -d "slovor/node_modules" ]; then
    check_warn "Dependencies not installed" "Run: lando npm install"
    ((issues++))
fi

# Check environment
if [ -f "slovor/.env.example" ] && [ ! -f "slovor/.env.local" ]; then
    check_warn "Environment file missing" "Copy: .env.example → .env.local"
    ((issues++))
fi

# Exit with appropriate code
if [ $issues -eq 0 ]; then
    exit 0
else
    exit 1
fi
