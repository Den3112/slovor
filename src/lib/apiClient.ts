/**
 * Lightweight fetch wrapper for the future WordPress API.
 */
export class ApiError extends Error {
  status: number;
  payload: unknown;

  constructor(message: string, status: number, payload: unknown) {
    super(message);
    this.name = "ApiError";
    this.status = status;
    this.payload = payload;
  }
}

/**
 * Creates a typed API client bound to a base URL.
 */
export function createApiClient(baseUrl: string) {
  const normalizedBase = baseUrl.replace(/\/$/, "");

  return async function request<T>(path: string, init?: RequestInit): Promise<T> {
    const response = await fetch(`${normalizedBase}${path}`, {
      headers: {
        Accept: "application/json",
        "Content-Type": "application/json",
        ...init?.headers,
      },
      ...init,
    });

    const payload = await response.json().catch(() => null);

    if (!response.ok) {
      throw new ApiError("API request failed", response.status, payload);
    }

    return payload as T;
  };
}
