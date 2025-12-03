/**
 * Tests for the home page component
 */

import { render, screen, waitFor } from "@testing-library/react";
import HomePage from "../page";
import { fetchPosts } from "@/lib/wordpress/client";

// Mock the WordPress client
jest.mock("@/lib/wordpress/client", () => ({
  fetchPosts: jest.fn(),
}));

const mockFetchPosts = fetchPosts as jest.MockedFunction<typeof fetchPosts>;

describe("HomePage", () => {
  beforeEach(() => {
    mockFetchPosts.mockClear();
  });

  // TODO: Server components in Next.js 16 are difficult to unit test.
  // These tests are skipped and will be covered by E2E tests with Playwright.
  it.skip("should render loading state initially", async () => {
    // Mock fetchPosts to return empty array (simulating loading)
    mockFetchPosts.mockResolvedValueOnce([]);

    render(<HomePage />);

    // Should show the browse categories section
    expect(screen.getByText("Browse by category")).toBeInTheDocument();
    expect(screen.getByText("Find what you need across Slovakia")).toBeInTheDocument();
  });

  it.skip("should render posts when available", async () => {
    const mockPosts = [
      {
        id: 1,
        date: "2023-01-01T00:00:00",
        date_gmt: "2023-01-01T00:00:00",
        modified: "2023-01-01T00:00:00",
        modified_gmt: "2023-01-01T00:00:00",
        slug: "test-post-1",
        status: "publish" as const,
        type: "post",
        link: "https://example.com/test-post-1",
        title: { rendered: "Test Post 1" },
        content: { rendered: "<p>Content 1</p>" },
        excerpt: { rendered: "<p>This is a test post excerpt.</p>" },
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
        slug: "test-post-2",
        status: "publish" as const,
        type: "post",
        link: "https://example.com/test-post-2",
        title: { rendered: "Test Post 2" },
        content: { rendered: "<p>Content 2</p>" },
        excerpt: { rendered: "<p>Another test post excerpt.</p>" },
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

    mockFetchPosts.mockResolvedValueOnce(mockPosts);

    render(<HomePage />);

    // Wait for posts to be rendered
    await waitFor(() => {
      expect(screen.getByText("Test Post 1")).toBeInTheDocument();
    });

    expect(screen.getByText("Test Post 2")).toBeInTheDocument();
    expect(screen.getAllByText("Read post")).toHaveLength(2);
  });

  it.skip('should render "No posts found" when posts array is empty', async () => {
    mockFetchPosts.mockResolvedValueOnce([]);

    render(<HomePage />);

    await waitFor(() => {
      expect(screen.getByText("No posts found.")).toBeInTheDocument();
    });
  });

  it.skip("should handle fetchPosts errors gracefully", async () => {
    mockFetchPosts.mockRejectedValueOnce(new Error("API Error"));

    render(<HomePage />);

    await waitFor(() => {
      expect(screen.getByText("No posts found.")).toBeInTheDocument();
    });
  });

  it.skip("should sanitize HTML content in post titles", async () => {
    const mockPosts = [
      {
        id: 1,
        date: "2023-01-01T00:00:00",
        date_gmt: "2023-01-01T00:00:00",
        modified: "2023-01-01T00:00:00",
        modified_gmt: "2023-01-01T00:00:00",
        slug: "test-post",
        status: "publish" as const,
        type: "post",
        link: "https://example.com/test-post",
        title: { rendered: 'Test Post with <script>alert("xss")</script>HTML' },
        content: { rendered: "<p>Content</p>" },
        excerpt: { rendered: "<p>Safe excerpt</p>" },
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

    mockFetchPosts.mockResolvedValueOnce(mockPosts);

    render(<HomePage />);

    await waitFor(() => {
      // The script tag should be sanitized/removed
      const titleElement = screen.getByText(
        (content) => content.includes("Test Post with") && !content.includes("<script>")
      );
      expect(titleElement).toBeInTheDocument();
    });
  });

  it.skip("should strip HTML tags from excerpts", async () => {
    const mockPosts = [
      {
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
        excerpt: {
          rendered: '<p>This is <strong>bold</strong> text with <a href="#">link</a></p>',
        },
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

    mockFetchPosts.mockResolvedValueOnce(mockPosts);

    render(<HomePage />);

    await waitFor(() => {
      // HTML tags should be stripped from excerpt
      expect(screen.getByText("This is bold text with link")).toBeInTheDocument();
    });
  });

  it.skip("should render the correct page structure", async () => {
    mockFetchPosts.mockResolvedValueOnce([]);

    render(<HomePage />);

    // Check main heading
    expect(screen.getByText("Find what you need across Slovakia")).toBeInTheDocument();

    // Check description
    expect(
      screen.getByText("Discover vehicles, homes, jobs, services, and more—all in one place.")
    ).toBeInTheDocument();

    // Check grid layout (should exist even with no posts)
    const grid = document.querySelector(".grid");
    expect(grid).toBeInTheDocument();
  });
});
