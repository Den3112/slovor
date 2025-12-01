# Slovor Marketplace — Frontend

Slovor is a minimal classifieds/marketplace frontend for slovor.sk. This repository contains the Next.js 16+ TypeScript application that serves as the public-facing UI and integrates with a WordPress headless backend.

## Overview

- **Purpose:** MVP classifieds marketplace (listings, categories, basic search/filters)
- **Theme:** Dark by default, performance and SEO focused
- **Status:** Production-ready with security hardening

## Tech Stack

- **Framework:** Next.js 16 (App Router) + React 19
- **Language:** TypeScript 5 (strict mode)
- **Styling:** Tailwind CSS 4
- **CMS:** WordPress (headless) via REST API
- **Linting:** ESLint 9 + Prettier 3
- **Testing:** Jest + React Testing Library
- **Error Tracking:** Sentry
- **Git Hooks:** Husky + commitlint

## Repository Structure

```
src/
├── app/              # Next.js App Router pages and layout
├── components/       # Presentational UI components
├── lib/              # Business logic and API clients
│   ├── wordpress/    # WordPress REST API client
│   ├── html.ts       # HTML sanitization utilities
│   └── ...
├── types/            # TypeScript interfaces
└── config/           # Static configuration (categories, API endpoints)
```

## Quick Start

### Prerequisites

- Node.js 18+ and npm (or pnpm/yarn)
- Git

### Installation

```bash
git clone https://github.com/slovor/slovor-frontend.git
cd slovor-frontend
npm install
```

### Development

```bash
npm run dev
# Opens http://localhost:3000
```

### Build for Production

```bash
npm run build
npm run start
```

### Linting & Formatting

```bash
npm run lint          # Check for linting errors
npm run format        # Format code with Prettier
npm run format:check  # Check formatting without changes
```

## Environment Variables

Create a `.env.local` file at the repository root. Copy from `.env.example` and set required variables:

```bash
cp .env.example .env.local
```

### Required Variables

| Variable              | Description                 | Example                             |
| --------------------- | --------------------------- | ----------------------------------- |
| `NEXT_PUBLIC_WP_BASE` | WordPress REST API base URL | `http://slovor.ct.ws/wp-json/wp/v2` |

### Optional Variables

| Variable                    | Description                    | Default |
| --------------------------- | ------------------------------ | ------- |
| `NEXT_PUBLIC_USE_WORDPRESS` | Use live WordPress API for ads | `false` |

## Features

- ✅ SEO-friendly server-rendered pages
- ✅ Dark theme by default with light mode support
- ✅ Category and listings pages
- ✅ WordPress integration: fetch recent posts and post details
- ✅ HTML sanitization to prevent XSS attacks
- ✅ Security headers (CSP, X-Frame-Options, etc.)
- ✅ Image optimization with WebP/AVIF support
- ✅ Responsive design with Tailwind CSS
- ✅ Accessibility features (semantic HTML, ARIA labels)
- ✅ Performance monitoring with Vercel Speed Insights (Core Web Vitals tracking in production)

## Deployment

### Vercel (Recommended)

1. Connect the repository to [Vercel](https://vercel.com)
2. Set environment variables in project settings:
   - `NEXT_PUBLIC_WP_BASE` = your WordPress API URL
3. Deploy automatically on push to `main`

### Other Platforms

- **Netlify, Render, Railway:** Ensure Node.js 18+ and set environment variables
- **Self-hosted:** Use `npm run build && npm run start`

## Documentation

- [Architecture](./docs/architecture.md) — System design and data flow
- [API Integration](./docs/api.md) — WordPress REST API details
- [Deployment](./docs/DEPLOYMENT.md) — Vercel deployment guide
- [Testing](./docs/TESTING.md) — Jest and React Testing Library setup
- [Monitoring](./docs/MONITORING.md) — Sentry error tracking
- [Contributing](./CONTRIBUTING.md) — Code standards and PR process
- [Audit Report](./AUDIT.md) — Security and quality assessment

## Security

- HTML content from WordPress is sanitized using `sanitize-html`
- Security headers configured in `next.config.ts`
- Environment variables validated at startup
- No sensitive data in client-side code

## Contributing

See [CONTRIBUTING.md](./CONTRIBUTING.md) for:

- Code style guidelines
- Commit message conventions
- PR process
- Issue reporting

**For AI Assistants:** See [AI_CONTRIBUTING_GUIDELINES.md](./AI_CONTRIBUTING_GUIDELINES.md) for comprehensive project standards and guidelines.

## License

MIT — see [LICENSE](./LICENSE) for details
