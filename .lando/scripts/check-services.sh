#!/bin/bash
set -e

echo "🔍 Checking Slovor services..."

# Check if Next.js dev server is running
if curl -s -o /dev/null -w "%{http_code}" http://localhost:3000 2>/dev/null | grep -q "200\|404\|500"; then
    echo "✓ Next.js dev server is responding on port 3000"
else
    echo "ℹ️  Next.js dev server not running"
    echo "   Start it with: lando dev"
fi

# Check Lando proxy
if curl -s -o /dev/null -w "%{http_code}" http://slovor.lndo.site 2>/dev/null | grep -q "200\|404\|502"; then
    echo "✓ Lando proxy is configured"
    echo "   Access your site at: http://slovor.lndo.site"
else
    echo "⚠️  Lando proxy not responding (this is normal if services just started)"
fi

# Check mailhog
if curl -s -o /dev/null -w "%{http_code}" http://mail.slovor.lndo.site 2>/dev/null | grep -q "200"; then
    echo "✓ Mailhog available at: http://mail.slovor.lndo.site"
else
    echo "ℹ️  Mailhog not accessible yet"
fi

# Check critical ports
echo "📊 Port status:"
if command -v netstat &> /dev/null; then
    netstat -tuln 2>/dev/null | grep -E ":(3000|5432|8025)" || echo "  (No services detected on standard ports yet)"
elif command -v ss &> /dev/null; then
    ss -tuln 2>/dev/null | grep -E ":(3000|5432|8025)" || echo "  (No services detected on standard ports yet)"
else
    echo "  (Cannot check ports - netstat/ss not available)"
fi

echo "✅ Services check completed"
