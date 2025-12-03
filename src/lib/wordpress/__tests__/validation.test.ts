/**
 * Tests for WordPress API validation functions
 */

import {
  validateWordPressPost,
  validateWordPressPosts,
  validateWordPressBaseUrl,
} from "../validation";

describe("WordPress Validation", () => {
  describe("validateWordPressBaseUrl", () => {
    it("should validate valid HTTP URLs", () => {
      expect(validateWordPressBaseUrl("http://example.com")).toBe(true);
      expect(validateWordPressBaseUrl("https://example.com")).toBe(true);
      expect(validateWordPressBaseUrl("https://api.wordpress.com")).toBe(true);
    });

    it("should reject invalid URLs", () => {
      expect(validateWordPressBaseUrl("")).toBe(false);
      expect(validateWordPressBaseUrl(undefined)).toBe(false);
      expect(validateWordPressBaseUrl("not-a-url")).toBe(false);
      expect(validateWordPressBaseUrl("ftp://example.com")).toBe(false);
      expect(validateWordPressBaseUrl("http://")).toBe(false);
    });
  });

  describe("validateWordPressPost", () => {
    const validPost = {
      id: 1,
      date: "2023-01-01T00:00:00",
      date_gmt: "2023-01-01T00:00:00",
      modified: "2023-01-01T00:00:00",
      modified_gmt: "2023-01-01T00:00:00",
      slug: "test-post",
      status: "publish" as const,
      type: "post",
      link: "https://example.com/test-post",
      title: { rendered: "Test Post", raw: "Test Post" },
      content: { rendered: "<p>Content</p>", raw: "Content" },
      excerpt: { rendered: "<p>Excerpt</p>", raw: "Excerpt" },
      author: 1,
      featured_media: 0,
      comment_status: "open" as const,
      ping_status: "closed" as const,
      sticky: false,
      template: "",
      format: "standard" as const,
      meta: {},
      categories: [1],
      tags: [],
      guid: { rendered: "https://example.com/?p=1" },
      menu_order: 0,
    };

    it("should validate a complete valid post", () => {
      const result = validateWordPressPost(validPost);
      expect(result.success).toBe(true);
      if (result.success) {
        expect(result.data.id).toBe(1);
        expect(result.data.title.rendered).toBe("Test Post");
      }
    });

    it("should validate post with minimal required fields", () => {
      const minimalPost = {
        id: 1,
        date: "2023-01-01T00:00:00",
        date_gmt: "2023-01-01T00:00:00",
        modified: "2023-01-01T00:00:00",
        modified_gmt: "2023-01-01T00:00:00",
        slug: "test-post",
        status: "publish" as const,
        type: "post",
        link: "https://example.com/test-post",
        title: { rendered: "Test Post" },
        content: { rendered: "<p>Content</p>" },
        excerpt: { rendered: "<p>Excerpt</p>" },
        author: 1,
        featured_media: 0,
        comment_status: "open" as const,
        ping_status: "closed" as const,
        sticky: false,
        template: "",
        format: "standard" as const,
        meta: {},
        categories: [1],
        tags: [],
      };

      const result = validateWordPressPost(minimalPost);
      expect(result.success).toBe(true);
    });

    it("should reject invalid post data", () => {
      const invalidPosts = [
        null,
        undefined,
        {},
        { id: "not-a-number" },
        { ...validPost, status: "invalid-status" },
        { ...validPost, title: "not-an-object" },
        { ...validPost, categories: "not-an-array" },
      ];

      invalidPosts.forEach((invalidPost) => {
        const result = validateWordPressPost(invalidPost);
        expect(result.success).toBe(false);
      });
    });

    it("should handle embedded data", () => {
      const postWithEmbedded = {
        ...validPost,
        _embedded: {
          author: [
            {
              id: 1,
              name: "Test Author",
              url: "",
              description: "",
              link: "https://example.com/author/test",
              slug: "test",
              avatar_urls: { "96": "https://example.com/avatar.jpg" },
            },
          ],
          "wp:featuredmedia": [
            {
              id: 1,
              date: "2023-01-01T00:00:00",
              slug: "test-image",
              type: "attachment",
              link: "https://example.com/image",
              title: { rendered: "Test Image" },
              author: 1,
              caption: { rendered: "" },
              alt_text: "Test alt",
              media_type: "image",
              mime_type: "image/jpeg",
              media_details: {
                width: 800,
                height: 600,
                file: "test.jpg",
                sizes: {
                  thumbnail: {
                    file: "test-150x150.jpg",
                    width: 150,
                    height: 150,
                    mime_type: "image/jpeg",
                    source_url: "https://example.com/test-150x150.jpg",
                  },
                },
              },
              source_url: "https://example.com/test.jpg",
            },
          ],
        },
      };

      const result = validateWordPressPost(postWithEmbedded);
      expect(result.success).toBe(true);
    });
  });

  describe("validateWordPressPosts", () => {
    const validPost = {
      id: 1,
      date: "2023-01-01T00:00:00",
      date_gmt: "2023-01-01T00:00:00",
      modified: "2023-01-01T00:00:00",
      modified_gmt: "2023-01-01T00:00:00",
      slug: "test-post",
      status: "publish" as const,
      type: "post",
      link: "https://example.com/test-post",
      title: { rendered: "Test Post" },
      content: { rendered: "<p>Content</p>" },
      excerpt: { rendered: "<p>Excerpt</p>" },
      author: 1,
      featured_media: 0,
      comment_status: "open" as const,
      ping_status: "closed" as const,
      sticky: false,
      template: "",
      format: "standard" as const,
      meta: {},
      categories: [1],
      tags: [],
    };

    it("should validate array of valid posts", () => {
      const posts = [validPost, { ...validPost, id: 2, slug: "test-post-2" }];
      const result = validateWordPressPosts(posts);
      expect(result.success).toBe(true);
      if (result.success) {
        expect(result.data).toHaveLength(2);
        expect(result.data[0].id).toBe(1);
        expect(result.data[1].id).toBe(2);
      }
    });

    it("should reject invalid arrays", () => {
      const invalidArrays = [
        null,
        undefined,
        {},
        "not-an-array",
        [validPost, null],
        [validPost, { invalid: "post" }],
      ];

      invalidArrays.forEach((invalidArray) => {
        const result = validateWordPressPosts(invalidArray);
        expect(result.success).toBe(false);
      });
    });

    it("should validate empty array", () => {
      const result = validateWordPressPosts([]);
      expect(result.success).toBe(true);
      if (result.success) {
        expect(result.data).toHaveLength(0);
      }
    });
  });

  describe("Schema validation edge cases", () => {
    it("should handle all post status values", () => {
      const statuses = ["publish", "draft", "pending", "private", "future"] as const;

      statuses.forEach((status) => {
        const post = {
          id: 1,
          date: "2023-01-01T00:00:00",
          date_gmt: "2023-01-01T00:00:00",
          modified: "2023-01-01T00:00:00",
          modified_gmt: "2023-01-01T00:00:00",
          slug: "test-post",
          status,
          type: "post",
          link: "https://example.com/test-post",
          title: { rendered: "Test Post" },
          content: { rendered: "<p>Content</p>" },
          excerpt: { rendered: "<p>Excerpt</p>" },
          author: 1,
          featured_media: 0,
          comment_status: "open" as const,
          ping_status: "closed" as const,
          sticky: false,
          template: "",
          format: "standard" as const,
          meta: {},
          categories: [1],
          tags: [],
        };

        const result = validateWordPressPost(post);
        expect(result.success).toBe(true);
      });
    });

    it("should handle all post format values", () => {
      const formats = [
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
      ] as const;

      formats.forEach((format) => {
        const post = {
          id: 1,
          date: "2023-01-01T00:00:00",
          date_gmt: "2023-01-01T00:00:00",
          modified: "2023-01-01T00:00:00",
          modified_gmt: "2023-01-01T00:00:00",
          slug: "test-post",
          status: "publish" as const,
          type: "post",
          link: "https://example.com/test-post",
          title: { rendered: "Test Post" },
          content: { rendered: "<p>Content</p>" },
          excerpt: { rendered: "<p>Excerpt</p>" },
          author: 1,
          featured_media: 0,
          comment_status: "open" as const,
          ping_status: "closed" as const,
          sticky: false,
          template: "",
          format,
          meta: {},
          categories: [1],
          tags: [],
        };

        const result = validateWordPressPost(post);
        expect(result.success).toBe(true);
      });
    });
  });
});
