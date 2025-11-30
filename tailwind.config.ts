import type { Config } from "tailwindcss";

const config = {
  darkMode: "class",
  content: [
    "./src/**/*.{js,ts,jsx,tsx,mdx}",
    "./app/**/*.{js,ts,jsx,tsx,mdx}",
  ],
  theme: {
    extend: {
      colors: {
        primary: {
          DEFAULT: "#1E88E5",  // Bright blue from the sky
          dark: "#0D47A1",     // Navy blue from outer ring
          light: "#90CAF9",    // Lighter blue tint
        },
        accent: {
          DEFAULT: "#43A047",  // Green from the bottom
          dark: "#2E7D32",
          light: "#66BB6A",
        },
        background: {
          soft: "#F5F9FF",     // Very light bluish background
        },
        // Keep existing brand colors for backward compatibility
        brand: {
          DEFAULT: "#1E88E5",
          dark: "#0D47A1",
          light: "#90CAF9",
        },
        secondary: {
          DEFAULT: "#5B8FA3",
          dark: "#3D6B7D",
        },
      },
    },
  },
  plugins: [],
} satisfies Config;

export default config;

