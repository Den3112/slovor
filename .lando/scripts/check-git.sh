#!/bin/bash
set -e

echo "🔍 Checking Git configuration..."

# Check Git installation
if ! command -v git &> /dev/null; then
    echo "❌ Git is not installed"
    exit 1
fi

echo "✓ Git installed: $(git --version)"

# Check basic settings
git_user=$(git config user.name || echo "")
git_email=$(git config user.email || echo "")

if [ -z "$git_user" ] || [ -z "$git_email" ]; then
    echo "⚠️ Git user.name or user.email not configured"
    echo "   Run: git config --global user.name 'Your Name'"
    echo "   Run: git config --global user.email 'your@email.com'"
else
    echo "✓ Git configured: $git_user <$git_email>"
fi

# Check if in git repository
if git rev-parse --git-dir > /dev/null 2>&1; then
    echo "✓ Inside Git repository"
    current_branch=$(git branch --show-current)
    echo "✓ Current branch: $current_branch"
else
    echo "⚠️ Not in a Git repository"
fi

echo "✅ Git check completed"
