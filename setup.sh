#!/bin/bash

# Slovor Project Setup Script
# Run this once after cloning the repository

set -e

echo "=========================================="
echo "  Slovor Project Setup"
echo "=========================================="
echo ""

# Check if Lando is running
echo "Checking Lando status..."
if ! lando info > /dev/null 2>&1; then
    echo "Starting Lando..."
    lando start
fi

# Pull latest changes
echo ""
echo "Pulling latest changes from GitHub..."
cd slovor
git pull origin main || echo "[WARNING] Git pull failed, continuing..."

# Install dependencies
echo ""
echo "Installing dependencies..."
lando ssh -c "cd slovor && rm -rf node_modules package-lock.json && npm install --no-optional --legacy-peer-deps"

# Run checks
echo ""
echo "Running quality checks..."
lando ssh -c "cd slovor && npm run check" || echo "[WARNING] Some checks failed!"

echo ""
echo "=========================================="
echo "  Setup complete! Ready to develop."
echo "=========================================="
echo ""
echo "Quick start:"
echo "  - Run 'make dev' to start development server"
echo "  - Run 'make check' to run quality checks"
echo "  - Run 'make ssh' to open Lando terminal"
echo ""
