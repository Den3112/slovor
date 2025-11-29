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
