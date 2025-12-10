# Slovor

**Marketplace Platform for Slovakia**

Classifieds marketplace built with Next.js 14, TypeScript, and Supabase.

---

## 🚀 Quick Start

### Prerequisites

- Node.js 20.x or later
- npm or yarn
- Supabase account (for backend)

### Local Development

```bash
# Clone repository
git clone https://github.com/Den3112/slovor.git
cd slovor/slovor

# Install dependencies
npm install

# Setup environment variables
cp .env.example .env.local
# Edit .env.local and add your Supabase credentials

# Run development server
npm run dev
```

Open [http://localhost:3000](http://localhost:3000)

### With Lando (Docker)

```bash
cd slovor
lando start
lando ssh
cd slovor
npm install
npm run dev
```

---

## 📝 Environment Variables

Copy `.env.example` to `.env.local` and fill in:

```env
NEXT_PUBLIC_SUPABASE_URL=https://your-project.supabase.co
NEXT_PUBLIC_SUPABASE_ANON_KEY=your-anon-key
NEXT_PUBLIC_SITE_URL=http://localhost:3000
```

**Get Supabase credentials:**
1. Go to https://rsywmmnxkvwvhgrgzlei.supabase.co
2. Settings → API
3. Copy Project URL and anon/public key

---

## 🛠️ Database Setup

### Apply Migrations

```bash
# Using Supabase CLI (recommended)
cd slovor
supabase db push

# Or manually in SQL Editor:
# Copy content from supabase/migrations/001_initial.sql
# Paste in Supabase Dashboard → SQL Editor → Run
```

### Schema Overview

- **categories** - Product/service categories
- **profiles** - User profiles (linked to auth.users)
- **listings** - Marketplace listings/ads

---

## 📚 Documentation

**Essential:**
- [DEVELOPMENT.md](docs/DEVELOPMENT.md) - Development workflow (START HERE)
- [PROJECT_ROADMAP.md](docs/PROJECT_ROADMAP.md) - Project phases and timeline
- [PROJECT_STRUCTURE.md](docs/PROJECT_STRUCTURE.md) - Repository structure

**Setup Guides:**
- [LANDO_SETUP.md](docs/LANDO_SETUP.md) - Local environment with Docker
- [WSL2_SETUP.md](docs/WSL2_SETUP.md) - Windows WSL2 configuration
- [QUICK_START.md](docs/QUICK_START.md) - Quick start guide

**Testing:**
- [TESTING.md](docs/TESTING.md) - Testing guidelines

---

## 🛠️ Tech Stack

**Frontend:**
- Next.js 14 (App Router)
- React 18
- TypeScript 5
- Tailwind CSS 3

**Backend:**
- Supabase (PostgreSQL, Auth, Storage)
- Next.js API Routes

**Development:**
- Lando (Docker-based local env)
- ESLint
- TypeScript strict mode

**Deployment:**
- Vercel (automatic from main branch)

---

## 🌐 Links

- **Production:** https://slovor.vercel.app
- **Repository:** https://github.com/Den3112/slovor
- **Vercel Dashboard:** https://vercel.com/slovors-projects/slovor
- **Supabase Dashboard:** https://rsywmmnxkvwvhgrgzlei.supabase.co

---

## 📊 Current Status

**Phase:** 1 - Foundation Setup (Complete) ✅
**Last Updated:** 2025-12-10

✅ **Completed:**
- Repository setup
- Lando environment
- Next.js 14 project with TypeScript
- Tailwind CSS integration
- Base UI components (Button, Card, Input)
- Supabase client configuration
- Database schema and migrations
- Environment variables setup
- Documentation structure
- Vercel deployment

📋 **Next:**
- Phase 2: Browsing & Discovery
  - Category pages
  - Listing cards
  - Search and filters

See [PROJECT_ROADMAP.md](docs/PROJECT_ROADMAP.md) for details.

---

## 🤝 Team Workflow

**AI (Perplexity):**
- Writes all code
- Manages GitHub
- Creates documentation
- Fixes bugs

**Human + Grok:**
- Tests locally
- Provides feedback
- Reports issues
- Handles tasks AI cannot do

See [DEVELOPMENT.md](docs/DEVELOPMENT.md) for complete workflow.

---

## 📝 License

Private project - All rights reserved

---

## 👤 Maintainer

**DeNiS** ([@Den3112](https://github.com/Den3112))
AI Partner: Perplexity AI
