// Extract hostname from NEXT_PUBLIC_WP_BASE environment variable
function getWordPressHostname() {
  const wpBase = process.env.NEXT_PUBLIC_WP_BASE;
  if (!wpBase) {
    // Fallback to default for development
    return "slovor.ct.ws";
  }
  try {
    const url = new URL(wpBase);
    return url.hostname;
  } catch {
    return "slovor.ct.ws";
  }
}

const wpHostname = getWordPressHostname();

const nextConfig = {
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
        hostname: wpHostname,
      },
      {
        protocol: "https",
        hostname: wpHostname,
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

module.exports = nextConfig;
