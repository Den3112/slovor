#!/bin/bash
set -e

echo "🔍 Checking database connection for Slovor..."

# Check PostgreSQL client
if ! command -v psql &> /dev/null; then
    echo "❌ psql client is not installed"
    exit 1
fi

echo "✓ PostgreSQL client available"

# Check if database service is ready
if ! pg_isready -h database -U slovor &> /dev/null; then
    echo "⚠️  PostgreSQL service is not ready yet"
    echo "   This is normal during first start, it will be ready soon"
    exit 0
fi
echo "✓ PostgreSQL service is ready"

# Check database connection
if psql -h database -U slovor -d slovor_db -c "SELECT 1;" &> /dev/null; then
    echo "✓ Database connection successful"
else
    echo "⚠️  Cannot connect to database (it might still be initializing)"
    exit 0
fi

# Get table count
TABLE_COUNT=$(psql -h database -U slovor -d slovor_db -t -c "SELECT COUNT(*) FROM information_schema.tables WHERE table_schema = 'public';" 2>/dev/null | tr -d ' ' || echo "0")
echo "✓ Tables in database: $TABLE_COUNT"

# Get database size
DB_SIZE=$(psql -h database -U slovor -d slovor_db -t -c "SELECT pg_size_pretty(pg_database_size('slovor_db'));" 2>/dev/null | tr -d ' ' || echo "unknown")
echo "✓ Database size: $DB_SIZE"

echo "✅ Database check completed"
