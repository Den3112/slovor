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
        brand: {
          DEFAULT: "#2E7D6E",
          dark: "#1F5A4D",
          light: "#4A9F8C",
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

