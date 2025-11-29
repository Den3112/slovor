import type { NextConfig } from "next";

const nextConfig: NextConfig = {
  // Security headers
  headers: async () => [
    {
      source: "/(.*)",
      headers: [
        {
          key: "X-Content-Type-Options",
          value: "nosniff",
        },
        {
          key: "X-Frame-Options",
          value: "DENY",
        },
        {
          key: "X-XSS-Protection",
          value: "1; mode=block",
        },
        {
          key: "Referrer-Policy",
          value: "strict-origin-when-cross-origin",
        },
      ],
    },
  ],

  // Image optimization
  images: {
    formats: ["image/avif", "image/webp"],
    remotePatterns: [
      {
        protocol: "http",
        hostname: "slovor.ct.ws",
      },
      {
        protocol: "https",
        hostname: "slovor.ct.ws",
      },
    ],
  },

  // Performance & optimization
  compress: true,
  poweredByHeader: false,
  productionBrowserSourceMaps: false,

  // Experimental features for optimization
  experimental: {
    optimizePackageImports: ["@radix-ui/react-*"],
  },
};

export default nextConfig;
