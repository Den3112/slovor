#!/usr/bin/env node
/**
 * Environment validation script
 * Checks all required environment variables
 */

const fs = require('fs');
const path = require('path');

const REQUIRED_VARS = [
  'NEXT_PUBLIC_SUPABASE_URL',
  'NEXT_PUBLIC_SUPABASE_ANON_KEY',
  'SUPABASE_SERVICE_ROLE_KEY',
];

const OPTIONAL_VARS = [
  'DATABASE_URL',
  'SENTRY_DSN',
  'VERCEL_TOKEN',
  'GITHUB_TOKEN',
];

const ENV_FILE = path.join(process.cwd(), '.env.local');

console.log('🔍 Validating environment variables...');
console.log('');

// Check if .env.local exists
if (!fs.existsSync(ENV_FILE)) {
  console.error('❌ .env.local not found!');
  console.error('');
  console.error('💡 Create it from .env.example:');
  console.error('   cp .env.example .env.local');
  process.exit(1);
}

// Read .env.local
const envContent = fs.readFileSync(ENV_FILE, 'utf8');
const envVars = {};

// Parse environment variables
envContent.split('\n').forEach((line) => {
  const trimmed = line.trim();
  if (trimmed && !trimmed.startsWith('#')) {
    const [key, ...valueParts] = trimmed.split('=');
    if (key && valueParts.length > 0) {
      envVars[key.trim()] = valueParts.join('=').trim();
    }
  }
});

let hasErrors = false;
let hasWarnings = false;

// Check required variables
console.log('📋 Required variables:');
REQUIRED_VARS.forEach((varName) => {
  if (envVars[varName]) {
    // Check if it's a placeholder
    if (envVars[varName].includes('your-') || envVars[varName].includes('YOUR_')) {
      console.log(`⚠️  ${varName} - placeholder value detected`);
      hasWarnings = true;
    } else {
      console.log(`✅ ${varName}`);
    }
  } else {
    console.log(`❌ ${varName} - MISSING`);
    hasErrors = true;
  }
});

console.log('');
console.log('📋 Optional variables:');
OPTIONAL_VARS.forEach((varName) => {
  if (envVars[varName]) {
    if (envVars[varName].includes('your-') || envVars[varName].includes('YOUR_')) {
      console.log(`⚠️  ${varName} - placeholder value`);
    } else {
      console.log(`✅ ${varName}`);
    }
  } else {
    console.log(`ℹ️  ${varName} - not set (optional)`);
  }
});

console.log('');
console.log('================================');

if (hasErrors) {
  console.error('❌ Missing required environment variables!');
  console.error('');
  console.error('💡 Edit .env.local and add missing variables');
  process.exit(1);
}

if (hasWarnings) {
  console.warn('⚠️  Some variables have placeholder values');
  console.warn('');
  console.warn('💡 Update them with real credentials before deploying');
  process.exit(0);
}

console.log('✅ All environment variables are valid!');
process.exit(0);