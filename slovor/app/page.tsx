import type { Metadata } from 'next'

export const metadata: Metadata = {
  title: 'Slovor - Home',
  description: 'Welcome to Slovor marketplace platform',
}

export default function Home() {
  return (
    <main className="min-h-screen flex flex-col items-center justify-center p-8 gradient-purple text-white">
      <div className="text-center max-w-3xl">
        {/* Header */}
        <h1 className="text-6xl md:text-7xl font-bold mb-4">
          Slovor 📚
        </h1>
        <p className="text-xl md:text-2xl mb-12 opacity-90">
          Marketplace Platform for Slovakia
        </p>

        {/* Status Card */}
        <div className="bg-white/10 backdrop-blur-lg rounded-2xl p-8 shadow-2xl">
          <h2 className="text-2xl font-semibold mb-4 flex items-center justify-center gap-2">
            ✅ Phase 1 Complete!
          </h2>
          
          <div className="space-y-3 text-lg">
            <p>
              <span className="font-medium">Current Phase:</span> Foundation Complete
            </p>
            <p>
              <span className="font-medium">Status:</span> Ready for Phase 2
            </p>
            <p className="opacity-80">
              <span className="font-medium">Deployment:</span> Production Ready
            </p>
          </div>
        </div>

        {/* Footer */}
        <p className="mt-8 opacity-70 text-sm">
          Built with Next.js 14 + TypeScript + Supabase
        </p>
      </div>
    </main>
  )
}
