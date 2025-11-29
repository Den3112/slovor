/**
 * Not found (404) page.
 * Displayed when a route does not exist.
 */
export default function NotFound() {
  return (
    <div className="flex min-h-[60vh] items-center justify-center">
      <div className="text-center">
        <h1 className="mb-4 text-5xl font-bold text-white">404</h1>
        <h2 className="mb-4 text-2xl font-semibold text-slate-100">
          Page not found
        </h2>
        <p className="mb-8 max-w-md text-slate-400">
          Sorry, the page you're looking for doesn't exist. It may have been
          moved or deleted.
        </p>
        <a
          href="/"
          className="inline-flex items-center rounded-lg bg-blue-600 px-6 py-3 font-medium text-white hover:bg-blue-700 transition-colors"
        >
          Back to home
        </a>
      </div>
    </div>
  );
}
