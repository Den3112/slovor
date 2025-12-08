# Project Structure

**Complete guide** to Slovor project organization

---

## Overview

Slovor uses a **monorepo structure** with clear separation between:
- Application code (`slovor/`)
- Development environment (root)
- Documentation (`docs/`)
- Automation (`scripts/`, `.github/`)

---

## Directory Tree

```
slovor_dev/                         # Repository root (clone as this name)
│
├── slovor/                         # Main Next.js application
│   ├── src/                        # Application source code
│   │   ├── app/                    # Next.js 15 App Router
│   │   │   ├── layout.tsx
│   │   │   ├── page.tsx
│   │   │   └── ...
│   │   ├── components/             # React components
│   │   │   ├── ui/                 # UI components
│   │   │   └── ...
│   │   ├── lib/                    # Utilities & libraries
│   │   │   ├── supabase/           # Supabase clients
│   │   │   └── utils.ts
│   │   └── types/                  # TypeScript types
│   │
│   ├── public/                     # Static assets
│   │   ├── images/
│   │   └── ...
│   │
│   ├── supabase/                   # Supabase configuration
│   │   ├── migrations/             # Database migrations
│   │   └── config.toml
│   │
│   ├── .next/                      # Next.js build output (gitignored)
│   ├── node_modules/               # Dependencies (gitignored)
│   │
│   ├── package.json                # App dependencies
│   ├── tsconfig.json               # TypeScript config
│   ├── next.config.js              # Next.js config
│   ├── tailwind.config.ts          # Tailwind config
│   ├── .eslintrc.json              # ESLint config
│   ├── .prettierrc                 # Prettier config
│   ├── .env.local                  # Local environment (gitignored)
│   └── .env.example                # Environment template
│
├── docs/                           # Documentation
│   ├── PROJECT_STRUCTURE.md        # This file
│   ├── PROJECT_ROADMAP.md          # Development roadmap
│   ├── TASK_TRACKER.md             # Current tasks
│   ├── LANDO_SETUP.md              # Lando guide
│   ├── QUICK_START.md              # Quick start
│   ├── CI_CD.md                    # CI/CD pipeline
│   ├── AI_WORKFLOW.md              # AI automation
│   ├── ISSUES_LOG.md               # Known issues
│   ├── README.md                   # Docs index
│   └── PHASE_REPORTS/              # Phase completion reports
│       ├── phase-1-report.md
│       └── ...
│
├── scripts/                        # Automation scripts
│   ├── setup-check.sh              # Validate environment
│   ├── setup-repair.sh             # Auto-fix issues
│   ├── validate-environment.js     # Check env vars
│   └── create-issues-from-tasks.js # Sync with GitHub
│
├── .github/                        # GitHub configuration
│   ├── workflows/                  # GitHub Actions
│   │   ├── ci.yml                  # CI/CD pipeline
│   │   ├── validate-setup.yml      # Daily validation
│   │   ├── security-audit.yml      # Security checks
│   │   └── project-automation.yml  # Issue automation
│   ├── CODING_STANDARDS.md         # Code guidelines
│   ├── AI_AGENT_SYSTEM.md          # AI instructions
│   └── PROJECT_SETUP.md            # GitHub setup
│
├── .devcontainer/                  # Dev Container (legacy)
│   ├── devcontainer.json
│   ├── docker-compose.yml
│   └── Dockerfile
│
├── .lando.yml                      # Lando configuration
├── .lando-version                  # Lando version lock
├── .gitignore                      # Git ignore rules
├── README.md                       # Main README
└── LICENSE                         # MIT License
```

---

## Application Code (`slovor/`)

### Purpose
Contains **only** the Next.js application code - nothing related to development environment.

### Key Directories

#### `src/app/`
Next.js 15 App Router:
- `layout.tsx` - Root layout
- `page.tsx` - Homepage
- `error.tsx` - Error boundary
- `loading.tsx` - Loading states
- Nested routes: `app/listings/page.tsx`, etc.

#### `src/components/`
React components:
- `ui/` - Reusable UI components (Button, Input, etc.)
- `layout/` - Layout components (Header, Footer)
- Feature components organized by feature

#### `src/lib/`
Utilities and libraries:
- `supabase/` - Supabase clients (server, client, middleware)
- `utils.ts` - Helper functions
- `constants.ts` - App constants

#### `src/types/`
TypeScript type definitions:
- `database.types.ts` - Supabase auto-generated types
- `index.ts` - Custom types

### Configuration Files

- `package.json` - Dependencies and scripts
- `tsconfig.json` - TypeScript settings
- `next.config.js` - Next.js settings
- `tailwind.config.ts` - Tailwind CSS
- `.eslintrc.json` - Linting rules
- `.prettierrc` - Code formatting

---

## Documentation (`docs/`)

### Purpose
All project documentation separate from app code.

### Key Files

- **PROJECT_ROADMAP.md** - 5-phase development plan
- **TASK_TRACKER.md** - Current tasks with status
- **LANDO_SETUP.md** - Complete Lando guide
- **CI_CD.md** - Automated testing and deployment
- **AI_WORKFLOW.md** - How AI automation works

---

## Automation (`scripts/`)

### Purpose
Development and setup automation scripts.

### Key Scripts

#### `setup-check.sh`
Validates:
- Node.js, npm, Git installed
- Dependencies installed
- Environment variables set
- Database connection

#### `setup-repair.sh`
Auto-fixes:
- Installs missing dependencies
- Creates `.env.local` from template
- Sets up Git hooks
- Creates directories

#### `validate-environment.js`
Checks environment variables are properly configured.

---

## GitHub Config (`.github/`)

### Purpose
GitHub-specific configuration and automation.

### Workflows

- **ci.yml** - Test, lint, build, deploy on push/PR
- **validate-setup.yml** - Daily environment validation
- **security-audit.yml** - Weekly security checks
- **project-automation.yml** - Issue/PR automation

### Documentation

- **CODING_STANDARDS.md** - Code style guide
- **AI_AGENT_SYSTEM.md** - AI automation instructions
- **PROJECT_SETUP.md** - GitHub Projects setup

---

## Root Files

### `.lando.yml`
Lando configuration:
- Node.js 18 service
- PostgreSQL 15 service
- Custom tooling commands
- Event hooks (post-start)

### `.lando-version`
Locks Lando version to `3.21.2` for consistency.

### `README.md`
Main entry point with:
- Project overview
- Quick start guide
- Links to detailed docs

---

## Ignored Files

In `.gitignore`:

```
# Application
slovor/node_modules/
slovor/.next/
slovor/.env.local
slovor/.vercel/

# Development
.lando/
.DS_Store
*.log

# IDEs
.vscode/
.idea/
```

---

## Naming Conventions

### Files
- **React components:** PascalCase (`Button.tsx`)
- **Utilities:** camelCase (`formatDate.ts`)
- **Pages:** lowercase (`page.tsx`, `layout.tsx`)
- **Config:** lowercase with extension (`.eslintrc.json`)

### Directories
- **App code:** lowercase (`components/`, `lib/`)
- **Docs:** UPPERCASE (`PROJECT_ROADMAP.md`)
- **Scripts:** lowercase with hyphens (`setup-check.sh`)

---

## Best Practices

### 1. Keep App Code Clean

✅ DO:
```
slovor/
  src/
    app/
    components/
    lib/
```

❌ DON'T:
```
slovor/
  docs/              # Put in root docs/
  scripts/           # Put in root scripts/
  .github/           # Put in root .github/
```

### 2. Use Absolute Imports

```typescript
// ✅ Good
import { Button } from '@/components/ui/Button'

// ❌ Bad
import { Button } from '../../../components/ui/Button'
```

Configured in `slovor/tsconfig.json`:
```json
{
  "compilerOptions": {
    "paths": {
      "@/*": ["./src/*"]
    }
  }
}
```

### 3. Organize by Feature

```
components/
  listings/
    ListingCard.tsx
    ListingGrid.tsx
    ListingForm.tsx
  ui/
    Button.tsx
    Input.tsx
```

### 4. Co-locate Types

```typescript
// components/listings/ListingCard.tsx
export interface ListingCardProps {
  listing: Listing
}

export function ListingCard({ listing }: ListingCardProps) {
  // ...
}
```

---

## Migration Notes

### From Old Structure

If you have old structure:
```
slovor/
  docs/
  scripts/
  src/
```

Migrate to new:
```bash
cd slovor_dev

# Move app code into slovor/
mkdir slovor
mv src slovor/
mv public slovor/
mv package.json slovor/
# etc.

# Keep docs and scripts in root
# Already there!
```

---

## Resources

- **Next.js Docs:** https://nextjs.org/docs
- **Lando Docs:** https://docs.lando.dev
- **Supabase Docs:** https://supabase.com/docs

---

**Questions? Check [README.md](../README.md)!**