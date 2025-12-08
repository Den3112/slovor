#!/bin/bash
# Automatic setup repair script
# Fixes common issues automatically

set -e

echo "🔧 Slovor Project Auto-Repair"
echo "=============================="
echo ""

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

print_step() {
    echo -e "${YELLOW}➜${NC} $1"
}

print_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

# Install Node.js dependencies
print_step "Installing npm dependencies..."
if [ -f "package.json" ]; then
    npm install
    print_success "Dependencies installed"
else
    print_error "package.json not found!"
    exit 1
fi

# Create .env.local if missing
print_step "Checking .env.local..."
if [ ! -f ".env.local" ]; then
    if [ -f ".env.example" ]; then
        cp .env.example .env.local
        print_success "Created .env.local from .env.example"
        echo ""
        echo -e "${YELLOW}⚠️  IMPORTANT: Edit .env.local with your actual credentials!${NC}"
        echo ""
    else
        print_error ".env.example not found!"
    fi
else
    print_success ".env.local already exists"
fi

# Install global tools if missing
print_step "Checking global tools..."

if ! command -v supabase &> /dev/null; then
    print_step "Installing Supabase CLI globally..."
    npm install -g supabase
    print_success "Supabase CLI installed"
fi

if ! command -v typescript &> /dev/null && ! command -v tsc &> /dev/null; then
    print_step "Installing TypeScript globally..."
    npm install -g typescript
    print_success "TypeScript installed"
fi

# Setup Git hooks with Husky
print_step "Setting up Git hooks..."
if [ -f "package.json" ] && grep -q '"prepare"' package.json; then
    npm run prepare 2>/dev/null || true
    print_success "Git hooks configured"
fi

# Create necessary directories
print_step "Creating project directories..."
mkdir -p .next
mkdir -p public
mkdir -p src/app
mkdir -p src/components
mkdir -p src/lib
mkdir -p supabase/migrations
print_success "Directories created"

# Check database connection
print_step "Checking database connection..."
if [ -f ".env.local" ]; then
    # Source env file
    set -a
    source .env.local 2>/dev/null || true
    set +a
    
    if [ -n "$DATABASE_URL" ]; then
        print_success "Database URL configured"
    else
        print_error "DATABASE_URL not set in .env.local"
    fi
fi

# Verify installation
echo ""
print_step "Verifying installation..."
echo ""

if command -v node &> /dev/null; then
    echo "Node.js: $(node --version)"
fi

if command -v npm &> /dev/null; then
    echo "npm: $(npm --version)"
fi

if command -v tsc &> /dev/null || [ -f "node_modules/.bin/tsc" ]; then
    echo "TypeScript: ✅"
fi

if [ -d "node_modules" ]; then
    PACKAGE_COUNT=$(ls -1 node_modules | wc -l)
    echo "Packages installed: $PACKAGE_COUNT"
fi

echo ""
print_success "Auto-repair completed!"
echo ""
echo "🚀 Next steps:"
echo "   1. Edit .env.local with your credentials"
echo "   2. Run: npm run dev"
echo "   3. Or start AI: 'start phase 1' in Killo Code"
echo ""