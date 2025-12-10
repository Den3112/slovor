#!/bin/bash
set -e

echo "🔍 Checking Node.js environment for Slovor..."

# Check Node.js version
if ! command -v node &> /dev/null; then
    echo "❌ Node.js is not installed"
    exit 1
fi

NODE_VERSION=$(node --version)
REQUIRED_NODE="20"
CURRENT_NODE=$(echo $NODE_VERSION | cut -d'v' -f2 | cut -d'.' -f1)

if [ "$CURRENT_NODE" -lt "$REQUIRED_NODE" ]; then
    echo "❌ Node.js version too old: $NODE_VERSION (required: v${REQUIRED_NODE}.x)"
    exit 1
fi
echo "✓ Node.js: $NODE_VERSION"

# Check npm
if ! command -v npm &> /dev/null; then
    echo "❌ npm is not installed"
    exit 1
fi

NPM_VERSION=$(npm --version)
echo "✓ npm: v$NPM_VERSION"

# Check if node_modules exists
if [ ! -d "node_modules" ]; then
    echo "⚠️  node_modules not found"
    echo "   Run: lando npm install"
else
    echo "✓ node_modules directory exists"
    
    # Check critical packages
    PACKAGES=("next" "react" "typescript")
    for package in "${PACKAGES[@]}"; do
        if [ -d "node_modules/$package" ]; then
            echo "✓ $package installed"
        else
            echo "⚠️  $package not found in node_modules"
        fi
    done
fi

# Check TypeScript
if command -v tsc &> /dev/null; then
    TSC_VERSION=$(tsc --version 2>/dev/null || echo "unknown")
    echo "✓ TypeScript: $TSC_VERSION"
fi

# Check package.json
if [ -f "package.json" ]; then
    echo "✓ package.json found"
else
    echo "❌ package.json not found"
    exit 1
fi

echo "✅ Node.js environment check completed"
