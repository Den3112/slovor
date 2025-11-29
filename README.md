# Slovor Marketplace — Frontend

Slovor is a minimal classifieds/marketplace frontend for slovor.sk. This repository contains the Next.js 15+ TypeScript application that serves as the public-facing UI and integrates with a WordPress headless backend.

Overview
- Purpose: MVP classifieds marketplace (listings, categories, basic search/filters).
- Theme: Dark by default, performance and SEO focused.

Tech stack
- Next.js (App Router) + TypeScript
- Tailwind CSS for styling
- WordPress (headless) as CMS via REST API
- Optional: Zustand for app state

Repository structure
- `src/app/` — Next.js App Router pages and layout
- `src/components/` — Presentational UI components
- `src/lib/` — Business logic and API clients (WordPress client lives here)
- `src/types/` — TypeScript types (including WordPress types)

Getting started (development)
Prerequisites
- Node.js 18+ and npm
- Git

Install
```powershell
cd D:\slovor_dev\slovor\frontend
npm install
```

Run local dev server
```powershell
npm run dev
```

Build
```powershell
npm run build
npm run start
```

Environment
- The WordPress REST API base URL is configurable via the `NEXT_PUBLIC_WP_BASE` environment variable.
- Copy `.env.example` to `.env.local` and set `NEXT_PUBLIC_WP_BASE` for local development and deployments.

Features
- Homepage with feature cards and recent posts fetched from WordPress
- WordPress API client: `fetchPosts()` and `fetchPost(id)`
- Dynamic post pages at `/posts/[id]`

Deployment
- Vercel is recommended for Next.js apps. Connect the repository and set required environment variables (if you switch the WP base URL to an env var).

Contributing
- See `CONTRIBUTING.md` for contribution guidelines, code style, and PR process.

License
- MIT — see `LICENSE`
# Slovor Frontend

Slovor marketplace for Slovakia — Next.js frontend.

This repository contains the Next.js 15 + TypeScript frontend for the Slovor classifieds marketplace project. It is optimized for SEO, fast performance, and a dark theme by default.

## Tech stack
- Next.js 15 (App Router)
- TypeScript
- Tailwind CSS
- WordPress (headless CMS) via REST API
- Zustand (optional for future state)

## Features
- SEO-friendly server-rendered pages
- Dark theme by default
- Category and listings pages
- WordPress integration: fetch recent posts and post details
- Small presentational React components and separation of business logic into `src/lib`

## Quick start

Prerequisites:
- Node.js 18+ and npm (or pnpm/yarn)
- Git

1. Clone the repository

```bash
git clone https://github.com/YOUR_USERNAME/slovor-frontend.git
cd slovor-frontend
```

2. Install dependencies

```bash
npm install
# or pnpm install
```

3. Development

```bash
npm run dev
# opens http://localhost:3000
```

4. Build for production

```bash
npm run build
npm run start
```

## Environment variables

Create a `.env.local` file at the repo root for secrets and runtime config. Copy values from `.env.example`.

Required (example):

```
NEXT_PUBLIC_WP_BASE=http://slovor.ct.ws/wp-json/wp/v2
```

## Testing & linting

This project follows TypeScript and Tailwind conventions. Add or run linters and tests as needed:

```bash
npm run lint
npm run test
```

## Deployment

Recommended: Vercel. Connect the repository to Vercel and set any environment variables under project settings. Build command: `npm run build`, and output directory is handled by Next.js App Router.

Other platforms: Netlify, Render — ensure environment variables and Node version (18+) are configured.

## Documentation
- Project specification: `docs/ai-spec.md`
- Architecture notes: `docs/architecture.md`
- API notes: `docs/api.md`

## Contributing
See `CONTRIBUTING.md` for contribution guidelines, code style, and PR process.

## License
This project is licensed under the MIT License — see `LICENSE` for details.
This is a [Next.js](https://nextjs.org) project bootstrapped with [`create-next-app`](https://nextjs.org/docs/app/api-reference/cli/create-next-app).

## Getting Started

First, run the development server:

```bash
npm run dev
# or
yarn dev
# or
pnpm dev
# or
bun dev
```

Open [http://localhost:3000](http://localhost:3000) with your browser to see the result.

You can start editing the page by modifying `app/page.tsx`. The page auto-updates as you edit the file.

This project uses [`next/font`](https://nextjs.org/docs/app/building-your-application/optimizing/fonts) to automatically optimize and load [Geist](https://vercel.com/font), a new font family for Vercel.

## Learn More

To learn more about Next.js, take a look at the following resources:

- [Next.js Documentation](https://nextjs.org/docs) - learn about Next.js features and API.
- [Learn Next.js](https://nextjs.org/learn) - an interactive Next.js tutorial.

You can check out [the Next.js GitHub repository](https://github.com/vercel/next.js) - your feedback and contributions are welcome!

## Deploy on Vercel

The easiest way to deploy your Next.js app is to use the [Vercel Platform](https://vercel.com/new?utm_medium=default-template&filter=next.js&utm_source=create-next-app&utm_campaign=create-next-app-readme) from the creators of Next.js.

Check out our [Next.js deployment documentation](https://nextjs.org/docs/app/building-your-application/deploying) for more details.
