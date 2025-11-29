# API Integration

This document describes the WordPress REST API integration used by the frontend.

WordPress endpoints
- Posts: `GET {NEXT_PUBLIC_WP_BASE}/posts`
- Single post: `GET {NEXT_PUBLIC_WP_BASE}/posts/{id}`

Client
- `src/lib/wordpress/client.ts` exposes:
  - `fetchPosts(): Promise<WordPressPost[]>` — returns recent posts.
  - `fetchPost(id): Promise<WordPressPost | null>` — returns a single post by id.

Notes
- The client reads the base URL from the environment variable `NEXT_PUBLIC_WP_BASE` and falls back to the default `http://slovor.ct.ws/wp-json/wp/v2` if not set.
- Post titles and content are returned as pre-rendered HTML by WordPress. The app strips HTML for excerpts by default and renders full post content with `dangerouslySetInnerHTML` (consider sanitizing in production).

Environment variables
- Copy `.env.example` to `.env.local` and set `NEXT_PUBLIC_WP_BASE` to the WordPress REST API base URL. Example:

```
NEXT_PUBLIC_WP_BASE=http://slovor.ct.ws/wp-json/wp/v2
```

