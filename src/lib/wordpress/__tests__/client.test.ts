/**
 * Tests for WordPress API client functions
 */

// Set environment variable before importing the module
process.env.NEXT_PUBLIC_WP_BASE = "https://api.wordpress.com/wp-json/wp/v2";

// Mock validation functions before importing client
jest.doMock("../validation", () => ({
  validateWordPressPosts: jest.fn(),
  validateWordPressPost: jest.fn(),
  validateWordPressBaseUrl: jest.fn(() => true), // Return true by default
}));

import { fetchPosts, fetchPost } from "../client";
import {
  validateWordPressPosts,
  validateWordPressPost,
  validateWordPressBaseUrl,
} from "../validation";
import { ZodError } from "zod";

// Mock fetch
const mockFetch = jest.fn();
global.fetch = mockFetch;

// Get the mocked functions
const mockValidateWordPressPosts = validateWordPressPosts as jest.MockedFunction<
  typeof validateWordPressPosts
>;
const mockValidateWordPressPost = validateWordPressPost as jest.MockedFunction<
  typeof validateWordPressPost
>;
const mockValidateWordPressBaseUrl = jest.mocked(validateWordPressBaseUrl);

describe("WordPress Client", () => {
  beforeEach(() => {
    mockFetch.mockClear();
    mockValidateWordPressPosts.mockClear();
    mockValidateWordPressPost.mockClear();
    mockValidateWordPressBaseUrl.mockReturnValue(true);

    // Set up environment variable
    process.env.NEXT_PUBLIC_WP_BASE = "https://api.wordpress.com/wp-json/wp/v2";
  });

  afterEach(() => {
    delete process.env.NEXT_PUBLIC_WP_BASE;
  });

  describe("fetchPosts", () => {
    const mockPosts = [
      {
        id: 1,
        date: "2023-01-01T00:00:00",
        date_gmt: "2023-01-01T00:00:00",
        modified: "2023-01-01T00:00:00",
        modified_gmt: "2023-01-01T00:00:00",
        slug: "post-1",
        status: "publish" as const,
        type: "post",
        link: "https://example.com/post-1",
        title: { rendered: "Post 1" },
        content: { rendered: "<p>Content 1</p>" },
        excerpt: { rendered: "<p>Excerpt 1</p>" },
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
      },
      {
        id: 2,
        date: "2023-01-02T00:00:00",
        date_gmt: "2023-01-02T00:00:00",
        modified: "2023-01-02T00:00:00",
        modified_gmt: "2023-01-02T00:00:00",
        slug: "post-2",
        status: "publish" as const,
        type: "post",
        link: "https://example.com/post-2",
        title: { rendered: "Post 2" },
        content: { rendered: "<p>Content 2</p>" },
        excerpt: { rendered: "<p>Excerpt 2</p>" },
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
      },
    ];

    it("should fetch and validate posts successfully", async () => {
      mockFetch.mockResolvedValueOnce({
        ok: true,
        json: () => Promise.resolve(mockPosts),
      });

      mockValidateWordPressPosts.mockReturnValue({
        success: true,
        data: mockPosts,
      });

      const result = await fetchPosts();

      expect(mockFetch).toHaveBeenCalledWith("https://api.wordpress.com/wp-json/wp/v2/posts", {
        next: { revalidate: 60 },
      });
      expect(mockValidateWordPressPosts).toHaveBeenCalledWith(mockPosts);
      expect(result).toEqual(mockPosts);
    });

    it("should return empty array when validation fails", async () => {
      mockFetch.mockResolvedValueOnce({
        ok: true,
        json: () => Promise.resolve(mockPosts),
      });

      mockValidateWordPressPosts.mockReturnValue({
        success: false,
        // eslint-disable-next-line @typescript-eslint/no-explicit-any
        error: new ZodError([]) as any,
      });

      const result = await fetchPosts();

      expect(result).toEqual([]);
    });

    it("should return empty array on HTTP error", async () => {
      mockFetch.mockResolvedValueOnce({
        ok: false,
        status: 404,
      });

      const result = await fetchPosts();

      expect(result).toEqual([]);
    });

    it("should return empty array on network error", async () => {
      mockFetch.mockRejectedValueOnce(new Error("Network error"));

      const result = await fetchPosts();

      expect(result).toEqual([]);
    });

    it("should return empty array when WP_BASE is not set", async () => {
      delete process.env.NEXT_PUBLIC_WP_BASE;

      const result = await fetchPosts();

      expect(mockFetch).not.toHaveBeenCalled();
      expect(result).toEqual([]);
    });

    it("should handle malformed JSON response", async () => {
      mockFetch.mockResolvedValueOnce({
        ok: true,
        json: () => Promise.reject(new Error("Invalid JSON")),
      });

      const result = await fetchPosts();

      expect(result).toEqual([]);
    });
  });

  describe("fetchPost", () => {
    const mockPost = {
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
      content: { rendered: "<p>Test content</p>" },
      excerpt: { rendered: "<p>Test excerpt</p>" },
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

    it("should fetch and validate single post successfully", async () => {
      mockFetch.mockResolvedValueOnce({
        ok: true,
        json: () => Promise.resolve(mockPost),
      });

      mockValidateWordPressPost.mockReturnValue({
        success: true,
        data: mockPost,
      });

      const result = await fetchPost(1);

      expect(mockFetch).toHaveBeenCalledWith("https://api.wordpress.com/wp-json/wp/v2/posts/1", {
        next: { revalidate: 60 },
      });
      expect(mockValidateWordPressPost).toHaveBeenCalledWith(mockPost);
      expect(result).toEqual(mockPost);
    });

    it("should fetch post by string ID", async () => {
      mockFetch.mockResolvedValueOnce({
        ok: true,
        json: () => Promise.resolve(mockPost),
      });

      mockValidateWordPressPost.mockReturnValue({
        success: true,
        data: mockPost,
      });

      const result = await fetchPost("test-slug");

      expect(mockFetch).toHaveBeenCalledWith(
        "https://api.wordpress.com/wp-json/wp/v2/posts/test-slug",
        { next: { revalidate: 60 } }
      );
      expect(result).toEqual(mockPost);
    });

    it("should return null when validation fails", async () => {
      mockFetch.mockResolvedValueOnce({
        ok: true,
        json: () => Promise.resolve(mockPost),
      });

      mockValidateWordPressPost.mockReturnValue({
        success: false,
        // eslint-disable-next-line @typescript-eslint/no-explicit-any
        error: new ZodError([]) as any,
      });

      const result = await fetchPost(1);

      expect(result).toBeNull();
    });

    it("should return null on HTTP error", async () => {
      mockFetch.mockResolvedValueOnce({
        ok: false,
        status: 404,
      });

      const result = await fetchPost(1);

      expect(result).toBeNull();
    });

    it("should return null on network error", async () => {
      mockFetch.mockRejectedValueOnce(new Error("Network error"));

      const result = await fetchPost(1);

      expect(result).toBeNull();
    });

    it("should return null when WP_BASE is not set", async () => {
      delete process.env.NEXT_PUBLIC_WP_BASE;

      const result = await fetchPost(1);

      expect(mockFetch).not.toHaveBeenCalled();
      expect(result).toBeNull();
    });

    it("should reject invalid ID types", async () => {
      // @ts-expect-error Testing invalid input
      const result = await fetchPost({ invalid: "id" });

      expect(mockFetch).not.toHaveBeenCalled();
      expect(result).toBeNull();
    });

    it("should handle malformed JSON response", async () => {
      mockFetch.mockResolvedValueOnce({
        ok: true,
        json: () => Promise.reject(new Error("Invalid JSON")),
      });

      const result = await fetchPost(1);

      expect(result).toBeNull();
    });
  });

  describe("Environment variable handling", () => {
    it("should handle missing NEXT_PUBLIC_WP_BASE", async () => {
      delete process.env.NEXT_PUBLIC_WP_BASE;

      const postsResult = await fetchPosts();
      const postResult = await fetchPost(1);

      expect(postsResult).toEqual([]);
      expect(postResult).toBeNull();
      expect(mockFetch).not.toHaveBeenCalled();
    });

    it("should handle invalid NEXT_PUBLIC_WP_BASE", async () => {
      // Mock the validation to return false
      mockValidateWordPressBaseUrl.mockReturnValueOnce(false);

      const postsResult = await fetchPosts();
      const postResult = await fetchPost(1);

      expect(postsResult).toEqual([]);
      expect(postResult).toBeNull();
      expect(mockFetch).not.toHaveBeenCalled();
    });

    it("should warn when NEXT_PUBLIC_WP_BASE is not set", async () => {
      const consoleWarnSpy = jest.spyOn(console, "warn").mockImplementation();
      delete process.env.NEXT_PUBLIC_WP_BASE;

      // Re-import the module to trigger the validation at load time
      jest.resetModules();
      const { fetchPosts: freshFetchPosts } = await import("../client");

      const result = await freshFetchPosts();

      expect(consoleWarnSpy).toHaveBeenCalledWith(
        expect.stringContaining("Missing environment variable: NEXT_PUBLIC_WP_BASE")
      );
      expect(result).toEqual([]);

      consoleWarnSpy.mockRestore();
    });

    it("should warn when NEXT_PUBLIC_WP_BASE is invalid", async () => {
      const consoleWarnSpy = jest.spyOn(console, "warn").mockImplementation();
      process.env.NEXT_PUBLIC_WP_BASE = "invalid-url";

      // Mock validation to return false for this invalid URL
      mockValidateWordPressBaseUrl.mockReturnValueOnce(false);

      // Re-import the module to trigger the validation at load time
      jest.resetModules();
      const { fetchPosts: freshFetchPosts } = await import("../client");

      const result = await freshFetchPosts();

      expect(consoleWarnSpy).toHaveBeenCalledWith(
        expect.stringContaining("Invalid NEXT_PUBLIC_WP_BASE URL")
      );
      expect(result).toEqual([]);

      consoleWarnSpy.mockRestore();
    });
  });

  describe("Error handling", () => {
    it("should handle fetch timeouts", async () => {
      mockFetch.mockImplementationOnce(
        () =>
          new Promise((_, reject) => {
            setTimeout(() => reject(new Error("Timeout")), 100);
          })
      );

      const result = await fetchPosts();

      expect(result).toEqual([]);
    });

    it("should handle unexpected errors gracefully", async () => {
      mockFetch.mockRejectedValueOnce(new Error("Unexpected error"));

      const postsResult = await fetchPosts();
      const postResult = await fetchPost(1);

      expect(postsResult).toEqual([]);
      expect(postResult).toBeNull();
    });
  });
});
