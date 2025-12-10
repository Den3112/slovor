import type { Metadata } from 'next'
import './globals.css'

export const metadata: Metadata = {
  title: 'Slovor - Marketplace for Slovakia',
  description: 'Interactive marketplace platform for Slovakia built with Next.js 14, TypeScript, and Supabase',
  keywords: ['marketplace', 'slovakia', 'slovor', 'next.js', 'supabase'],
  authors: [{ name: 'Den3112' }],
  openGraph: {
    title: 'Slovor - Marketplace for Slovakia',
    description: 'Interactive marketplace platform for Slovakia',
    type: 'website',
    locale: 'sk_SK',
  },
}

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode
}>) {
  return (
    <html lang="sk">
      <body className="antialiased">{children}</body>
    </html>
  )
}
