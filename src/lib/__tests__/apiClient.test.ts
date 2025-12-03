/**
 * Tests for API client functions
 */

import { createApiClient, ApiError } from "../apiClient";

// Mock fetch
const mockFetch = jest.fn();
global.fetch = mockFetch;

describe("API Client", () => {
  beforeEach(() => {
    mockFetch.mockClear();
  });

  describe("createApiClient", () => {
    const client = createApiClient("https://api.example.com");

    it("should create a request function", () => {
      expect(typeof client).toBe("function");
    });

    it("should make successful GET requests", async () => {
      const mockResponse = { data: "test" };
      mockFetch.mockResolvedValueOnce({
        ok: true,
        json: () => Promise.resolve(mockResponse),
      });

      const result = await client("/test");
      expect(result).toEqual(mockResponse);
      expect(mockFetch).toHaveBeenCalledWith("https://api.example.com/test", {
        headers: expect.any(Headers),
        body: undefined,
      });
    });

    it("should handle POST requests with JSON body", async () => {
      const mockResponse = { success: true };
      const requestBody = { name: "test" };

      mockFetch.mockResolvedValueOnce({
        ok: true,
        json: () => Promise.resolve(mockResponse),
      });

      const result = await client("/test", {
        method: "POST",
        body: requestBody,
      });

      expect(result).toEqual(mockResponse);
      expect(mockFetch).toHaveBeenCalledWith("https://api.example.com/test", {
        method: "POST",
        headers: expect.any(Headers),
        body: JSON.stringify(requestBody),
      });
    });

    it("should handle POST requests with string body", async () => {
      const mockResponse = { success: true };
      const requestBody = "name=test";

      mockFetch.mockResolvedValueOnce({
        ok: true,
        json: () => Promise.resolve(mockResponse),
      });

      const result = await client("/test", {
        method: "POST",
        body: requestBody,
      });

      expect(result).toEqual(mockResponse);
      expect(mockFetch).toHaveBeenCalledWith("https://api.example.com/test", {
        method: "POST",
        headers: expect.any(Headers),
        body: requestBody,
      });
    });

    it("should handle custom headers", async () => {
      const mockResponse = { data: "test" };
      mockFetch.mockResolvedValueOnce({
        ok: true,
        json: () => Promise.resolve(mockResponse),
      });

      const result = await client("/test", {
        headers: {
          "X-Custom": "value",
          Authorization: "Bearer token",
        },
      });

      expect(result).toEqual(mockResponse);
      const callArgs = mockFetch.mock.calls[0][1];
      expect(callArgs.headers.get("X-Custom")).toBe("value");
      expect(callArgs.headers.get("Authorization")).toBe("Bearer token");
      expect(callArgs.headers.get("Accept")).toBe("application/json");
    });

    it("should throw ApiError on HTTP errors", async () => {
      const errorResponse = { code: "not_found", message: "Resource not found" };
      mockFetch.mockResolvedValueOnce({
        ok: false,
        status: 404,
        json: () => Promise.resolve(errorResponse),
      });

      await expect(client("/not-found")).rejects.toThrow(ApiError);
      await expect(client("/not-found")).rejects.toThrow("API request failed with status 404");
    });

    it("should handle network errors", async () => {
      const networkError = new Error("Network error");
      mockFetch.mockRejectedValueOnce(networkError);

      await expect(client("/test")).rejects.toThrow(networkError);
    });

    it("should handle malformed JSON responses", async () => {
      mockFetch.mockResolvedValueOnce({
        ok: true,
        json: () => Promise.reject(new Error("Invalid JSON")),
      });

      await expect(client("/test")).rejects.toThrow("Invalid JSON");
    });

    it("should handle responses without JSON", async () => {
      mockFetch.mockResolvedValueOnce({
        ok: false,
        status: 500,
        json: () => Promise.reject(new Error("No JSON")),
      });

      await expect(client("/test")).rejects.toThrow(ApiError);
      await expect(client("/test")).rejects.toThrow("API request failed with status 500");
    });
  });

  describe("ApiError", () => {
    it("should create error with status and payload", () => {
      const payload = { code: "error", message: "Something went wrong" };
      const error = new ApiError("Test error", 400, payload);

      expect(error.message).toBe("Test error");
      expect(error.status).toBe(400);
      expect(error.payload).toEqual(payload);
      expect(error.name).toBe("ApiError");
    });

    it("should handle null payload", () => {
      const error = new ApiError("Test error", 500, null);

      expect(error.message).toBe("Test error");
      expect(error.status).toBe(500);
      expect(error.payload).toBeNull();
    });

    describe("Error type checks", () => {
      it("should identify client errors", () => {
        const error = new ApiError("Bad request", 400, null);
        expect(error.isClientError()).toBe(true);
        expect(error.isServerError()).toBe(false);
        expect(error.isNotFound()).toBe(false);
      });

      it("should identify server errors", () => {
        const error = new ApiError("Server error", 500, null);
        expect(error.isClientError()).toBe(false);
        expect(error.isServerError()).toBe(true);
        expect(error.isNotFound()).toBe(false);
      });

      it("should identify not found errors", () => {
        const error = new ApiError("Not found", 404, null);
        expect(error.isClientError()).toBe(true);
        expect(error.isServerError()).toBe(false);
        expect(error.isNotFound()).toBe(true);
      });

      it("should handle other status codes", () => {
        const error = new ApiError("Success", 200, null);
        expect(error.isClientError()).toBe(false);
        expect(error.isServerError()).toBe(false);
        expect(error.isNotFound()).toBe(false);
      });
    });
  });

  describe("Request configuration", () => {
    const client = createApiClient("https://api.example.com");

    it("should set default headers", async () => {
      mockFetch.mockResolvedValueOnce({
        ok: true,
        json: () => Promise.resolve({}),
      });

      await client("/test");

      const callArgs = mockFetch.mock.calls[0][1];
      expect(callArgs.headers.get("Accept")).toBe("application/json");
      expect(callArgs.headers.get("Content-Type")).toBe("application/json");
    });

    it("should override Content-Type for string bodies", async () => {
      mockFetch.mockResolvedValueOnce({
        ok: true,
        json: () => Promise.resolve({}),
      });

      await client("/test", {
        method: "POST",
        body: "key=value",
      });

      const callArgs = mockFetch.mock.calls[0][1];
      expect(callArgs.headers.get("Content-Type")).toBe("application/x-www-form-urlencoded");
    });

    it("should preserve other request options", async () => {
      mockFetch.mockResolvedValueOnce({
        ok: true,
        json: () => Promise.resolve({}),
      });

      await client("/test", {
        method: "PUT",
        mode: "cors",
        credentials: "include",
      });

      const callArgs = mockFetch.mock.calls[0][1];
      expect(callArgs.method).toBe("PUT");
      expect(callArgs.mode).toBe("cors");
      expect(callArgs.credentials).toBe("include");
    });
  });
});
