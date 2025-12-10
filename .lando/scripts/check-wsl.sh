#!/bin/bash
set -e

echo "🔍 Checking WSL2 configuration..."

# Check if running in WSL
if [ ! -f /proc/version ]; then
    echo "ℹ️ Not running in WSL environment"
    exit 0
fi

wsl_info=$(cat /proc/version)
if echo "$wsl_info" | grep -qi "microsoft"; then
    echo "✓ Running in WSL"
    echo "  Info: $wsl_info"
else
    echo "ℹ️ Not a WSL environment"
    exit 0
fi

# Check WSL version (WSL2 has specific kernel)
if echo "$wsl_info" | grep -qi "WSL2\|microsoft.*5\."; then
    echo "✓ WSL2 detected"
else
    echo "⚠️ Might be WSL1 (WSL2 recommended for Docker)"
fi

# Check DNS configuration
if [ -f /etc/resolv.conf ]; then
    nameserver_count=$(grep -c "nameserver" /etc/resolv.conf || echo "0")
    echo "✓ DNS configured ($nameserver_count nameservers)"
fi

# Check Windows filesystem mount
if [ -d /mnt/c ]; then
    echo "✓ Windows C: drive mounted at /mnt/c"
fi

# Check if Docker Desktop integration is working
if command -v docker.exe &> /dev/null; then
    echo "✓ Docker Desktop integration available"
fi

echo "✅ WSL2 check completed"
