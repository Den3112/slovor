/**
 * Zod validation schemas for WordPress API responses.
 * Provides runtime type validation for API data.
 */

import { z } from "zod";

// Base entity schema
const wordpressBaseEntitySchema = z
  .object({
    id: z.number(),
    date: z.string(),
    date_gmt: z.string(),
    modified: z.string(),
    modified_gmt: z.string(),
    slug: z.string(),
    status: z.enum(["publish", "draft", "pending", "private", "future"]),
    type: z.string(),
    link: z.string(),
  })
  .passthrough();

// Title schema
const wordpressTitleSchema = z.object({
  rendered: z.string(),
  raw: z.string().optional(),
});

// Content schema
const wordpressContentSchema = z.object({
  rendered: z.string(),
  raw: z.string().optional(),
  protected: z.boolean().optional(),
});

// Excerpt schema
const wordpressExcerptSchema = z.object({
  rendered: z.string(),
  raw: z.string().optional(),
  protected: z.boolean().optional(),
});

// GUID schema
const wordpressGuidSchema = z.object({
  rendered: z.string(),
});

// Author schema (simplified)
const wordpressAuthorSchema = z
  .object({
    id: z.number(),
    name: z.string(),
    url: z.string(),
    description: z.string(),
    link: z.string(),
    slug: z.string(),
    avatar_urls: z.record(z.string(), z.string()).optional(),
  })
  .passthrough();

// Category schema (simplified)
const wordpressCategorySchema = z
  .object({
    id: z.number(),
    count: z.number(),
    description: z.string(),
    link: z.string(),
    name: z.string(),
    slug: z.string(),
    taxonomy: z.string(),
    parent: z.number(),
  })
  .passthrough();

// Tag schema (simplified)
const wordpressTagSchema = z
  .object({
    id: z.number(),
    count: z.number(),
    description: z.string(),
    link: z.string(),
    name: z.string(),
    slug: z.string(),
    taxonomy: z.string(),
  })
  .passthrough();

// Media schema (simplified)
const wordpressMediaSchema = z
  .object({
    id: z.number(),
    date: z.string(),
    slug: z.string(),
    type: z.string(),
    link: z.string(),
    title: wordpressTitleSchema,
    author: z.number(),
    caption: wordpressContentSchema,
    alt_text: z.string(),
    media_type: z.string(),
    mime_type: z.string(),
    media_details: z.object({
      width: z.number(),
      height: z.number(),
      file: z.string(),
      sizes: z.record(
        z.string(),
        z.object({
          file: z.string(),
          width: z.number(),
          height: z.number(),
          mime_type: z.string(),
          source_url: z.string(),
        })
      ),
    }),
    source_url: z.string(),
  })
  .passthrough();

// Complete WordPress post schema
export const wordpressPostSchema = wordpressBaseEntitySchema
  .extend({
    title: wordpressTitleSchema,
    content: wordpressContentSchema,
    excerpt: wordpressExcerptSchema,
    author: z.number(),
    featured_media: z.number(),
    comment_status: z.enum(["open", "closed"]),
    ping_status: z.enum(["open", "closed"]),
    sticky: z.boolean(),
    template: z.string(),
    format: z.enum([
      "standard",
      "aside",
      "chat",
      "gallery",
      "link",
      "image",
      "quote",
      "status",
      "video",
      "audio",
    ]),
    meta: z.record(z.string(), z.unknown()),
    categories: z.array(z.number()),
    tags: z.array(z.number()),
    guid: wordpressGuidSchema.optional(),
    menu_order: z.number().optional(),

    // Embedded data
    _embedded: z
      .object({
        author: z.array(wordpressAuthorSchema).optional(),
        "wp:featuredmedia": z.array(wordpressMediaSchema).optional(),
        "wp:term": z
          .array(z.union([z.array(wordpressCategorySchema), z.array(wordpressTagSchema)]))
          .optional(),
      })
      .optional(),
  })
  .passthrough();

// Array of posts schema
export const wordpressPostsArraySchema = z.array(wordpressPostSchema);

// Environment variable validation
export const wordpressBaseUrlSchema = z
  .string()
  .url()
  .refine((url) => url.startsWith("http://") || url.startsWith("https://"), {
    message: "WordPress base URL must use HTTP or HTTPS protocol",
  });

// Validation functions
export function validateWordPressPost(data: unknown) {
  return wordpressPostSchema.safeParse(data);
}

export function validateWordPressPosts(data: unknown) {
  return wordpressPostsArraySchema.safeParse(data);
}

export function validateWordPressBaseUrl(url: string | undefined): url is string {
  if (!url) return false;
  return wordpressBaseUrlSchema.safeParse(url).success;
}

// Type exports
export type ValidatedWordPressPost = z.infer<typeof wordpressPostSchema>;
export type ValidatedWordPressPosts = z.infer<typeof wordpressPostsArraySchema>;
