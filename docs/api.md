# API Integration

This document describes the WordPress REST API integration used by the Slovor frontend.

## WordPress REST API Endpoints

The frontend communicates with WordPress via the standard REST API:

- **Posts list:** `GET {NEXT_PUBLIC_WP_BASE}/posts`
- **Single post:** `GET {NEXT_PUBLIC_WP_BASE}/posts/{id}`

### Response Format

Posts are returned as `WordPressPost` objects:

```typescript
interface WordPressPost {
  id: number;
  date: string;
  slug: string;
  title: { rendered: string };
  content: { rendered: string };
  excerpt: { rendered: string };
  featured_media: number | null;
  link: string;
  author?: number;
  categories?: number[];
}
```

## Client API

The WordPress client is located in `src/lib/wordpress/client.ts` and exposes:

### `fetchPosts(): Promise<WordPressPost[]>`

Fetches a list of recent posts from WordPress.

- **Returns:** Array of posts or empty array on error
- **Caching:** 60 seconds (ISR)
- **Error handling:** Logs errors to console, returns graceful fallback

### `fetchPost(id: number | string): Promise<WordPressPost | null>`

Fetches a single post by ID.

- **Parameters:** Post ID (number or string)
- **Returns:** Post object or `null` if not found
- **Caching:** 60 seconds (ISR)
- **Error handling:** Logs errors to console, returns `null` on failure

## HTML Sanitization

Post titles and content are returned as pre-rendered HTML by WordPress. The frontend sanitizes this HTML to prevent XSS attacks:

- **Sanitization library:** `sanitize-html`
- **Allowed tags:** `p`, `strong`, `em`, `a`, `ul`, `ol`, `li`, `h1-h6`, `img`, `table`, `code`, `pre`, etc.
- **Blocked attributes:** Scripts, event handlers, and other dangerous attributes are removed
- **Safe rendering:** Sanitized HTML is rendered using `dangerouslySetInnerHTML` (safe after sanitization)

## Environment Variables

### Required

| Variable              | Description                 | Example                             |
| --------------------- | --------------------------- | ----------------------------------- |
| `NEXT_PUBLIC_WP_BASE` | WordPress REST API base URL | `http://slovor.ct.ws/wp-json/wp/v2` |

**⚠️ Important:** This variable is **required** and must be set before the application starts. If missing, the app will throw an error with clear instructions.

### Setup

1. Copy `.env.example` to `.env.local`:

   ```bash
   cp .env.example .env.local
   ```

2. Set `NEXT_PUBLIC_WP_BASE` to your WordPress API URL:

   ```env
   NEXT_PUBLIC_WP_BASE=https://slovor.sk/wp-json/wp/v2
   ```

3. For Vercel deployment, set the environment variable in project settings

## Error Handling

The client handles errors gracefully:

- **Network errors:** Logged to console, returns empty array or `null`
- **HTTP errors:** Logged with status code, returns empty array or `null`
- **Invalid responses:** Logged to console, returns empty array or `null`

Components using the client should handle empty/null responses and display appropriate UI.

## Caching Strategy

The frontend uses Next.js ISR (Incremental Static Regeneration):

- **Revalidation interval:** 60 seconds
- **Behavior:** Pages are regenerated every 60 seconds if requested
- **Benefits:** Fast initial load, fresh content within 1 minute

## Testing

To test the API integration locally:

```bash
# Set environment variable
export NEXT_PUBLIC_WP_BASE=http://slovor.ct.ws/wp-json/wp/v2

# Run dev server
npm run dev

# Visit http://localhost:3000 to see posts fetched from WordPress
```

## Troubleshooting

### "Missing required environment variable: NEXT_PUBLIC_WP_BASE"

**Solution:** Set `NEXT_PUBLIC_WP_BASE` in `.env.local` or environment settings

### Posts not loading

1. Check browser console for errors
2. Verify `NEXT_PUBLIC_WP_BASE` is correct
3. Test WordPress API directly: `curl {NEXT_PUBLIC_WP_BASE}/posts`
4. Check WordPress server is accessible from your network

### HTML rendering issues

If HTML content appears broken:

1. Check browser console for sanitization warnings
2. Verify WordPress content uses standard HTML tags
3. Custom HTML tags may be stripped by the sanitizer
