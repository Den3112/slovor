#!/usr/bin/env bash

# Lando Doctor - Comprehensive system health check
# Usage: lando doctor

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

errors=0
warnings=0

print_status() {
    if [ $2 -eq 0 ]; then
        echo -e "${GREEN}✅${NC} $1"
    else
        echo -e "${RED}❌${NC} $1"
        ((errors++))
    fi
}

print_warning() {
    echo -e "${YELLOW}⚠️${NC} $1"
    ((warnings++))
}

echo ""
echo "═══════════════════════════════════════════════════"
echo "🏥 Lando Doctor - System Health Check"
echo "═══════════════════════════════════════════════════"
echo ""

echo "📋 System Information"
echo "───────────────────────────────────────────────────"

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    if grep -qi microsoft /proc/version; then
        echo "OS: WSL2 ($(lsb_release -ds 2>/dev/null || echo 'Linux'))"
        IS_WSL=true
    else
        echo "OS: Linux ($(lsb_release -ds 2>/dev/null || echo 'Unknown'))"
        IS_WSL=false
    fi
else
    echo "OS: $OSTYPE"
    IS_WSL=false
fi

echo ""
echo "🔧 Core Tools"
echo "───────────────────────────────────────────────────"

if command -v lando &> /dev/null; then
    LANDO_VERSION=$(lando version 2>/dev/null | head -n1 || echo "unknown")
    print_status "Lando: $LANDO_VERSION" 0
else
    print_status "Lando: Not installed" 1
fi

if command -v docker &> /dev/null; then
    if docker info &> /dev/null; then
        DOCKER_VERSION=$(docker --version | grep -oP '[0-9]+\.[0-9]+\.[0-9]+' || echo "unknown")
        print_status "Docker: v$DOCKER_VERSION (running)" 0
    else
        print_warning "Docker: Installed but not running"
        echo "   Run: sudo service docker start"
    fi
else
    print_status "Docker: Not installed" 1
fi

if command -v node &> /dev/null; then
    NODE_VERSION=$(node --version | sed 's/v//')
    print_status "Node.js: v$NODE_VERSION" 0
else
    print_warning "Node.js: Not in PATH (using container version)"
fi

if command -v git &> /dev/null; then
    GIT_VERSION=$(git --version | grep -oP '[0-9]+\.[0-9]+\.[0-9]+' || echo "unknown")
    print_status "Git: v$GIT_VERSION" 0
else
    print_status "Git: Not installed" 1
fi

echo ""
echo "📦 Project Status"
echo "───────────────────────────────────────────────────"

if [ -f ".lando.yml" ]; then
    print_status "Lando config: Found" 0
else
    print_status "Lando config: Not found" 1
fi

if [ -d "slovor" ]; then
    print_status "App directory: Found" 0
    
    if [ -f "slovor/package.json" ]; then
        print_status "package.json: Found" 0
    else
        print_status "package.json: Not found" 1
    fi
    
    if [ -d "slovor/node_modules" ]; then
        print_status "node_modules: Installed" 0
    else
        print_warning "node_modules: Not installed (run: lando npm install)"
    fi
else
    print_status "App directory: Not found" 1
fi

echo ""
echo "🐳 Lando Containers"
echo "───────────────────────────────────────────────────"

if command -v lando &> /dev/null && [ -f ".lando.yml" ]; then
    if lando info &> /dev/null; then
        print_status "Lando: Running" 0
        
        if lando info | grep -q "appserver"; then
            print_status "Service (appserver): Healthy" 0
        else
            print_status "Service (appserver): Not found" 1
        fi
        
        if lando info | grep -q "database"; then
            print_status "Service (database): Healthy" 0
        else
            print_status "Service (database): Not found" 1
        fi
    else
        print_warning "Lando: Not started (run: lando start)"
    fi
fi

if [ "$IS_WSL" = true ]; then
    echo ""
    echo "🔍 WSL2 Specific"
    echo "───────────────────────────────────────────────────"
    
    WSLCONFIG="/mnt/c/Users/$USER/.wslconfig"
    if [ -f "$WSLCONFIG" ]; then
        print_status ".wslconfig: Found" 0
    else
        print_warning ".wslconfig: Not found (using defaults)"
    fi
fi

echo ""
echo "═══════════════════════════════════════════════════"
echo "📊 Summary"
echo "═══════════════════════════════════════════════════"

if [ $errors -eq 0 ] && [ $warnings -eq 0 ]; then
    echo -e "${GREEN}✅ All checks passed! System is healthy.${NC}"
    exit 0
elif [ $errors -eq 0 ]; then
    echo -e "${YELLOW}⚠️  $warnings warning(s) found.${NC}"
    echo "   System functional but optimizations recommended."
    exit 0
else
    echo -e "${RED}❌ $errors error(s) and $warnings warning(s) found.${NC}"
    echo ""
    echo "🔧 Quick fixes:"
    echo "   1. Install missing tools: bash scripts/wsl2-setup.sh"
    echo "   2. Start Docker: sudo service docker start"
    echo "   3. Start Lando: lando start"
    echo ""
    exit 1
fi