# Testing Guide

**How to test Lando setup and scripts**

---

## Prerequisites

- WSL2 + Docker + Lando installed
- Project cloned: `slovor_dev`

---

## Test 1: Fresh Start

**Simulates first-time setup**

```bash
cd slovor_dev

# Clean state
lando destroy -y
rm -rf slovor/node_modules
rm -rf slovor/.env.local

# Pull latest
git pull origin main

# Start (should auto-repair)
lando start
```

**Expected Output:**
```
┌─────────────────────────────────────────────────┐
│  Slovor Development Environment                 │
└─────────────────────────────────────────────────┘

ℹ Running auto-repair...
⟳ Installing dependencies...
✓ Dependencies installed
⟳ Creating environment file...
✓ Created .env.local from template
⚠ Update .env.local with your credentials

✓ Completed 2 repair(s)
✓ Environment validated

Quick Commands:
  lando dev       → Start development server
  lando doctor    → System diagnostics
  lando health    → Quick health check

URLs:
  App:  http://localhost:3000
  API:  http://localhost:3000/api
```

---

## Test 2: Doctor Diagnostics

```bash
lando doctor
```

**Expected Output (all OK):**
```
Slovor System Diagnostics
2025-12-09 13:00:00

System
  ✓ WSL2 detected

Tools
  ✓ Lando v3.21.0
  ✓ Docker v24.0.0 (running)
  ✓ Git v2.34.0

Project
  ✓ Lando configuration found
  ✓ Application directory found
  ✓ package.json found
  ✓ Dependencies installed

Services
  ✓ Lando services running
  ✓ appserver service healthy
  ✓ database service healthy

WSL2 Configuration
  ✓ .wslconfig found

Summary
  All systems operational
```

**Expected Output (with warnings):**
```
Slovor System Diagnostics
2025-12-09 13:00:00

System
  ✓ WSL2 detected

Tools
  ✓ Lando v3.21.0
  ⚠ Docker installed but not running
    ℹ Start: sudo service docker start
  ✓ Git v2.34.0

Project
  ✓ Lando configuration found
  ✓ Application directory found
  ✓ package.json found
  ⚠ Dependencies not installed
    ℹ Run: lando npm install

Summary
  2 warning(s) - system functional
```

---

## Test 3: Health Check

```bash
lando health
```

**Expected Output (passing):**
```
Running health check...
✓ ESLint passed
✓ TypeScript passed
```

**Expected Output (with issues):**
```
Running health check...
⚠ ESLint found issues
  Fix: lando lint:fix
✗ TypeScript errors found
  Review output above
```

---

## Test 4: Setup Check

```bash
lando setup-check
```

**Expected Output (success):**
```
(no output - silent success)
```

**Expected Output (issues):**
```
⚠ Dependencies not installed
  → Run: lando npm install
⚠ Environment file missing
  → Copy: .env.example → .env.local
```

---

## Test 5: Setup Repair

```bash
# Create issue
rm -rf slovor/node_modules
rm slovor/.env.local

# Repair
lando setup-repair
```

**Expected Output:**
```
Auto-repair starting...

⟳ Installing dependencies...
✓ Dependencies installed
⟳ Creating environment file...
✓ Created .env.local from template
⚠ Update .env.local with your credentials

✓ Completed 2 repair(s)
```

---

## Test 6: Pre-start Check

```bash
# Stop Docker
sudo service docker stop

# Try to start (should auto-start Docker)
lando start
```

**Expected Output:**
```
⚠ Docker not running, starting...
(Docker starts automatically)
```

---

## Test 7: Development Server

```bash
lando dev
```

**Should open Next.js dev server on http://localhost:3000**

---

## Test 8: Database Connection

```bash
lando psql
```

**Expected:**
- PostgreSQL shell opens
- Can run: `\dt` to list tables
- Exit: `\q`

---

## Test 9: All Commands

```bash
lando npm --version
lando node --version
lando npx --version
lando lint
lando tsc
lando test
lando build
```

**All should execute without errors**

---

## Test 10: Stress Test

```bash
# Full cycle
lando destroy -y
rm -rf slovor/node_modules slovor/.env.local
git pull origin main
lando start
lando doctor
lando health
lando dev
```

**Everything should work end-to-end**

---

## Common Issues

### Issue: `lando start` hangs

**Fix:**
```bash
lando poweroff
sudo service docker restart
lando start
```

### Issue: `port 3000 already in use`

**Fix:**
```bash
sudo lsof -i:3000
sudo kill -9 <PID>
lando restart
```

### Issue: `permission denied` (Docker)

**Fix:**
```bash
sudo usermod -aG docker $USER
newgrp docker
```

---

## Reporting Issues

If tests fail:

1. **Run full diagnostics:**
   ```bash
   lando doctor > diagnostics.txt
   ```

2. **Capture logs:**
   ```bash
   lando logs > logs.txt
   ```

3. **Report on GitHub:**
   - Attach `diagnostics.txt`
   - Attach `logs.txt`
   - Describe expected vs actual behavior

---

**All tests passed?** ✅ Setup is working correctly!