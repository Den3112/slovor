import type { WordPressPost } from "@/types/wordpress";

/**
 * WordPress API client for Slovor marketplace.
 * Fetches posts and details from the WordPress REST API.
 * Environment variable NEXT_PUBLIC_WP_BASE is required.
 */

// Validate environment at module load time
function validateWpBase(): string {
  const wpBase = process.env.NEXT_PUBLIC_WP_BASE;

  if (!wpBase) {
    throw new Error(
      "Missing required environment variable: NEXT_PUBLIC_WP_BASE. " +
      "Copy .env.example to .env.local and set NEXT_PUBLIC_WP_BASE to the WordPress REST API base URL (e.g., http://slovor.ct.ws/wp-json/wp/v2)."
    );
  }

  // Validate URL format
  try {
    new URL(wpBase);
  } catch {
    throw new Error(
      `Invalid NEXT_PUBLIC_WP_BASE URL: "${wpBase}". Must be a valid absolute URL.`
    );
  }

  return wpBase;
}

const WP_BASE = validateWpBase();

/**
 * Fetch list of posts from the WordPress REST API.
 * Returns an array of WordPressPost or an empty array on error.
 */
export async function fetchPosts(): Promise<WordPressPost[]> {
  try {
    const res = await fetch(`${WP_BASE}/posts`, { next: { revalidate: 60 } });

    if (!res.ok) {
      console.error(`fetchPosts: WP returned ${res.status}`);
      return [];
    }

    const data = (await res.json()) as WordPressPost[];
    return data;
  } catch (err) {
    // Keep error handling simple and observable in server logs
    // Return an empty array so callers can continue rendering gracefully
    // without throwing.
    // eslint-disable-next-line no-console
    console.error("fetchPosts error:", err);
    return [];
  }
}

/**
 * Fetch a single post by id from the WordPress REST API.
 * Returns the post or null if not found or on error.
 */
export async function fetchPost(id: number | string): Promise<WordPressPost | null> {
  try {
    const res = await fetch(`${WP_BASE}/posts/${id}`, { next: { revalidate: 60 } });

    if (!res.ok) {
      console.error(`fetchPost(${id}): WP returned ${res.status}`);
      return null;
    }

    const data = (await res.json()) as WordPressPost;
    return data;
  } catch (err) {
    // eslint-disable-next-line no-console
    console.error(`fetchPost(${id}) error:`, err);
    return null;
  }
}
