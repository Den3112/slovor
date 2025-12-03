/**
 * Lightweight fetch wrapper for the future WordPress API.
 */

export interface ApiErrorPayload {
  code?: string;
  message?: string;
  data?: unknown;
}

export class ApiError extends Error {
  public readonly status: number;
  public readonly payload: ApiErrorPayload | null;

  constructor(message: string, status: number, payload: ApiErrorPayload | null) {
    super(message);
    this.name = "ApiError";
    this.status = status;
    this.payload = payload;
  }

  /**
   * Check if this is a client error (4xx)
   */
  public isClientError(): boolean {
    return this.status >= 400 && this.status < 500;
  }

  /**
   * Check if this is a server error (5xx)
   */
  public isServerError(): boolean {
    return this.status >= 500;
  }

  /**
   * Check if this is a not found error
   */
  public isNotFound(): boolean {
    return this.status === 404;
  }
}

/**
 * Request initialization options with additional type safety
 */
export interface ApiRequestInit extends Omit<RequestInit, "body"> {
  body?: unknown;
}

/**
 * Creates a typed API client bound to a base URL.
 */
export function createApiClient(
  baseUrl: string
): <T>(path: string, init?: ApiRequestInit) => Promise<T> {
  const normalizedBase = baseUrl.replace(/\/$/, "");

  return async function request<T>(path: string, init?: ApiRequestInit): Promise<T> {
    const url = `${normalizedBase}${path}`;

    // Prepare headers
    const headers = new Headers({
      Accept: "application/json",
      "Content-Type": "application/json",
      ...init?.headers,
    });

    // Prepare body
    let body: BodyInit | undefined;
    if (init?.body !== undefined) {
      if (typeof init.body === "string") {
        body = init.body;
        headers.set("Content-Type", "application/x-www-form-urlencoded");
      } else {
        body = JSON.stringify(init.body);
      }
    }

    const response = await fetch(url, {
      ...init,
      headers,
      body,
    });

    let payload: ApiErrorPayload | null = null;
    try {
      payload = await response.json();
    } catch {
      // If JSON parsing fails, payload remains null
    }

    if (!response.ok) {
      const errorMessage = payload?.message || `API request failed with status ${response.status}`;
      throw new ApiError(errorMessage, response.status, payload);
    }

    return payload as T;
  };
}
