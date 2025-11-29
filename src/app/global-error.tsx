"use client";

/**
 * Global error boundary component.
 * Handles uncaught errors in the application.
 */
export default function GlobalError({
  error,
  reset,
}: {
  error: Error & { digest?: string };
  reset: () => void;
}) {
  return (
    <html>
      <body>
        <div className="flex min-h-screen items-center justify-center bg-slate-950 px-4">
          <div className="max-w-md text-center">
            <h1 className="mb-4 text-4xl font-bold text-white">
              Something went wrong
            </h1>
            <p className="mb-6 text-slate-400">
              An unexpected error occurred. Our team has been notified.
            </p>
            <p className="mb-6 text-sm text-slate-500">
              Error ID: {error.digest || "unknown"}
            </p>
            <button
              onClick={() => reset()}
              className="inline-flex items-center rounded-lg bg-blue-600 px-6 py-3 font-medium text-white hover:bg-blue-700 transition-colors"
            >
              Try again
            </button>
          </div>
        </div>
      </body>
    </html>
  );
}
