# Architecture

This document describes the high-level architecture of the Slovor frontend.

Overview
- The app is a server-rendered React application using Next.js (App Router).
- WordPress acts as a headless CMS and provides posts and taxonomies via REST API.

Folders of interest
- `src/app/` — App Router layout and pages. Pages are server components by default.
- `src/components/` — Presentational UI components; keep them pure and small.
- `src/lib/` — Business logic, API clients (WordPress client lives in `src/lib/wordpress/client.ts`).
- `src/types/` — Shared TypeScript interfaces and types.

Data flow
- Server components call `src/lib/wordpress/client.ts` to fetch posts and details.
- Data is passed down to presentational components for rendering.

Styling
- Tailwind CSS with a dark-by-default palette; components use utility classes for layout and typography.

Environment
- The WordPress base URL is configurable via `NEXT_PUBLIC_WP_BASE`.
- Copy `.env.example` to `.env.local` and set `NEXT_PUBLIC_WP_BASE` before running the app locally or in CI.

Deployment
- Optimized for edge or serverless hosts like Vercel. Use environment variables (set via the Vercel project settings) to configure `NEXT_PUBLIC_WP_BASE` in production.
