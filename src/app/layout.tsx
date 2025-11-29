import type { Metadata, Viewport } from "next";
import { Geist, Geist_Mono } from "next/font/google";
import "./globals.css";
import { ThemeToggle } from "../components/theme-toggle";

const geistSans = Geist({
  variable: "--font-geist-sans",
  subsets: ["latin"],
});

const geistMono = Geist_Mono({
  variable: "--font-geist-mono",
  subsets: ["latin"],
});

export const metadata: Metadata = {
  title: "Slovor Marketplace | Buy & Sell Classifieds in Slovakia",
  description: "Buy and sell items locally in Slovakia. Browse categories, post ads, and connect with local buyers and sellers.",
  keywords: ["classifieds", "marketplace", "buy", "sell", "Slovakia", "local"],
  authors: [{ name: "Slovor Team" }],
  creator: "Slovor",
  publisher: "Slovor",
  robots: {
    index: true,
    follow: true,
    "max-image-preview": "large",
    "max-snippet": -1,
    "max-video-preview": -1,
  },
  openGraph: {
    type: "website",
    locale: "en_US",
    url: "https://slovor.sk",
    title: "Slovor Marketplace | Buy & Sell Classifieds in Slovakia",
    description: "Buy and sell items locally in Slovakia. Browse categories, post ads, and connect with local buyers and sellers.",
    siteName: "Slovor",
    images: [
      {
        url: "https://slovor.sk/og-image.png",
        width: 1200,
        height: 630,
        alt: "Slovor Marketplace",
      },
    ],
  },
  twitter: {
    card: "summary_large_image",
    title: "Slovor Marketplace",
    description: "Buy and sell items locally in Slovakia",
  },
  alternates: {
    canonical: "https://slovor.sk",
  },
};

export const viewport: Viewport = {
  width: "device-width",
  initialScale: 1,
  maximumScale: 5,
  userScalable: true,
  colorScheme: "dark",
  themeColor: [
    { media: "(prefers-color-scheme: light)", color: "#ffffff" },
    { media: "(prefers-color-scheme: dark)", color: "#020617" },
  ],
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html
      lang="en"
      className={`${geistSans.variable} ${geistMono.variable} antialiased scroll-smooth`}
      suppressHydrationWarning
    >
      <head>
        <meta charSet="utf-8" />
        <link rel="icon" href="/favicon.ico" />
        <meta name="apple-mobile-web-app-capable" content="yes" />
        <meta name="apple-mobile-web-app-status-bar-style" content="black-translucent" />
      </head>
      <body className="min-h-screen bg-white text-gray-900 dark:bg-slate-950 dark:text-slate-50">
        <div className="flex min-h-screen flex-col bg-white/90 text-gray-900 dark:bg-slate-950 dark:text-slate-50">
          <header
            className="border-b border-slate-200 bg-white/80 px-4 py-4 shadow-sm backdrop-blur-sm dark:border-slate-800 dark:bg-slate-900/80"
            role="banner"
          >
            <div className="mx-auto flex w-full max-w-6xl items-center justify-between gap-4">
              <a href="/" className="text-2xl font-semibold text-brand hover:opacity-80 transition-opacity">
                Slovor
              </a>
              <nav className="flex items-center gap-6 text-sm font-medium text-slate-600 dark:text-slate-300" role="navigation" aria-label="Main navigation">
                <a href="#" className="transition hover:text-brand dark:hover:text-brand-light focus-visible:outline-2 focus-visible:outline-offset-2">
                  Browse
                </a>
                <a href="#" className="transition hover:text-brand dark:hover:text-brand-light focus-visible:outline-2 focus-visible:outline-offset-2">
                  Post ad
                </a>
                <a href="#" className="transition hover:text-brand dark:hover:text-brand-light focus-visible:outline-2 focus-visible:outline-offset-2">
                  Support
                </a>
                <ThemeToggle />
              </nav>
            </div>
          </header>
          <main className="mx-auto w-full max-w-6xl flex-1 px-4 py-8" role="main">
            {children}
          </main>
          <footer className="border-t border-slate-200 bg-slate-50/50 px-4 py-8 dark:border-slate-800 dark:bg-slate-900/50" role="contentinfo">
            <div className="mx-auto max-w-6xl">
              <p className="text-sm text-slate-600 dark:text-slate-400">
                © {new Date().getFullYear()} Slovor Marketplace. All rights reserved.
              </p>
            </div>
          </footer>
        </div>
      </body>
    </html>
  );
}
