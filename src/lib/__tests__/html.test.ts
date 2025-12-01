import { stripHtmlTags, sanitizeHtmlContent } from "../html";

describe("HTML utilities", () => {
  describe("stripHtmlTags", () => {
    it("should remove HTML tags", () => {
      const input = "<p>Hello <strong>world</strong></p>";
      const result = stripHtmlTags(input);
      expect(result).toBe("Hello world");
    });

    it("should decode HTML entities", () => {
      const input = "Hello &amp; goodbye &lt;tag&gt;";
      const result = stripHtmlTags(input);
      expect(result).toBe("Hello & goodbye <tag>");
    });

    it("should handle empty strings", () => {
      expect(stripHtmlTags("")).toBe("");
      // eslint-disable-next-line @typescript-eslint/no-explicit-any
      expect(stripHtmlTags(null as any)).toBe("");
    });

    it("should clean up extra whitespace", () => {
      const input = "<p>Hello    <br/>    world</p>";
      const result = stripHtmlTags(input);
      expect(result).toBe("Hello world");
    });
  });

  describe("sanitizeHtmlContent", () => {
    it("should allow safe HTML tags", () => {
      const input = "<p>Hello <strong>world</strong></p>";
      const result = sanitizeHtmlContent(input);
      expect(result).toContain("<p>");
      expect(result).toContain("<strong>");
    });

    it("should remove script tags", () => {
      const input = '<p>Hello</p><script>alert("xss")</script>';
      const result = sanitizeHtmlContent(input);
      expect(result).not.toContain("<script>");
      expect(result).not.toContain("alert");
    });

    it("should remove event handlers", () => {
      const input = "<p onclick=\"alert('xss')\">Click me</p>";
      const result = sanitizeHtmlContent(input);
      expect(result).not.toContain("onclick");
    });

    it("should allow safe links", () => {
      const input = '<a href="https://example.com">Link</a>';
      const result = sanitizeHtmlContent(input);
      expect(result).toContain("<a");
      expect(result).toContain("href");
    });

    it("should handle empty strings", () => {
      expect(sanitizeHtmlContent("")).toBe("");
      // eslint-disable-next-line @typescript-eslint/no-explicit-any
      expect(sanitizeHtmlContent(null as any)).toBe("");
    });
  });
});
