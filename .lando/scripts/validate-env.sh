#!/bin/bash
set -e

echo "🔍 Validating environment variables for Slovor..."

# Required environment variables for Slovor
REQUIRED_VARS=(
    "NEXT_PUBLIC_SUPABASE_URL"
    "NEXT_PUBLIC_SUPABASE_ANON_KEY"
    "SUPABASE_SERVICE_ROLE_KEY"
)

# Optional but recommended variables
OPTIONAL_VARS=(
    "DATABASE_URL"
    "NEXT_TELEMETRY_DISABLED"
)

# Check for .env files
ENV_FILES=(".env" ".env.local" ".env.development")
FOUND_ENV=false

for file in "${ENV_FILES[@]}"; do
    if [ -f "$file" ]; then
        echo "✓ Found: $file"
        FOUND_ENV=true
        # Source the file to load variables
        set -a
        source "$file" 2>/dev/null || true
        set +a
    fi
done

if [ "$FOUND_ENV" = false ]; then
    echo "⚠️  No .env files found"
    
    # Create .env.example if it doesn't exist
    if [ ! -f ".env.example" ]; then
        echo "📝 Creating .env.example..."
        cat > .env.example << 'EOF'
# Supabase Configuration
NEXT_PUBLIC_SUPABASE_URL=https://your-project.supabase.co
NEXT_PUBLIC_SUPABASE_ANON_KEY=your-anon-key-here
SUPABASE_SERVICE_ROLE_KEY=your-service-role-key-here

# Database (for local development)
DATABASE_URL=postgresql://slovor:slovor@database:5432/slovor_db

# Optional
NEXT_TELEMETRY_DISABLED=1
EOF
        echo "✓ Created .env.example"
    fi
    
    echo ""
    echo "📋 To get started:"
    echo "   1. Copy .env.example to .env"
    echo "   2. Fill in your Supabase credentials"
    echo "   3. Run: lando restart"
    echo ""
    exit 0
fi

# Check required variables
MISSING_VARS=()
for var in "${REQUIRED_VARS[@]}"; do
    if [ -z "${!var}" ]; then
        MISSING_VARS+=("$var")
    else
        # Show first 15 characters for security
        VALUE="${!var}"
        if [ ${#VALUE} -gt 15 ]; then
            MASKED="${VALUE:0:15}..."
        else
            MASKED="${VALUE:0:5}..."
        fi
        echo "✓ $var: $MASKED"
    fi
done

if [ ${#MISSING_VARS[@]} -gt 0 ]; then
    echo ""
    echo "❌ Missing required environment variables:"
    printf '  - %s\n' "${MISSING_VARS[@]}"
    echo ""
    echo "Please add these to your .env file"
    exit 1
fi

# Check optional variables
for var in "${OPTIONAL_VARS[@]}"; do
    if [ -z "${!var}" ]; then
        echo "ℹ️  Optional variable not set: $var"
    else
        VALUE="${!var}"
        if [ ${#VALUE} -gt 15 ]; then
            MASKED="${VALUE:0:15}..."
        else
            MASKED="$VALUE"
        fi
        echo "✓ $var: $MASKED"
    fi
done

# Validate Supabase URL format
if [[ ! "$NEXT_PUBLIC_SUPABASE_URL" =~ ^https?:// ]]; then
    echo "❌ NEXT_PUBLIC_SUPABASE_URL must be a valid URL starting with http:// or https://"
    exit 1
fi

echo ""
echo "✅ Environment variables validated successfully"
