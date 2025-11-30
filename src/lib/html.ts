import sanitizeHtml from "sanitize-html";

/**
 * Utility functions for HTML processing.
 */

/**
 * Remove HTML tags from a string and return plain text.
 * Handles common entities like &amp;, &lt;, &gt;, &quot;, &#039;.
 */
export function stripHtmlTags(html: string): string {
  if (!html) return "";

  // Remove HTML tags
  let text = html.replace(/<[^>]*>/g, "");

  // Decode common HTML entities
  text = text
    .replace(/&amp;/g, "&")
    .replace(/&lt;/g, "<")
    .replace(/&gt;/g, ">")
    .replace(/&quot;/g, '"')
    .replace(/&#039;/g, "'")
    .replace(/&nbsp;/g, " ")
    .replace(/&hellip;/g, "…");

  // Clean up extra whitespace
  text = text.replace(/\s+/g, " ").trim();

  return text;
}

/**
 * Sanitize HTML content from WordPress to prevent XSS attacks.
 * Allows safe tags like <p>, <strong>, <em>, <a>, <ul>, <ol>, <li>, etc.
 * Removes potentially dangerous tags and attributes.
 */
export function sanitizeHtmlContent(html: string): string {
  if (!html) return "";

  return sanitizeHtml(html, {
    allowedTags: [
      "p",
      "br",
      "strong",
      "em",
      "u",
      "a",
      "ul",
      "ol",
      "li",
      "blockquote",
      "h1",
      "h2",
      "h3",
      "h4",
      "h5",
      "h6",
      "img",
      "figure",
      "figcaption",
      "table",
      "thead",
      "tbody",
      "tr",
      "td",
      "th",
      "code",
      "pre",
    ],
    allowedAttributes: {
      a: ["href", "title", "target", "rel"],
      img: ["src", "alt", "title", "width", "height"],
      code: ["class"],
      pre: ["class"],
    },
    allowedSchemes: ["http", "https", "mailto"],
    disallowedTagsMode: "discard",
  });
}
