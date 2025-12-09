#!/usr/bin/env bash

# Pre-start checks - ensures Docker is running

set -e

echo "🔍 Pre-start checks..."

if ! docker info &> /dev/null; then
    echo "⚠️  Docker not running, attempting to start..."
    
    if command -v systemctl &> /dev/null; then
        sudo systemctl start docker 2>/dev/null || true
    elif command -v service &> /dev/null; then
        sudo service docker start 2>/dev/null || true
    fi
    
    sleep 2
    
    if ! docker info &> /dev/null; then
        echo "❌ Docker failed to start"
        echo "   Run: sudo service docker start"
        exit 1
    fi
fi

echo "✅ Docker running"
exit 0