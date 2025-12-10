import Link from 'next/link'

export default function NotFound() {
  return (
    <html lang="sk">
      <body>
        <main className="min-h-screen flex flex-col items-center justify-center p-8 gradient-purple text-white">
          <div className="text-center max-w-2xl">
            <h1 className="text-8xl font-bold mb-4">404</h1>
            <h2 className="text-3xl font-semibold mb-6">Page Not Found</h2>
            <p className="text-xl mb-8 opacity-90">
              The page you are looking for does not exist.
            </p>
            <Link
              href="/"
              className="inline-block bg-white text-purple-600 px-8 py-3 rounded-lg font-semibold hover:bg-opacity-90 transition-all"
            >
              Go Home
            </Link>
          </div>
        </main>
      </body>
    </html>
  )
}
