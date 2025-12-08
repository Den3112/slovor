#!/bin/bash
# Post-create script that runs automatically after Dev Container is created

echo "🚀 Running post-create setup..."
echo ""

# Make scripts executable
chmod +x scripts/*.sh 2>/dev/null || true

# Run setup check
if [ -f "scripts/setup-check.sh" ]; then
    bash scripts/setup-check.sh
else
    echo "⚠️  Setup check script not found"
fi

# Auto-repair if needed
if [ $? -ne 0 ]; then
    echo ""
    echo "🔧 Running auto-repair..."
    if [ -f "scripts/setup-repair.sh" ]; then
        bash scripts/setup-repair.sh
    fi
fi

echo ""
echo "✅ Dev Container ready!"
echo ""
echo "📚 Quick commands:"
echo "   npm run dev          - Start development server"
echo "   npm run lint         - Run linting"
echo "   npm run test         - Run tests"
echo "   bash scripts/setup-check.sh - Validate setup"
echo ""
echo "🤖 AI Commands (Killo Code):"
echo "   start phase 1        - Begin Phase 1 development"
echo "   status               - Check progress"
echo "   continue             - Resume work"
echo ""