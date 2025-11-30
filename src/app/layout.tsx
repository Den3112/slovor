import type { Metadata, Viewport } from "next";
import { Geist, Geist_Mono } from "next/font/google";
import Link from "next/link";
import Image from "next/image";
import { SpeedInsights } from "@vercel/speed-insights/next";
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
        <link rel="icon" href="/favicon.ico" sizes="16x16 32x32" />
        <link rel="icon" type="image/png" sizes="32x32" href="/favicon-32x32.png" />
        <link rel="apple-touch-icon" sizes="180x180" href="/apple-touch-icon.png" />
        <meta name="apple-mobile-web-app-capable" content="yes" />
        <meta name="apple-mobile-web-app-status-bar-style" content="black-translucent" />
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=5, user-scalable=yes" />
      </head>
      <body className="min-h-screen bg-white text-primaryDark dark:bg-slate-950">
        <div className="flex min-h-screen flex-col">
          <header
            className="sticky top-0 z-50 border-b border-slate-200 bg-white px-4 py-2 shadow-sm dark:border-slate-800 dark:bg-slate-900"
            role="banner"
          >
            <div className="mx-auto flex w-full max-w-6xl items-center justify-between gap-4">
              <Link href="/" className="flex items-center h-10 px-2 hover:opacity-90 transition-opacity">
                <div className="relative h-10 w-10">
                  <Image
                    src="/logo.png"
                    alt="Slovor"
                    width={40}
                    height={40}
                    priority
                  />
                </div>
              </Link>
              <nav className="flex items-center gap-6 text-sm font-medium text-primaryDark dark:text-slate-300" role="navigation" aria-label="Main navigation">
                <a href="#" className="transition-colors hover:text-primary focus-visible:outline-2 focus-visible:outline-offset-2">
                  Browse
                </a>
                <a href="#" className="transition-colors hover:text-primary focus-visible:outline-2 focus-visible:outline-offset-2">
                  Post ad
                </a>
                <a href="#" className="transition-colors hover:text-primary focus-visible:outline-2 focus-visible:outline-offset-2">
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
        <SpeedInsights />
      </body>
    </html>
  );
}
