/**
 * TypeScript types for WordPress REST API responses used in the app.
 */

/**
 * WordPress REST API base response structure
 */
export interface WordPressBaseEntity {
  id: number;
  date: string;
  date_gmt: string;
  modified: string;
  modified_gmt: string;
  slug: string;
  status: "publish" | "draft" | "pending" | "private" | "future";
  type: string;
  link: string;
  [key: string]: unknown;
}

/**
 * WordPress title object
 */
export interface WordPressTitle {
  rendered: string;
  raw?: string;
}

/**
 * WordPress content object
 */
export interface WordPressContent {
  rendered: string;
  raw?: string;
  protected?: boolean;
}

/**
 * WordPress excerpt object
 */
export interface WordPressExcerpt {
  rendered: string;
  raw?: string;
  protected?: boolean;
}

/**
 * WordPress GUID object
 */
export interface WordPressGuid {
  rendered: string;
}

/**
 * WordPress author object (simplified)
 */
export interface WordPressAuthor {
  id: number;
  name: string;
  url: string;
  description: string;
  link: string;
  slug: string;
  avatar_urls?: Record<string, string>;
  [key: string]: unknown;
}

/**
 * WordPress category object (simplified)
 */
export interface WordPressCategory {
  id: number;
  count: number;
  description: string;
  link: string;
  name: string;
  slug: string;
  taxonomy: string;
  parent: number;
  [key: string]: unknown;
}

/**
 * WordPress tag object (simplified)
 */
export interface WordPressTag {
  id: number;
  count: number;
  description: string;
  link: string;
  name: string;
  slug: string;
  taxonomy: string;
  [key: string]: unknown;
}

/**
 * WordPress featured media object (simplified)
 */
export interface WordPressMedia {
  id: number;
  date: string;
  slug: string;
  type: string;
  link: string;
  title: WordPressTitle;
  author: number;
  caption: WordPressContent;
  alt_text: string;
  media_type: string;
  mime_type: string;
  media_details: {
    width: number;
    height: number;
    file: string;
    sizes: Record<
      string,
      {
        file: string;
        width: number;
        height: number;
        mime_type: string;
        source_url: string;
      }
    >;
  };
  source_url: string;
  [key: string]: unknown;
}

/**
 * Complete WordPress post representation from the WP REST API.
 */
export interface WordPressPost extends WordPressBaseEntity {
  title: WordPressTitle;
  content: WordPressContent;
  excerpt: WordPressExcerpt;
  author: number;
  featured_media: number;
  comment_status: "open" | "closed";
  ping_status: "open" | "closed";
  sticky: boolean;
  template: string;
  format:
    | "standard"
    | "aside"
    | "chat"
    | "gallery"
    | "link"
    | "image"
    | "quote"
    | "status"
    | "video"
    | "audio";
  meta: Record<string, unknown>;
  categories: number[];
  tags: number[];

  // Embedded data (when _embed parameter is used)
  _embedded?: {
    author?: WordPressAuthor[];
    "wp:featuredmedia"?: WordPressMedia[];
    "wp:term"?: Array<WordPressCategory[] | WordPressTag[]>;
  };

  // Additional fields that may be present
  guid?: WordPressGuid;
  menu_order?: number;
  [key: string]: unknown;
}

/**
 * WordPress posts collection response
 */
export interface WordPressPostsResponse {
  data: WordPressPost[];
  total: number;
  totalPages: number;
}

/**
 * WordPress API pagination links
 */
export interface WordPressPaginationLinks {
  self: Array<{ href: string }>;
  collection: Array<{ href: string }>;
  about?: Array<{ href: string }>;
  author?: Array<{ href: string }>;
  replies?: Array<{ href: string }>;
  "version-history"?: Array<{ href: string }>;
  "predecessor-version"?: Array<{ href: string }>;
  "wp:featuredmedia"?: Array<{ href: string }>;
  "wp:attachment"?: Array<{ href: string }>;
  "wp:term"?: Array<{ href: string }>;
  curies?: Array<{ name: string; href: string; templated: boolean }>;
}

/**
 * WordPress API response headers
 */
export interface WordPressResponseHeaders {
  "x-wp-total"?: string;
  "x-wp-totalpages"?: string;
  link?: string;
}

/**
 * Generic WordPress response type for an array of posts.
 * @deprecated Use WordPressPostsResponse instead
 */
export type WordPressResponse = WordPressPost[];
