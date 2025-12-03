# Testing Guide

This document describes the testing setup and strategies for the Slovor frontend.

## Overview

The project uses:

- **Jest** — Unit and integration testing framework
- **React Testing Library** — Component testing utilities
- **@testing-library/jest-dom** — Custom Jest matchers

## Setup

### Installation

Testing dependencies are already included in `package.json`. To install them:

```bash
npm install
```

### Configuration Files

- `jest.config.js` — Jest configuration
- `jest.setup.js` — Jest setup file (imports testing utilities)

## Running Tests

### Run all tests

```bash
npm test
```

### Run tests in watch mode

```bash
npm test:watch
```

### Run tests with coverage report

```bash
npm test:coverage
```

## Test Structure

Tests are located in `__tests__` directories next to the code they test:

```
src/
├── lib/
│   ├── html.ts
│   └── __tests__/
│       └── html.test.ts
├── components/
│   ├── theme-toggle.tsx
│   └── __tests__/
│       └── theme-toggle.test.tsx
```

## Writing Tests

### Unit Tests (Functions)

Test utility functions in `src/lib/__tests__/`:

```typescript
import { stripHtmlTags } from "../html";

describe("stripHtmlTags", () => {
  it("should remove HTML tags", () => {
    const result = stripHtmlTags("<p>Hello</p>");
    expect(result).toBe("Hello");
  });
});
```

### Component Tests

Test React components in `src/components/__tests__/`:

```typescript
import { render, screen } from '@testing-library/react'
import { ThemeToggle } from '../theme-toggle'

describe('ThemeToggle', () => {
  it('should render button', () => {
    render(<ThemeToggle />)
    const button = screen.getByRole('button')
    expect(button).toBeInTheDocument()
  })
})
```

## Best Practices

### 1. Test Behavior, Not Implementation

❌ Bad:

```typescript
it("should call setState", () => {
  // Testing internal implementation
});
```

✅ Good:

```typescript
it('should display dark theme when button is clicked', () => {
  render(<ThemeToggle />)
  fireEvent.click(screen.getByRole('button'))
  expect(document.documentElement).toHaveClass('dark')
})
```

### 2. Use Semantic Queries

Prefer queries that reflect how users interact with the component:

```typescript
// ✅ Good
screen.getByRole("button", { name: /toggle/i });
screen.getByLabelText("Email");
screen.getByText("Submit");

// ❌ Avoid
screen.getByTestId("submit-btn");
screen.getByClassName("button");
```

### 3. Test User Interactions

```typescript
import { fireEvent } from '@testing-library/react'

it('should toggle theme', () => {
  render(<ThemeToggle />)
  const button = screen.getByRole('button')

  fireEvent.click(button)

  expect(button).toHaveTextContent('Dark')
})
```

### 4. Mock External Dependencies

```typescript
jest.mock("@/lib/wordpress/client", () => ({
  fetchPosts: jest.fn(() => Promise.resolve([])),
}));
```

## Common Test Patterns

### Testing Async Functions

```typescript
it("should fetch posts", async () => {
  const posts = await fetchPosts();
  expect(posts).toEqual([]);
});
```

### Testing Error Handling

```typescript
it("should handle fetch errors gracefully", async () => {
  jest.mock("@/lib/wordpress/client", () => ({
    fetchPosts: jest.fn(() => Promise.reject(new Error("Network error"))),
  }));

  const posts = await fetchPosts();
  expect(posts).toEqual([]);
});
```

### Testing localStorage

```typescript
it('should save theme to localStorage', () => {
  render(<ThemeToggle />)
  fireEvent.click(screen.getByRole('button'))

  expect(localStorage.getItem('slovor-theme')).toBe('dark')
})
```

## Testing Strategy

Our testing approach is layered:

- **Unit tests** for utilities and business logic (80%+ coverage required for production `src/lib/**` files)
- **E2E tests** for UI and user flows (Playwright - planned for future implementation)
- **Server components** tested via E2E, not unit tests (due to Next.js 16 limitations)
- **WordPress client** (src/lib/wordpress/client.ts) coverage not enforced due to module-level environment validation

## Coverage Goals

For utility and business logic code in `src/lib/**`, aim for:

- **Statements:** ≥80%
- **Branches:** ≥75%
- **Functions:** ≥80%
- **Lines:** ≥80%

Check coverage:

```bash
npm test:coverage
```

## Debugging Tests

### Print component output

```typescript
import { render, screen } from '@testing-library/react'

it('debug test', () => {
  const { debug } = render(<Component />)
  debug() // Prints HTML to console
})
```

### Use screen.logTestingPlaygroundURL()

```typescript
it('debug with Testing Playground', () => {
  render(<Component />)
  screen.logTestingPlaygroundURL()
})
```

## Resources

- [Jest Documentation](https://jestjs.io/)
- [React Testing Library](https://testing-library.com/react)
- [Testing Playground](https://testing-playground.com/)
- [Common Testing Mistakes](https://kentcdodds.com/blog/common-mistakes-with-react-testing-library)

## CI/CD Integration

Tests run automatically on:

- Pull requests to `main`
- Pushes to `main`

See `.github/workflows/ci.yml` for configuration.
