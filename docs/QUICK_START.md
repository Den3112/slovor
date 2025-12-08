# Quick Start Guide

**Purpose:** Fast setup for Slovor development

---

## For Slovor Development

### Step 1: Install Lando

**Windows:**
1. Download: https://github.com/lando/lando/releases/latest
2. Run `lando-x64-v3.x.x.exe`
3. Restart computer

**macOS:**
```bash
brew install lando
```

**Linux:**
```bash
wget https://files.lando.dev/installer/lando-x64-stable.deb
sudo dpkg -i lando-x64-stable.deb
```

### Step 2: Clone & Start

```bash
git clone https://github.com/Den3112/slovor.git
cd slovor
lando start
```

**Wait 2-3 minutes...** ☕

### Step 3: Develop!

```bash
lando dev     # Start dev server → http://localhost:3000
lando lint    # Run linting
lando test    # Run tests
```

---

## For New Projects Using This Template

### Step 1: Clone Template

```bash
git clone https://github.com/Den3112/slovor.git my-new-project
cd my-new-project
rm -rf .git
git init
```

### Step 2: Update Project Info

Edit these files:
- `.lando.yml` - Change `name: slovor` to your project name
- `package.json` - Update name, description
- `README.md` - Update title
- `docs/PROJECT_ROADMAP.md` - Change project details

### Step 3: Setup Services

1. **Supabase:** https://supabase.com
2. **Vercel:** https://vercel.com
3. **Sentry:** https://sentry.io

### Step 4: Update Credentials

Edit `.lando.yml` → `services.appserver.overrides.environment` with your keys

Or create `.env.local`:
```bash
cp .env.example .env.local
# Edit .env.local with real credentials
```

### Step 5: Start

```bash
lando start
```

---

## AI Automation

### With Killo Code (Windsurf):

```
start phase 1     # AI begins Phase 1 development
continue          # Resume work
status            # Check progress
approve phase 1   # Complete and commit
```

AI will:
- Execute tasks automatically
- Update task tracker
- Run tests
- Commit changes
- Move to next phase

[Full AI workflow →](AI_WORKFLOW.md)

---

## Common Commands

```bash
# Development
lando start       # Start services
lando dev         # Dev server
lando stop        # Stop services
lando restart     # Restart
lando rebuild     # Rebuild containers

# npm
lando npm install
lando npm run build
lando npx next dev

# Database
lando psql        # Connect to DB
lando db-reset    # Reset DB
lando db-migrate  # Run migrations

# Quality
lando lint        # ESLint
lando format      # Prettier
lando test        # Jest
lando tsc         # Type check

# Troubleshooting
lando logs        # View logs
lando ssh         # SSH into container
lando info        # Service info
```

---

## Links

- **Full Lando Guide:** [LANDO_SETUP.md](LANDO_SETUP.md)
- **Project Roadmap:** [PROJECT_ROADMAP.md](PROJECT_ROADMAP.md)
- **Coding Standards:** [../.github/CODING_STANDARDS.md](../.github/CODING_STANDARDS.md)
- **Production:** https://slovor.vercel.app

---

**Questions? Check [LANDO_SETUP.md](LANDO_SETUP.md)!**