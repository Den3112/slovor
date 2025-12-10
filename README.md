# Slovor - Interactive Marketplace Platform

Modern marketplace platform for Slovakia built with Next.js 14, Supabase, and TypeScript.

## Quick Start

### Prerequisites
- [Lando](https://lando.dev/) installed
- Git

### One-Command Setup

**Windows:**
```bash
setup.bat
```

**macOS/Linux:**
```bash
chmod +x setup.sh
./setup.sh
```

**Or use Make:**
```bash
make setup
```

### Development

**Windows:**
```bash
dev.bat
```

**macOS/Linux/Make:**
```bash
make dev
```

Then open [http://slovor.lndo.site](http://slovor.lndo.site)

## Available Commands

### Using Make (recommended)

```bash
make dev        # Start development server
make check      # Run all quality checks
make build      # Build for production
make lint       # Run ESLint
make typecheck  # Check TypeScript
make ssh        # Open Lando terminal
make clean      # Remove node_modules
make deploy     # Deploy to GitHub
```

### Using Batch Files (Windows)

```bash
dev.bat         # Start development server
check.bat       # Run quality checks
setup.bat       # Initial setup
```

### Manual Commands (inside Lando)

```bash
lando ssh
cd slovor
npm run dev      # Start dev server
npm run build    # Production build
npm run lint     # ESLint
npm run typecheck # TypeScript check
npm run check    # All checks at once
```

## Project Structure

```
slovor/
├── app/              # Next.js 14 App Router
├── components/       # React components
│   └── ui/          # Reusable UI components
├── lib/             # Utilities and helpers
│   └── supabase/    # Supabase client
├── types/           # TypeScript type definitions
├── public/          # Static assets
└── docs/            # Documentation
```

## Tech Stack

- **Framework:** Next.js 14 (App Router)
- **Language:** TypeScript 5
- **Styling:** Tailwind CSS 3
- **Database:** Supabase (PostgreSQL)
- **Auth:** Supabase Auth (planned for Phase 3)
- **Hosting:** Vercel
- **Dev Environment:** Lando + Docker

## Development Phases

- ✅ **Phase 1:** Foundation & Infrastructure (COMPLETED)
- 🚧 **Phase 2:** Browsing & Discovery (In Planning)
- 📅 **Phase 3:** Authentication & User Profiles
- 📅 **Phase 4:** Listings & Transactions
- 📅 **Phase 5:** Optimization & Analytics

See [docs/PROJECT_PLAN.md](docs/PROJECT_PLAN.md) for detailed roadmap.

## Environment Variables

Create `.env.local` in the `slovor/` directory:

```env
NEXT_PUBLIC_SUPABASE_URL=your_supabase_url
NEXT_PUBLIC_SUPABASE_ANON_KEY=your_supabase_anon_key
```

## Documentation

- [Project Plan](docs/PROJECT_PLAN.md) - Complete development roadmap
- [Development Guide](docs/DEVELOPMENT.md) - Setup and workflow
- [Database Schema](docs/DATABASE.md) - Database structure
- [Architecture](docs/ARCHITECTURE.md) - System design

## Links

- **Live Site:** [https://slovor.vercel.app](https://slovor.vercel.app)
- **Repository:** [https://github.com/Den3112/slovor](https://github.com/Den3112/slovor)
- **Project Board:** [GitHub Projects](https://github.com/users/Den3112/projects/3)

## License

MIT © Den3112
