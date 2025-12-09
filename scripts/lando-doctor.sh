#!/usr/bin/env bash

# Lando Doctor - Comprehensive system diagnostics
# Outputs structured report with clear status indicators

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
BOLD='\033[1m'
NC='\033[0m'

errors=0
warnings=0

log_ok() { echo -e "  ${GREEN}✓${NC} $1"; }
log_err() { echo -e "  ${RED}✗${NC} $1"; ((errors++)); }
log_warn() { echo -e "  ${YELLOW}⚠${NC} $1"; ((warnings++)); }
log_info() { echo -e "  ${BLUE}ℹ${NC} $1"; }

echo ""
echo -e "${BOLD}Slovor System Diagnostics${NC}"
echo -e "$(date '+%Y-%m-%d %H:%M:%S')"
echo ""

# === System ===
echo -e "${BOLD}System${NC}"

if [[ "$OSTYPE" == "linux-gnu"* ]] && grep -qi microsoft /proc/version; then
    log_ok "WSL2 detected"
    IS_WSL=true
else
    log_info "Not running in WSL2"
    IS_WSL=false
fi

# === Tools ===
echo ""
echo -e "${BOLD}Tools${NC}"

if command -v lando &> /dev/null; then
    VERSION=$(lando version 2>/dev/null | head -n1 | grep -oP 'v\K[0-9.]+' || echo "unknown")
    log_ok "Lando v$VERSION"
else
    log_err "Lando not installed"
    log_info "Install: https://docs.lando.dev/install/"
fi

if command -v docker &> /dev/null; then
    if docker info &> /dev/null 2>&1; then
        VERSION=$(docker --version | grep -oP '[0-9]+\.[0-9]+\.[0-9]+' || echo "unknown")
        log_ok "Docker v$VERSION (running)"
    else
        log_warn "Docker installed but not running"
        log_info "Start: sudo service docker start"
    fi
else
    log_err "Docker not installed"
    log_info "Install: bash scripts/wsl2-setup.sh"
fi

if command -v git &> /dev/null; then
    VERSION=$(git --version | grep -oP '[0-9]+\.[0-9]+\.[0-9]+' || echo "unknown")
    log_ok "Git v$VERSION"
else
    log_err "Git not installed"
fi

# === Project ===
echo ""
echo -e "${BOLD}Project${NC}"

if [ -f ".lando.yml" ]; then
    log_ok "Lando configuration found"
else
    log_err "Lando configuration missing"
    log_info "Ensure you're in project root"
fi

if [ -d "slovor" ]; then
    log_ok "Application directory found"
    
    if [ -f "slovor/package.json" ]; then
        log_ok "package.json found"
    else
        log_err "package.json missing"
    fi
    
    if [ -d "slovor/node_modules" ]; then
        log_ok "Dependencies installed"
    else
        log_warn "Dependencies not installed"
        log_info "Run: lando npm install"
    fi
else
    log_err "Application directory missing"
    log_info "Expected: slovor/"
fi

# === Lando Services ===
if command -v lando &> /dev/null && [ -f ".lando.yml" ]; then
    echo ""
    echo -e "${BOLD}Services${NC}"
    
    if lando info &> /dev/null 2>&1; then
        log_ok "Lando services running"
        
        if lando info 2>/dev/null | grep -q "appserver"; then
            log_ok "appserver service healthy"
        else
            log_warn "appserver service not found"
        fi
        
        if lando info 2>/dev/null | grep -q "database"; then
            log_ok "database service healthy"
        else
            log_warn "database service not found"
        fi
    else
        log_warn "Lando services not running"
        log_info "Start: lando start"
    fi
fi

# === WSL2 Specific ===
if [ "$IS_WSL" = true ]; then
    echo ""
    echo -e "${BOLD}WSL2 Configuration${NC}"
    
    WSLCONFIG="/mnt/c/Users/$USER/.wslconfig"
    if [ -f "$WSLCONFIG" ]; then
        log_ok ".wslconfig found"
    else
        log_warn ".wslconfig not found"
        log_info "Copy: .wslconfig.example to C:\\Users\\$USER\\.wslconfig"
    fi
fi

# === Summary ===
echo ""
echo -e "${BOLD}Summary${NC}"

if [ $errors -eq 0 ] && [ $warnings -eq 0 ]; then
    echo -e "  ${GREEN}All systems operational${NC}"
    exit 0
elif [ $errors -eq 0 ]; then
    echo -e "  ${YELLOW}$warnings warning(s)${NC} - system functional"
    exit 0
else
    echo -e "  ${RED}$errors error(s)${NC}, ${YELLOW}$warnings warning(s)${NC}"
    echo ""
    echo -e "${BOLD}Recommended Actions${NC}"
    echo "  1. Review errors above"
    echo "  2. Run: lando setup-repair"
    echo "  3. Check: docs/WSL2_SETUP.md"
    exit 1
fi
