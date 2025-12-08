#!/bin/bash
# Automatic setup validation and repair script
# Run this after opening Dev Container

set -e

echo "🔍 Slovor Project Setup Checker"
echo "================================"
echo ""

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Counters
ERRORS=0
WARNINGS=0

# Function to print status
print_status() {
    if [ $1 -eq 0 ]; then
        echo -e "${GREEN}✅ $2${NC}"
    else
        echo -e "${RED}❌ $2${NC}"
        ((ERRORS++))
    fi
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
    ((WARNINGS++))
}

print_info() {
    echo -e "ℹ️  $1"
}

# Check Node.js
echo "📦 Checking Node.js..."
if command -v node &> /dev/null; then
    NODE_VERSION=$(node --version)
    print_status 0 "Node.js installed: $NODE_VERSION"
    
    # Check if version is 18+
    MAJOR_VERSION=$(echo $NODE_VERSION | cut -d'.' -f1 | sed 's/v//')
    if [ "$MAJOR_VERSION" -lt 18 ]; then
        print_warning "Node.js version should be 18+, you have $NODE_VERSION"
    fi
else
    print_status 1 "Node.js not found"
fi

# Check npm
echo "📦 Checking npm..."
if command -v npm &> /dev/null; then
    NPM_VERSION=$(npm --version)
    print_status 0 "npm installed: $NPM_VERSION"
else
    print_status 1 "npm not found"
fi

# Check Git
echo "🔧 Checking Git..."
if command -v git &> /dev/null; then
    GIT_VERSION=$(git --version)
    print_status 0 "Git installed: $GIT_VERSION"
else
    print_status 1 "Git not found"
fi

# Check GitHub CLI
echo "🔧 Checking GitHub CLI..."
if command -v gh &> /dev/null; then
    GH_VERSION=$(gh --version | head -n1)
    print_status 0 "GitHub CLI installed: $GH_VERSION"
else
    print_warning "GitHub CLI not found (optional but recommended)"
fi

# Check PostgreSQL client
echo "🗄️  Checking PostgreSQL client..."
if command -v psql &> /dev/null; then
    PSQL_VERSION=$(psql --version)
    print_status 0 "PostgreSQL client installed: $PSQL_VERSION"
else
    print_warning "PostgreSQL client not found (optional)"
fi

# Check if node_modules exists
echo "📚 Checking node_modules..."
if [ -d "node_modules" ]; then
    print_status 0 "node_modules directory exists"
else
    print_warning "node_modules not found - run 'npm install'"
fi

# Check package.json
echo "📄 Checking package.json..."
if [ -f "package.json" ]; then
    print_status 0 "package.json exists"
else
    print_status 1 "package.json not found"
fi

# Check .env.local
echo "🔐 Checking .env.local..."
if [ -f ".env.local" ]; then
    print_status 0 ".env.local exists"
    
    # Check required variables
    if grep -q "NEXT_PUBLIC_SUPABASE_URL" .env.local && \
       grep -q "NEXT_PUBLIC_SUPABASE_ANON_KEY" .env.local; then
        print_status 0 "Required Supabase variables present"
    else
        print_warning "Missing some Supabase variables in .env.local"
    fi
else
    print_warning ".env.local not found - copy from .env.example"
fi

# Check TypeScript
echo "🔷 Checking TypeScript..."
if [ -f "node_modules/.bin/tsc" ] || command -v tsc &> /dev/null; then
    print_status 0 "TypeScript available"
else
    print_warning "TypeScript not found - run 'npm install'"
fi

# Check ESLint
echo "🔍 Checking ESLint..."
if [ -f "node_modules/.bin/eslint" ]; then
    print_status 0 "ESLint available"
else
    print_warning "ESLint not found - run 'npm install'"
fi

# Check Supabase CLI
echo "🔧 Checking Supabase CLI..."
if command -v supabase &> /dev/null; then
    SUPABASE_VERSION=$(supabase --version)
    print_status 0 "Supabase CLI installed: $SUPABASE_VERSION"
else
    print_warning "Supabase CLI not found (will install via npm)"
fi

# Check Git configuration
echo "⚙️  Checking Git configuration..."
GIT_USER=$(git config user.name 2>/dev/null || echo "")
GIT_EMAIL=$(git config user.email 2>/dev/null || echo "")

if [ -n "$GIT_USER" ] && [ -n "$GIT_EMAIL" ]; then
    print_status 0 "Git user configured: $GIT_USER <$GIT_EMAIL>"
else
    print_warning "Git user not configured"
    print_info "Run: git config --global user.name \"Your Name\""
    print_info "Run: git config --global user.email \"your@email.com\""
fi

# Check if on correct branch
echo "🌿 Checking Git branch..."
CURRENT_BRANCH=$(git branch --show-current 2>/dev/null || echo "unknown")
if [ "$CURRENT_BRANCH" = "main" ]; then
    print_status 0 "On main branch"
else
    print_warning "Not on main branch (current: $CURRENT_BRANCH)"
fi

# Summary
echo ""
echo "================================"
echo "📊 Summary"
echo "================================"
echo "Errors: $ERRORS"
echo "Warnings: $WARNINGS"
echo ""

if [ $ERRORS -eq 0 ]; then
    echo -e "${GREEN}✅ Setup looks good!${NC}"
    echo ""
    echo "🚀 You can start development with:"
    echo "   npm install    # Install dependencies"
    echo "   npm run dev    # Start dev server"
    echo ""
    echo "🤖 Or start AI automation:"
    echo "   In Killo Code (Grok): start phase 1"
    exit 0
else
    echo -e "${RED}❌ Found $ERRORS critical issues${NC}"
    echo ""
    echo "🔧 Run auto-repair:"
    echo "   bash scripts/setup-repair.sh"
    exit 1
fi