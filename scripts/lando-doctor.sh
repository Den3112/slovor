#!/usr/bin/env bash

# Full system diagnostics with smart suggestions

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
MAGENTA='\033[0;35m'
NC='\033[0m'

echo ""
echo -e "${CYAN}╔═══════════════════════════════════════════════╗${NC}"
echo -e "${CYAN}║${NC}  ${BLUE}Slovor System Diagnostics${NC}                 ${CYAN}║${NC}"
echo -e "${CYAN}╚═══════════════════════════════════════════════╝${NC}"
echo ""

ISSUES=0
SUGGESTIONS=()

# 1. Check directory structure
echo -e "${BLUE}[1/7]${NC} Checking directory structure..."
if [ -d "/app/slovor" ]; then
    echo -e "  ${GREEN}✓${NC} slovor/ directory exists"
else
    echo -e "  ${RED}✗${NC} slovor/ directory missing"
    SUGGESTIONS+=("Run: lando setup-repair")
    ((ISSUES++))
fi

if [ -d "/app/scripts" ]; then
    echo -e "  ${GREEN}✓${NC} scripts/ directory exists"
else
    echo -e "  ${YELLOW}⚠${NC} scripts/ directory missing"
fi

if [ -d "/app/docs" ]; then
    echo -e "  ${GREEN}✓${NC} docs/ directory exists"
else
    echo -e "  ${YELLOW}⚠${NC} docs/ directory missing"
fi

echo ""

# 2. Check Node.js
echo -e "${BLUE}[2/7]${NC} Checking Node.js..."
if command -v node &> /dev/null; then
    NODE_VERSION=$(node --version)
    echo -e "  ${GREEN}✓${NC} Node.js: $NODE_VERSION"
else
    echo -e "  ${RED}✗${NC} Node.js not found"
    SUGGESTIONS+=("Run: lando rebuild -y")
    ((ISSUES++))
fi

if command -v npm &> /dev/null; then
    NPM_VERSION=$(npm --version)
    echo -e "  ${GREEN}✓${NC} npm: $NPM_VERSION"
else
    echo -e "  ${RED}✗${NC} npm not found"
    ((ISSUES++))
fi

echo ""

# 3. Check package.json and dependencies
echo -e "${BLUE}[3/7]${NC} Checking dependencies..."
if [ -f "/app/slovor/package.json" ]; then
    echo -e "  ${GREEN}✓${NC} package.json exists"
    
    if [ -d "/app/slovor/node_modules" ]; then
        echo -e "  ${GREEN}✓${NC} node_modules installed"
    else
        echo -e "  ${YELLOW}⚠${NC} node_modules missing"
        SUGGESTIONS+=("Run: lando npm install")
    fi
else
    echo -e "  ${YELLOW}⚠${NC} package.json not found"
fi

echo ""

# 4. Check database connection
echo -e "${BLUE}[4/7]${NC} Checking database..."
if command -v psql &> /dev/null; then
    if psql -h database -U postgres -d slovor -c "\\l" &> /dev/null; then
        echo -e "  ${GREEN}✓${NC} PostgreSQL connection successful"
        echo -e "  ${GREEN}✓${NC} Database 'slovor' exists"
    else
        echo -e "  ${RED}✗${NC} Cannot connect to database"
        SUGGESTIONS+=("Try: lando restart")
        SUGGESTIONS+=("Or: lando db-reset")
        ((ISSUES++))
    fi
else
    echo -e "  ${RED}✗${NC} psql not found"
    ((ISSUES++))
fi

echo ""

# 5. Check environment variables
echo -e "${BLUE}[5/7]${NC} Checking environment..."
if [ -n "$DATABASE_URL" ]; then
    echo -e "  ${GREEN}✓${NC} DATABASE_URL is set"
else
    echo -e "  ${RED}✗${NC} DATABASE_URL not set"
    ((ISSUES++))
fi

if [ -n "$NEXT_PUBLIC_SUPABASE_URL" ]; then
    echo -e "  ${GREEN}✓${NC} NEXT_PUBLIC_SUPABASE_URL is set"
else
    echo -e "  ${YELLOW}⚠${NC} NEXT_PUBLIC_SUPABASE_URL not set"
fi

if [ -n "$NODE_ENV" ]; then
    echo -e "  ${GREEN}✓${NC} NODE_ENV: $NODE_ENV"
else
    echo -e "  ${YELLOW}⚠${NC} NODE_ENV not set"
fi

echo ""

# 6. Check ports
echo -e "${BLUE}[6/7]${NC} Checking ports..."
if netstat -tuln 2>/dev/null | grep -q ":3000 "; then
    echo -e "  ${YELLOW}⚠${NC} Port 3000 is in use"
    SUGGESTIONS+=("Kill process: sudo lsof -ti:3000 | xargs kill -9")
else
    echo -e "  ${GREEN}✓${NC} Port 3000 is available"
fi

if netstat -tuln 2>/dev/null | grep -q ":5432 "; then
    echo -e "  ${GREEN}✓${NC} Port 5432 is in use (database)"
else
    echo -e "  ${YELLOW}⚠${NC} Port 5432 is not in use"
fi

echo ""

# 7. Check configuration files
echo -e "${BLUE}[7/7]${NC} Checking configuration files..."
if [ -f "/.lando.yml" ] || [ -f "/app/.lando.yml" ]; then
    echo -e "  ${GREEN}✓${NC} .lando.yml exists"
else
    echo -e "  ${RED}✗${NC} .lando.yml not found"
    ((ISSUES++))
fi

if [ -f "/app/slovor/next.config.js" ] || [ -f "/app/slovor/next.config.mjs" ]; then
    echo -e "  ${GREEN}✓${NC} Next.js config exists"
else
    echo -e "  ${YELLOW}⚠${NC} Next.js config not found"
fi

if [ -f "/app/slovor/tsconfig.json" ]; then
    echo -e "  ${GREEN}✓${NC} tsconfig.json exists"
else
    echo -e "  ${YELLOW}⚠${NC} tsconfig.json not found"
fi

echo ""
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"

if [ $ISSUES -eq 0 ]; then
    echo -e "${GREEN}✓ All checks passed!${NC}"
    echo ""
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${BLUE}Everything looks good! What's next?${NC}"
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
    echo -e "  ${MAGENTA}1${NC} - Start dev server (lando dev)"
    echo -e "  ${MAGENTA}2${NC} - View URLs (lando urls)"
    echo -e "  ${MAGENTA}3${NC} - Run tests (lando test)"
    echo -e "  ${MAGENTA}4${NC} - Exit"
    echo ""
    echo -e "${YELLOW}Enter choice [1-4] (or press Enter to skip):${NC} "
    read -r CHOICE
    
    case $CHOICE in
        1)
            echo ""
            echo -e "${GREEN}→${NC} Running: ${CYAN}lando dev${NC}"
            cd /app/slovor && npm run dev
            ;;
        2)
            echo ""
            bash /app/scripts/show-urls.sh
            ;;
        3)
            echo ""
            echo -e "${GREEN}→${NC} Running: ${CYAN}lando test${NC}"
            cd /app/slovor && npm run test
            ;;
        *)
            echo ""
            echo -e "${GREEN}✓${NC} All good! Happy coding! 🚀"
            ;;
    esac
else
    echo -e "${RED}✗ Found $ISSUES issue(s)${NC}"
    
    if [ ${#SUGGESTIONS[@]} -gt 0 ]; then
        echo ""
        echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
        echo -e "${YELLOW}💡 Suggested fixes:${NC}"
        echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
        echo ""
        for i in "${!SUGGESTIONS[@]}"; do
            echo -e "  ${MAGENTA}$((i+1))${NC}. ${SUGGESTIONS[$i]}"
        done
        echo ""
        echo -e "${YELLOW}Or try nuclear option:${NC} ${CYAN}lando rebuild -y${NC}"
    fi
fi

echo ""
