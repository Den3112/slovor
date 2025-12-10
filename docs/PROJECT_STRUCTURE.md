# Project Structure

**Last Updated:** 2025-12-10

---

## Repository Layout

```
slovor/                          # Repository root
├── .lando.yml                   # Lando configuration
├── .lando-version               # Lando version
├── README.md                    # Main documentation
├── scripts/                     # Utility scripts
│   ├── check-connectivity.sh   # Check external services
│   ├── post-start.sh           # Lando post-start hook
│   └── setup-repair.sh         # Environment repair
├── docs/                        # Documentation
│   ├── DEVELOPMENT.md          # Development workflow (NEW)
│   ├── PROJECT_ROADMAP.md      # Project roadmap
│   ├── PROJECT_STRUCTURE.md    # This file
│   ├── LANDO_SETUP.md          # Local environment setup
│   ├── WSL2_SETUP.md           # Windows WSL2 setup
│   ├── QUICK_START.md          # Quick start guide
│   ├── TESTING.md              # Testing guide
│   └── archive/                # Deprecated documentation
└── slovor/                      # Next.js application
    ├── app/                     # Next.js 14 app directory
    │   ├── layout.tsx          # Root layout
    │   └── page.tsx            # Home page
    ├── public/                  # Static assets
    ├── package.json             # Dependencies
    ├── tsconfig.json            # TypeScript config
    ├── next.config.js           # Next.js config
    ├── .gitignore               # Git ignore rules
    └── README.md                # App documentation
```

---

## Next.js Application Structure

**Current (Minimal):**
```
slovor/
├── app/
│   ├── layout.tsx              # Root layout with metadata
│   └── page.tsx                # Landing page
├── public/                      # Static files
├── package.json                 # Dependencies
├── tsconfig.json                # TypeScript config
└── next.config.js               # Next.js config
```

**Planned (Phase 1 Complete):**
```
slovor/
├── app/
│   ├── layout.tsx
│   ├── page.tsx
│   ├── globals.css
│   ├── (auth)/                 # Auth routes group
│   ├── (browse)/               # Browse routes group
│   └── api/                    # API routes
├── components/
│   ├── ui/                     # Base UI components
│   ├── layout/                 # Layout components
│   └── features/               # Feature components
├── lib/
│   ├── supabase/               # Supabase client
│   ├── utils/                  # Utilities
│   └── constants/              # Constants
├── types/                       # TypeScript types
├── public/                      # Static assets
└── config files...
```

---

## Development Tools

**Lando Environment:**
- Docker-based local development
- PostgreSQL database
- Node.js runtime
- Scripts for environment management

**Next.js:**
- Version: 14.2.18
- React: 18.3.1
- TypeScript: 5.x
- App Router architecture

---

## Configuration Files

| File | Purpose |
|------|--------|
| `.lando.yml` | Lando configuration |
| `tsconfig.json` | TypeScript settings |
| `next.config.js` | Next.js settings |
| `package.json` | Dependencies |
| `.gitignore` | Git ignore rules |

---

## Documentation

**Active:**
- `DEVELOPMENT.md` - Development workflow
- `PROJECT_ROADMAP.md` - Project roadmap
- `PROJECT_STRUCTURE.md` - This file
- `LANDO_SETUP.md` - Local setup
- `WSL2_SETUP.md` - Windows setup
- `QUICK_START.md` - Quick start
- `TESTING.md` - Testing guide

**Archived:**
- `archive/AI_WORKFLOW.md` - Old AI workflow
- `archive/CI_CD.md` - CI/CD notes
- `archive/TASK_TRACKER.md` - Old task tracking
- (other deprecated files)

---

## Next Steps

See `PROJECT_ROADMAP.md` for planned features and timeline.
