# Quick Start Guide

**Purpose:** Fast setup for new projects using this template

---

## For New Projects

### Step 1: Clone Template
```bash
git clone https://github.com/Den3112/slovor.git my-new-project
cd my-new-project
rm -rf .git
git init
```

### Step 2: Update Project Info

Edit these files:
- `docs/PROJECT_ROADMAP.md` - Change project name/description
- `package.json` - Update name, description
- `README.md` - Update title

### Step 3: Setup Services

1. **Create Supabase Project:** https://supabase.com
2. **Create Vercel Project:** https://vercel.com
3. **Create Sentry Project:** https://sentry.io
4. **Get GitHub Token:** https://github.com/settings/tokens

### Step 4: Update Credentials

Edit `.env.local`:
```
NEXT_PUBLIC_SUPABASE_URL=your-url
NEXT_PUBLIC_SUPABASE_ANON_KEY=your-key
SUPABASE_SERVICE_ROLE_KEY=your-service-key
SENTRY_DSN=your-dsn
VERCEL_TOKEN=your-token
GITHUB_TOKEN=your-token
```

### Step 5: Start AI Agent

Open Windsurf/Cursor with Killo Code:
```
start phase 1
```

AI will set up everything automatically!

---

## For Slovor Development

### Step 1: Clone Repo
```bash
git clone https://github.com/Den3112/slovor.git
cd slovor
```

### Step 2: Open in Windsurf
```bash
code slovor
```

### Step 3: Start Dev Container
F1 → "Dev Containers: Reopen in Container"

### Step 4: Start AI Agent
Killo Code (Grok):
```
start phase 1
```

---

## Commands

- `start phase X` - Begin phase
- `continue` - Resume work
- `status` - Show progress
- `approve phase X` - Commit & next
- `stop` - Pause AI

---

**Questions?** Check `docs/AI_WORKFLOW.md`