import type { WordPressPost } from "@/types/wordpress";

// Read WP base URL from environment variable for flexibility in different
// environments (development, staging, production). Falls back to the
// original hard-coded value for backwards compatibility.
const WP_BASE = process.env.NEXT_PUBLIC_WP_BASE ?? "http://slovor.ct.ws/wp-json/wp/v2";

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
