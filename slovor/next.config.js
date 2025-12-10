/** @type {import('next').NextConfig} */
const nextConfig = {
  // Enable static exports for better performance
  output: 'standalone',
  
  // Strict mode for better development experience
  reactStrictMode: true,
  
  // Optimize images
  images: {
    remotePatterns: [],
    unoptimized: false,
  },
  
  // TypeScript and ESLint config
  typescript: {
    // Don't fail build on type errors (we check separately)
    ignoreBuildErrors: false,
  },
  eslint: {
    // Don't fail build on lint errors (we check separately)
    ignoreDuringBuilds: false,
  },
}

module.exports = nextConfig
