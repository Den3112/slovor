'use client'

export default function Error({
  error,
  reset,
}: {
  error: Error & { digest?: string }
  reset: () => void
}) {
  return (
    <html lang="sk">
      <body>
        <main className="min-h-screen flex flex-col items-center justify-center p-8 gradient-purple text-white">
          <div className="text-center max-w-2xl">
            <h1 className="text-6xl font-bold mb-4">Oops!</h1>
            <h2 className="text-3xl font-semibold mb-6">Something went wrong</h2>
            <p className="text-xl mb-8 opacity-90">
              {error.message || 'An unexpected error occurred'}
            </p>
            <button
              onClick={reset}
              className="inline-block bg-white text-purple-600 px-8 py-3 rounded-lg font-semibold hover:bg-opacity-90 transition-all"
            >
              Try Again
            </button>
          </div>
        </main>
      </body>
    </html>
  )
}
