import type { WordPressPost } from "@/types/wordpress";
import {
  validateWordPressPosts,
  validateWordPressPost,
  validateWordPressBaseUrl,
} from "./validation";

/**
 * WordPress API client for Slovor marketplace.
 * Fetches posts and details from the WordPress REST API.
 * Environment variable NEXT_PUBLIC_WP_BASE is required.
 */

// Validate environment at module load time
function validateWpBase(): string | null {
  const wpBase = process.env.NEXT_PUBLIC_WP_BASE;

  if (!validateWordPressBaseUrl(wpBase)) {
    if (!wpBase) {
      console.warn(
        "Missing environment variable: NEXT_PUBLIC_WP_BASE. " +
          "Copy .env.example to .env.local and set NEXT_PUBLIC_WP_BASE to the WordPress REST API base URL (e.g., http://slovor.ct.ws/wp-json/wp/v2)."
      );
    } else {
      console.warn(`Invalid NEXT_PUBLIC_WP_BASE URL: "${wpBase}". Must be a valid absolute URL.`);
    }
    return null;
  }

  return wpBase;
}

const WP_BASE = validateWpBase();

/**
 * Fetch list of posts from the WordPress REST API.
 * Returns an array of WordPressPost or an empty array on error.
 */
export async function fetchPosts(): Promise<WordPressPost[]> {
  if (!WP_BASE) {
    return [];
  }

  try {
    const res = await fetch(`${WP_BASE}/posts`, { next: { revalidate: 60 } });

    if (!res.ok) {
      console.error(`fetchPosts: WP returned ${res.status}`);
      return [];
    }

    const rawData = await res.json();
    const validation = validateWordPressPosts(rawData);

    if (!validation.success) {
      console.error("fetchPosts: Invalid API response format:", validation.error);
      return [];
    }

    // Cast validated data to WordPressPost[] since validation ensures compatibility
    return validation.data as WordPressPost[];
  } catch (err) {
    // Keep error handling simple and observable in server logs
    // Return an empty array so callers can continue rendering gracefully
    // without throwing.

    console.error("fetchPosts error:", err);
    return [];
  }
}

/**
 * Fetch a single post by id from the WordPress REST API.
 * Returns the post or null if not found or on error.
 */
export async function fetchPost(id: number | string): Promise<WordPressPost | null> {
  if (!WP_BASE) {
    return null;
  }

  if (typeof id !== "number" && typeof id !== "string") {
    console.error(`fetchPost: Invalid id type: ${typeof id}`);
    return null;
  }

  try {
    const res = await fetch(`${WP_BASE}/posts/${id}`, { next: { revalidate: 60 } });

    if (!res.ok) {
      console.error(`fetchPost(${id}): WP returned ${res.status}`);
      return null;
    }

    const rawData = await res.json();
    const validation = validateWordPressPost(rawData);

    if (!validation.success) {
      console.error(`fetchPost(${id}): Invalid API response format:`, validation.error);
      return null;
    }

    // Cast validated data to WordPressPost since validation ensures compatibility
    return validation.data as WordPressPost;
  } catch (err) {
    console.error(`fetchPost(${id}) error:`, err);
    return null;
  }
}
