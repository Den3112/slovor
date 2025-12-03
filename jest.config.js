// eslint-disable-next-line @typescript-eslint/no-require-imports
const nextJest = require("next/jest");

const createJestConfig = nextJest({
  // Provide the path to your Next.js app to load next.config.js and .env files in your test environment
  dir: "./",
});

// Add any custom config to be passed to Jest
const customJestConfig = {
  setupFilesAfterEnv: ["<rootDir>/jest.setup.js"],
  testEnvironment: "jest-environment-jsdom",
  moduleNameMapper: {
    "^@/(.*)$": "<rootDir>/src/$1",
  },
  testMatch: ["**/__tests__/**/*.[jt]s?(x)", "**/?(*.)+(spec|test).[jt]s?(x)"],
  collectCoverageFrom: [
    "src/**/*.{js,jsx,ts,tsx}",
    "!src/**/*.d.ts",
    "!src/**/*.stories.{js,jsx,ts,tsx}",
    "!src/**/__tests__/**",
  ],
  coveragePathIgnorePatterns: ["node_modules"],
  coverageThreshold: {
    "src/lib/apiClient.ts": {
      statements: 80,
      branches: 75,
      functions: 80,
      lines: 80,
    },
    "src/lib/categories.ts": {
      statements: 80,
      branches: 75,
      functions: 80,
      lines: 80,
    },
    "src/lib/html.ts": {
      statements: 80,
      branches: 75,
      functions: 80,
      lines: 80,
    },

    "src/lib/wordpress/client.ts": {
      statements: 80,
      branches: 75,
      functions: 100,
      lines: 80,
    },
    "src/lib/wordpress/validation.ts": {
      statements: 80,
      branches: 75,
      functions: 80,
      lines: 80,
    },
  },
};

// createJestConfig is exported this way to ensure that next/jest can load the Next.js config which is async
module.exports = createJestConfig(customJestConfig);
