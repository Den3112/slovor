#!/bin/bash
set -e

echo "🚀 Setting up Slovor with Lando..."
echo ""

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check Lando installation
echo "Checking prerequisites..."
if ! command -v lando &> /dev/null; then
    echo -e "${RED}❌ Lando is not installed${NC}"
    echo ""
    echo "Install Lando from: https://docs.lando.dev/getting-started/installation.html"
    echo ""
    echo "For Windows with WSL2:"
    echo "  1. Install Docker Desktop for Windows"
    echo "  2. Download Lando installer from the link above"
    echo "  3. Run the installer"
    exit 1
fi
echo -e "${GREEN}✓${NC} Lando installed: $(lando version)"

# Check Docker
if ! docker info &> /dev/null; then
    echo -e "${RED}❌ Docker is not running${NC}"
    echo ""
    echo "Please start Docker Desktop and try again"
    exit 1
fi
echo -e "${GREEN}✓${NC} Docker is running"

# Check if already in Lando project
if [ -f ".lando.yml" ]; then
    echo -e "${GREEN}✓${NC} Found .lando.yml configuration"
else
    echo -e "${RED}❌ .lando.yml not found in current directory${NC}"
    echo "Please run this script from the project root"
    exit 1
fi

# Make scripts executable
if [ -d ".lando/scripts" ]; then
    chmod +x .lando/scripts/*.sh
    echo -e "${GREEN}✓${NC} Made health check scripts executable"
fi

# Check for .env files
echo ""
echo "Checking environment configuration..."
if [ ! -f ".env" ] && [ ! -f ".env.local" ]; then
    echo -e "${YELLOW}⚠️  No .env file found${NC}"
    
    if [ -f ".env.example" ]; then
        echo ""
        read -p "Do you want to create .env from .env.example? (y/n) " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            cp .env.example .env
            echo -e "${GREEN}✓${NC} Created .env from .env.example"
            echo ""
            echo -e "${YELLOW}⚠️  Please edit .env and add your credentials:${NC}"
            echo "   - NEXT_PUBLIC_SUPABASE_URL"
            echo "   - NEXT_PUBLIC_SUPABASE_ANON_KEY"
            echo "   - SUPABASE_SERVICE_ROLE_KEY"
            echo ""
            read -p "Press Enter when you've configured .env..."
        else
            echo ""
            echo -e "${YELLOW}Skipping .env creation. You'll need to create it manually.${NC}"
        fi
    fi
else
    echo -e "${GREEN}✓${NC} Environment file found"
fi

# Install pre-commit hooks if available
if command -v pre-commit &> /dev/null; then
    if [ -f ".pre-commit-config.yaml" ]; then
        echo ""
        echo "Installing pre-commit hooks..."
        pre-commit install
        echo -e "${GREEN}✓${NC} Pre-commit hooks installed"
    fi
else
    echo ""
    echo -e "${YELLOW}ℹ️  pre-commit not installed (optional)${NC}"
    echo "   Install with: pip install pre-commit"
fi

# Start Lando
echo ""
echo "🔨 Building Lando environment..."
echo "This may take a few minutes on first run..."
echo ""

lando start

if [ $? -eq 0 ]; then
    echo ""
    echo -e "${GREEN}✅ Slovor is ready!${NC}"
    echo ""
    echo "=================================================="
    echo "  Available commands:"
    echo "=================================================="
    echo "  lando dev        - Start Next.js development server"
    echo "  lando check-all  - Run all health checks"
    echo "  lando npm        - Run npm commands"
    echo "  lando psql       - Connect to database"
    echo "  lando logs       - View application logs"
    echo ""
    echo "  Access your site at: http://slovor.lndo.site"
    echo "  Email testing at:    http://mail.slovor.lndo.site"
    echo "=================================================="
    echo ""
    echo "Next steps:"
    echo "  1. Run: lando dev"
    echo "  2. Open: http://slovor.lndo.site"
    echo ""
else
    echo ""
    echo -e "${RED}❌ Failed to start Lando${NC}"
    echo "Check the error messages above"
    exit 1
fi
