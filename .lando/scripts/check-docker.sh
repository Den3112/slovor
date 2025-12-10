#!/bin/bash
set -e

echo "🔍 Checking Docker health..."

# Check Docker installation
if ! command -v docker &> /dev/null; then
    echo "❌ Docker is not installed"
    exit 1
fi

echo "✓ Docker installed: $(docker --version)"

# Check Docker daemon
if ! docker info &> /dev/null; then
    echo "❌ Docker daemon is not running"
    exit 1
fi

echo "✓ Docker daemon is running"

# Check running containers
running=$(docker ps -q | wc -l)
echo "✓ Running containers: $running"

# Check Docker resources
echo "📊 Docker disk usage:"
docker system df 2>/dev/null || echo "  (Unable to get disk usage)"

# Check Docker Compose
if command -v docker-compose &> /dev/null; then
    echo "✓ Docker Compose: $(docker-compose --version)"
elif docker compose version &> /dev/null; then
    echo "✓ Docker Compose: $(docker compose version)"
else
    echo "⚠️ Docker Compose not found"
fi

echo "✅ Docker check completed"
