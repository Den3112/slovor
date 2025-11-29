/**
 * TypeScript types for WordPress REST API responses used in the app.
 */

/**
 * Minimal representation of a WordPress post returned by the WP REST API.
 */
export interface WordPressPost {
  id: number;
  date: string;
  slug: string;
  title: {
    rendered: string;
  };
  content: {
    rendered: string;
  };
  excerpt: {
    rendered: string;
  };
  featured_media: number | null;
  link: string;
  author?: number;
  categories?: number[];
  [key: string]: unknown;
}

/**
 * Generic WordPress response type for an array of posts.
 */
export type WordPressResponse = WordPressPost[];
