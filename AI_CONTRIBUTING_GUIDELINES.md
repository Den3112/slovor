# AI Contributing Guidelines

**Last Updated:** November 30, 2025  
**Version:** 1.0  
**Status:** Active

This document is the single source of truth for all project standards and guidelines. All contributors, including AI assistants, must follow these guidelines when working on the Slovor Frontend project.

---

## 1. PROJECT OVERVIEW

### Project Description

Slovor is a minimal classifieds/marketplace frontend built with Next.js 16 and TypeScript. It serves as the public-facing UI for a marketplace platform and integrates with a WordPress headless backend via REST API.

### Tech Stack

- **Framework:** Next.js 16 (App Router) with React 19
- **Language:** TypeScript 5 (strict mode)
- **Styling:** Tailwind CSS 4
- **CMS:** WordPress (headless) via REST API
- **Testing:** Jest + React Testing Library
- **Linting:** ESLint 9 + Prettier 3
- **Git Hooks:** Husky + commitlint
- **Error Tracking:** Sentry
- **Deployment:** Vercel

### Target Audience

- End users browsing marketplace listings
- Marketplace administrators managing content
- Developers maintaining and extending the platform

### Project Goals

- Provide a fast, SEO-friendly marketplace interface
- Ensure security and data protection
- Maintain high code quality and test coverage
- Support dark mode and responsive design
- Enable easy integration with WordPress CMS

---

## 2. LANGUAGE STANDARDS

### Documentation Language

- **All documentation MUST be in American English**
- Use professional technical terminology
- Follow American spelling conventions (e.g., "color" not "colour")
- Use consistent terminology throughout the project

### Code Comments

- **All code comments MUST be in American English**
- Use JSDoc format for function documentation
- Keep comments concise and meaningful
- Explain "why" not "what" (code shows what it does)

### Commit Messages

- **All commit messages MUST be in English**
- Follow Conventional Commits format: `type(scope): subject`
- Examples:
  - `feat(api): add WordPress post caching`
  - `fix(theme): resolve dark mode toggle issue`
  - `docs(deployment): update Vercel setup instructions`
  - `test(html): add sanitization edge cases`

### Chat and Discussions

- Chat discussions can be in any language
- PR descriptions should be in English
- Issue titles and descriptions should be in English
- Internal team discussions can be in any language

### Terminology Rules

**NEVER translate these terms:**

- Command names: `npm`, `git`, `next`, `vercel`
- Package names: `react`, `typescript`, `tailwind`, `sanitize-html`
- Technology names: `Next.js`, `React`, `TypeScript`, `Tailwind CSS`
- Framework concepts: `App Router`, `Server Components`, `Client Components`
- File paths and configuration keys

---

## 3. CODE STANDARDS

### TypeScript

- **Strict mode MUST be enabled** (tsconfig.json)
- Avoid `any` types unless absolutely necessary
- Use proper type definitions for all functions
- Export types from `src/types/` directory
- Use interfaces for object shapes, types for unions/primitives

### ESLint and Prettier

- **All code MUST pass ESLint:** `npm run lint`
- **All code MUST be formatted with Prettier:** `npm run format`
- Run both before committing
- ESLint configuration: `eslint.config.mjs`
- Prettier configuration: `.prettierrc`

### React and Components

- Use functional components with hooks only
- Use `'use client'` directive for client-side components
- Avoid class components
- Keep components small and focused
- Use TypeScript for component props

### Import Organization

Follow this order:

1. React and Next.js imports
2. Third-party library imports
3. Relative imports from `@/` alias
4. Local relative imports

Example:

```typescript
import { useState, useEffect } from "react";
import Link from "next/link";
import { sanitizeHtmlContent } from "@/lib/html";
import { fetchPosts } from "@/lib/wordpress/client";
import type { WordPressPost } from "@/types/wordpress";
```

### File Naming

- **Files:** kebab-case (e.g., `theme-toggle.tsx`, `html.test.ts`)
- **Components:** PascalCase (e.g., `ThemeToggle`, `PostCard`)
- **Folders:** kebab-case (e.g., `src/lib/wordpress/`, `src/components/`)
- **Constants:** UPPER_SNAKE_CASE (e.g., `THEME_KEY`, `API_TIMEOUT`)

### Folder Structure

Follow Next.js App Router conventions:

```
src/
├── app/                    # Pages and layouts (App Router)
│   ├── layout.tsx          # Root layout
│   ├── page.tsx            # Home page
│   ├── posts/
│   │   └── [id]/
│   │       └── page.tsx    # Dynamic post page
│   └── ads/
│       └── [categoryId]/
│           └── page.tsx    # Category page
├── components/             # Reusable UI components
│   ├── theme-toggle.tsx
│   ├── post-card.tsx
│   └── __tests__/          # Component tests
├── lib/                    # Utilities and helpers
│   ├── html.ts             # HTML utilities
│   ├── wordpress/          # WordPress API client
│   ├── apiClient.ts        # Generic API client
│   └── __tests__/          # Unit tests
├── types/                  # TypeScript definitions
│   └── wordpress.ts        # WordPress types
└── config/                 # Configuration
    ├── categories.json     # Category definitions
    └── api.json            # API configuration
```

---

## 4. SECURITY STANDARDS

### Sensitive Data Protection

- **NEVER commit:**
  - `.env.local` or `.env` files
  - API keys or tokens
  - Passwords or credentials
  - Private configuration
- Use `.env.example` as template
- All sensitive data goes in environment variables

### HTML Sanitization

- **Always sanitize HTML from external sources**
- Use `sanitizeHtmlContent()` from `src/lib/html.ts`
- Never use `dangerouslySetInnerHTML` without sanitization
- Example:

  ```typescript
  import { sanitizeHtmlContent } from '@/lib/html'

  const safeHtml = sanitizeHtmlContent(userContent)
  return <div dangerouslySetInnerHTML={{ __html: safeHtml }} />
  ```

### Environment Variables

- Use environment variables for all configurable values
- Prefix public variables with `NEXT_PUBLIC_`
- Document all variables in `.env.example`
- Validate environment variables at startup
- Example in `src/lib/wordpress/client.ts`:
  ```typescript
  function validateWpBase(): string {
    const wpBase = process.env.NEXT_PUBLIC_WP_BASE;
    if (!wpBase) {
      throw new Error("Missing NEXT_PUBLIC_WP_BASE");
    }
    return wpBase;
  }
  ```

### Input Validation

- Validate all user inputs
- Validate API responses
- Use TypeScript types for validation
- Sanitize data before storing or displaying

### HTTPS and External Requests

- Always use HTTPS for external API calls
- Verify SSL certificates
- Use secure headers (configured in `next.config.ts`)
- Never expose sensitive headers in client-side code

### OWASP Guidelines

Follow OWASP Top 10:

- A01: Broken Access Control — Use proper authentication
- A02: Cryptographic Failures — Use HTTPS, secure headers
- A03: Injection — Sanitize all inputs, use parameterized queries
- A04: Insecure Design — Follow security by design
- A05: Security Misconfiguration — Keep dependencies updated
- A06: Vulnerable Components — Update packages regularly
- A07: Authentication Failures — Validate all inputs
- A08: Software and Data Integrity Failures — Verify package integrity
- A09: Logging and Monitoring — Use Sentry for monitoring
- A10: SSRF — Validate all URLs

---

## 5. DOCUMENTATION STANDARDS

### Documentation Requirements

- **Every new feature needs documentation update**
- Update relevant `.md` files in `docs/`
- Update `README.md` if feature affects users
- Add entry to `CHANGELOG.md` for significant changes

### README.md

- Must always be up-to-date
- Include quick start instructions
- Document all environment variables
- Include deployment instructions
- List all available commands

### Complex Functions

- Use JSDoc comments for all exported functions
- Document parameters, return types, and examples
- Example:
  ```typescript
  /**
   * Sanitize HTML content from WordPress to prevent XSS attacks.
   * Allows safe tags like <p>, <strong>, <em>, <a>, etc.
   *
   * @param html - Raw HTML string from WordPress
   * @returns Sanitized HTML string safe for rendering
   *
   * @example
   * const safe = sanitizeHtmlContent('<p>Hello <script>alert("xss")</script></p>')
   * // Returns: '<p>Hello </p>'
   */
  export function sanitizeHtmlContent(html: string): string {
    // Implementation
  }
  ```

### API Documentation

- Document all API endpoints in `docs/api.md`
- Include request/response examples
- Document error handling
- Include authentication requirements

### Breaking Changes

- Document in `CHANGELOG.md`
- Include migration guide
- Update affected documentation
- Provide examples of old vs. new usage

### Markdown Standards

- Use proper heading hierarchy (h1 → h2 → h3)
- Include table of contents for long documents
- Use code blocks with language specification
- Include examples and use cases
- Keep line length reasonable (80-100 chars)

---

## 6. TESTING STANDARDS

### Test Requirements

- **All new features need tests**
- **Minimum 80% code coverage for new code**
- Tests must pass before merge: `npm test`
- Run coverage report: `npm test:coverage`

### Unit Tests

- Location: `src/lib/__tests__/`
- Test utility functions and helpers
- Use Jest for testing
- Example:
  ```typescript
  describe("sanitizeHtmlContent", () => {
    it("should remove script tags", () => {
      const input = '<p>Hello <script>alert("xss")</script></p>';
      const result = sanitizeHtmlContent(input);
      expect(result).not.toContain("<script>");
    });
  });
  ```

### Component Tests

- Location: `src/components/__tests__/`
- Test React components with React Testing Library
- Test user interactions and rendering
- Example:
  ```typescript
  describe('ThemeToggle', () => {
    it('should render button', () => {
      render(<ThemeToggle />)
      const button = screen.getByRole('button')
      expect(button).toBeInTheDocument()
    })
  })
  ```

### E2E Tests

- Test critical user flows
- Use Playwright or Cypress
- Test across browsers
- Test responsive design

### Test Best Practices

- Test behavior, not implementation
- Use descriptive test names
- Keep tests focused and small
- Mock external dependencies
- Use fixtures for test data
- Clean up after tests

### Running Tests

```bash
npm test                 # Run all tests
npm test:watch          # Run in watch mode
npm test:coverage       # Generate coverage report
npm test -- --testNamePattern="pattern"  # Run specific tests
```

---

## 7. GIT WORKFLOW

### Branch Naming

- **Feature branches:** `feat/feature-name`
- **Bug fixes:** `fix/bug-name`
- **Documentation:** `docs/doc-name`
- **Refactoring:** `refactor/what-changed`
- **Tests:** `test/what-tested`
- **Chores:** `chore/what-changed`

Examples:

- `feat/wordpress-post-caching`
- `fix/theme-toggle-persistence`
- `docs/deployment-guide`
- `refactor/api-client-structure`

### Commit Messages

Follow Conventional Commits format:

```
type(scope): subject

body (optional)

footer (optional)
```

**Types:**

- `feat` — New feature
- `fix` — Bug fix
- `docs` — Documentation changes
- `style` — Code style changes (formatting, semicolons)
- `refactor` — Code refactoring
- `test` — Test additions or changes
- `chore` — Build, dependencies, tooling

**Examples:**

```
feat(wordpress): add post caching with ISR

Implement Incremental Static Regeneration for WordPress posts
to improve performance and reduce API calls.

Closes #123
```

```
fix(theme): resolve dark mode toggle not persisting

The theme preference was not being saved to localStorage
due to missing useEffect dependency.
```

```
docs(api): update WordPress endpoint documentation

Add examples and error handling documentation for
the WordPress REST API integration.
```

### Pull Request Workflow

1. **Create branch from main:**

   ```bash
   git checkout -b feat/feature-name
   ```

2. **Make changes and commit:**

   ```bash
   git add .
   git commit -m "feat(scope): description"
   ```

3. **Push to GitHub:**

   ```bash
   git push origin feat/feature-name
   ```

4. **Create Pull Request:**
   - Add descriptive title
   - Link to related issue
   - Include checklist
   - Describe changes

5. **PR Checklist:**
   - [ ] Tests pass (`npm test`)
   - [ ] Linting passes (`npm run lint`)
   - [ ] Documentation updated
   - [ ] No breaking changes (or documented)
   - [ ] Commits are squashed

6. **Merge to main:**
   - Squash commits before merge
   - Delete branch after merge
   - Automatic deployment to production

### Commit Best Practices

- Make small, focused commits
- One logical change per commit
- Write meaningful commit messages
- Reference issues in commit messages
- Squash WIP commits before merge

---

## 8. FILE STRUCTURE

### Directory Organization

```
slovor-frontend/
├── .github/                    # GitHub configuration
│   ├── CODEOWNERS              # Code ownership
│   ├── ISSUE_TEMPLATE/         # Issue templates
│   ├── PULL_REQUEST_TEMPLATE/  # PR template
│   └── workflows/              # CI/CD workflows
├── .husky/                     # Git hooks
│   ├── pre-commit              # Pre-commit hook
│   └── commit-msg              # Commit message hook
├── docs/                       # Project documentation
│   ├── TESTING.md              # Testing guide
│   ├── MONITORING.md           # Sentry monitoring
│   ├── DEPLOYMENT.md           # Deployment guide
│   ├── api.md                  # API documentation
│   └── architecture.md         # Architecture overview
├── public/                     # Static assets
│   ├── images/                 # Image files
│   ├── icons/                  # Icon files
│   └── favicon.ico             # Favicon
├── src/
│   ├── app/                    # Next.js App Router
│   │   ├── layout.tsx          # Root layout
│   │   ├── page.tsx            # Home page
│   │   ├── posts/              # Posts section
│   │   │   └── [id]/
│   │   │       └── page.tsx    # Post detail page
│   │   ├── ads/                # Ads section
│   │   │   └── [categoryId]/
│   │   │       └── page.tsx    # Category page
│   │   ├── globals.css         # Global styles
│   │   ├── global-error.tsx    # Global error handler
│   │   └── not-found.tsx       # 404 page
│   ├── components/             # Reusable components
│   │   ├── theme-toggle.tsx    # Theme toggle component
│   │   ├── post-card.tsx       # Post card component
│   │   └── __tests__/          # Component tests
│   │       └── theme-toggle.test.tsx
│   ├── lib/                    # Utilities and helpers
│   │   ├── html.ts             # HTML utilities
│   │   ├── apiClient.ts        # Generic API client
│   │   ├── wordpress/          # WordPress integration
│   │   │   └── client.ts       # WordPress API client
│   │   ├── mockAds.ts          # Mock data
│   │   ├── categories.ts       # Category utilities
│   │   └── __tests__/          # Unit tests
│   │       └── html.test.ts
│   ├── types/                  # TypeScript types
│   │   └── wordpress.ts        # WordPress types
│   ├── config/                 # Configuration
│   │   ├── categories.json     # Category definitions
│   │   └── api.json            # API configuration
│   └── hooks/                  # Custom React hooks
├── config/                     # Root configuration
│   ├── categories.json         # Category data
│   └── api.json                # API endpoints
├── .env.example                # Environment template
├── .env.local                  # Local environment (gitignored)
├── .gitignore                  # Git ignore rules
├── .prettierrc                 # Prettier configuration
├── commitlint.config.js        # Commitlint configuration
├── eslint.config.mjs           # ESLint configuration
├── jest.config.js              # Jest configuration
├── jest.setup.js               # Jest setup
├── next.config.ts              # Next.js configuration
├── package.json                # Dependencies
├── package-lock.json           # Lock file
├── postcss.config.mjs          # PostCSS configuration
├── sentry.client.config.ts     # Sentry client config
├── sentry.server.config.ts     # Sentry server config
├── tailwind.config.ts          # Tailwind configuration
├── tsconfig.json               # TypeScript configuration
├── README.md                   # Project README
├── CONTRIBUTING.md             # Contributing guide
├── AI_CONTRIBUTING_GUIDELINES.md  # AI guidelines (this file)
├── CHANGELOG.md                # Version history
├── CODE_OF_CONDUCT.md          # Community guidelines
├── SECURITY.md                 # Security policy
├── LICENSE                     # MIT License
├── AUDIT.md                    # Security audit report
└── CLEANUP_REPORT.md           # Project cleanup report
```

---

## 9. STYLING STANDARDS

### Tailwind CSS

- **Use Tailwind CSS utility classes** for all styling
- Custom styles only when necessary (in `src/app/globals.css`)
- Follow mobile-first approach
- Use responsive prefixes: `sm:`, `md:`, `lg:`, `xl:`, `2xl:`

### Dark Mode

- **Dark mode support is required**
- Use `dark:` prefix for dark mode styles
- Default to dark theme
- Provide light mode option via theme toggle
- Test both light and dark modes

### Responsive Design

- **All components must be responsive**
- Test on mobile, tablet, and desktop
- Use Tailwind breakpoints
- Mobile-first approach
- Example:
  ```tsx
  <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
    {/* Responsive grid */}
  </div>
  ```

### Accessibility (WCAG 2.1 AA)

- **Minimum WCAG 2.1 AA compliance required**
- Use semantic HTML (`<button>`, `<nav>`, `<article>`, etc.)
- Include ARIA labels where needed
- Ensure color contrast ratios (4.5:1 for text)
- Keyboard navigation support
- Focus indicators visible
- Alt text for images
- Example:
  ```tsx
  <button type="button" onClick={toggleTheme} aria-label="Toggle theme" className="...">
    {theme === "dark" ? "Light" : "Dark"}
  </button>
  ```

### Custom Styles

Only use custom CSS when Tailwind utilities are insufficient:

```css
/* src/app/globals.css */
@layer components {
  .custom-component {
    @apply flex items-center justify-between;
    /* Additional custom styles */
  }
}
```

---

## 10. DEPLOYMENT STANDARDS

### Hosting Platform

- **Use Vercel for hosting**
- Automatic deployments on push to main
- Preview deployments for pull requests
- Edge functions and middleware support
- Built-in analytics and monitoring

### Environment Variables

Set in Vercel project settings:

**Required:**

- `NEXT_PUBLIC_WP_BASE` — WordPress REST API base URL

**Optional:**

- `NEXT_PUBLIC_SENTRY_DSN` — Sentry DSN for error tracking
- `NEXT_PUBLIC_USE_WORDPRESS` — Use real WordPress API (true/false)

### Deployment Process

1. **Push to main branch:**

   ```bash
   git push origin main
   ```

2. **Vercel automatically:**
   - Builds the project
   - Runs tests and linting
   - Deploys to production
   - Updates DNS records

3. **Preview deployments:**
   - Created for every pull request
   - Unique URL for testing
   - Automatic cleanup after merge

### Monitoring

- **Production monitoring with Sentry**
- Error tracking and alerting
- Performance monitoring
- Session replay (10% sample rate)
- Source maps for better stack traces

### Rollback

If deployment fails:

1. Check Vercel deployment logs
2. Fix the issue locally
3. Push fix to main
4. Vercel redeploys automatically

---

## 11. AI ASSISTANT GUIDELINES

When working on this project, AI assistants MUST:

### Before Making Changes

- [ ] Read this file completely
- [ ] Understand all standards and guidelines
- [ ] Check existing code patterns
- [ ] Review related documentation

### During Development

- [ ] Follow all code standards listed above
- [ ] Write code in English with English comments
- [ ] Translate any Russian/other language documentation to English
- [ ] Update documentation when changing code
- [ ] Create meaningful commit messages
- [ ] Keep changes focused and small

### After Making Changes

- [ ] Run tests: `npm test`
- [ ] Run linter: `npm run lint`
- [ ] Run formatter: `npm run format`
- [ ] Verify no breaking changes
- [ ] Update CHANGELOG.md if needed
- [ ] Update README.md if needed

### Communication

- Provide explanations in Russian in chat
- Keep all code and documentation in English
- Ask for clarification if standards conflict
- Suggest improvements following these guidelines
- Document decisions and trade-offs

### Code Quality

- Never break existing functionality
- Maintain backward compatibility
- Write tests for new features
- Keep code DRY (Don't Repeat Yourself)
- Use meaningful variable and function names
- Keep functions small and focused

### Documentation

- Update docs when changing code
- Include code examples
- Explain complex logic
- Document breaking changes
- Keep documentation up-to-date

---

## 12. COMMON COMMANDS

### Development

```bash
npm run dev              # Start development server on http://localhost:3000
npm run build            # Build for production
npm run start            # Start production server
```

### Code Quality

```bash
npm run lint             # Run ESLint
npm run lint:fix         # Fix ESLint issues automatically
npm run format           # Format code with Prettier
npm run format:check     # Check formatting without changes
```

### Testing

```bash
npm test                 # Run all tests
npm test:watch           # Run tests in watch mode
npm test:coverage        # Generate coverage report
npm test -- --testNamePattern="pattern"  # Run specific tests
```

### Git

```bash
git status               # Check git status
git add .                # Stage all changes
git commit -m "message"  # Commit with message
git push origin branch   # Push to GitHub
git pull origin main     # Pull latest from main
```

---

## 13. ENVIRONMENT VARIABLES

### Required Variables

| Variable              | Description                 | Example                           |
| --------------------- | --------------------------- | --------------------------------- |
| `NEXT_PUBLIC_WP_BASE` | WordPress REST API base URL | `https://slovor.sk/wp-json/wp/v2` |

### Optional Variables

| Variable                    | Description                   | Default   |
| --------------------------- | ----------------------------- | --------- |
| `NEXT_PUBLIC_SENTRY_DSN`    | Sentry DSN for error tracking | (not set) |
| `NEXT_PUBLIC_USE_WORDPRESS` | Use real WordPress API        | `false`   |

### Setup

1. Copy `.env.example` to `.env.local`:

   ```bash
   cp .env.example .env.local
   ```

2. Update values in `.env.local`:

   ```env
   NEXT_PUBLIC_WP_BASE=https://your-wordpress-site.com/wp-json/wp/v2
   NEXT_PUBLIC_SENTRY_DSN=https://your-key@sentry.io/your-project-id
   ```

3. Never commit `.env.local` to git

---

## 14. TROUBLESHOOTING

### Build Fails

**Error:** TypeScript compilation errors

**Solution:**

```bash
npm run build  # See detailed error messages
# Fix TypeScript errors
npm run lint   # Check for linting issues
```

### Tests Fail

**Error:** Test failures

**Solution:**

```bash
npm test                    # Run all tests
npm test:watch              # Run in watch mode for debugging
npm test -- --testNamePattern="specific-test"  # Run specific test
npm test:coverage           # Check coverage
```

### Linter Fails

**Error:** ESLint errors

**Solution:**

```bash
npm run lint                # See all errors
npm run lint:fix            # Auto-fix fixable errors
npm run format              # Format code with Prettier
```

### Deployment Fails

**Error:** Vercel deployment error

**Solution:**

1. Check Vercel logs: https://vercel.com/dashboard
2. Verify environment variables are set
3. Check build output for errors
4. Fix issues locally and push again

### WordPress API Issues

**Error:** Cannot fetch posts from WordPress

**Solution:**

1. Verify `NEXT_PUBLIC_WP_BASE` is correct
2. Test URL directly in browser
3. Check WordPress CORS settings
4. Verify WordPress REST API is enabled
5. Check network tab in DevTools

### Port Already in Use

**Error:** Port 3000 is already in use

**Solution:**

```bash
# Kill process using port 3000
lsof -ti:3000 | xargs kill -9  # macOS/Linux
netstat -ano | findstr :3000   # Windows (find PID)
taskkill /PID <PID> /F         # Windows (kill process)
```

---

## 15. CONTACT & RESOURCES

### Project Links

- **Repository:** https://github.com/slovor/slovor-frontend
- **Documentation:** `/docs` directory in repository
- **Issues:** https://github.com/slovor/slovor-frontend/issues

### External Services

- **Vercel Dashboard:** https://vercel.com/dashboard
- **Sentry Dashboard:** https://sentry.io
- **GitHub:** https://github.com

### Documentation Files

- `README.md` — Project overview and quick start
- `CONTRIBUTING.md` — Contribution guidelines
- `SECURITY.md` — Security policy
- `CODE_OF_CONDUCT.md` — Community guidelines
- `docs/TESTING.md` — Testing guide
- `docs/MONITORING.md` — Sentry monitoring guide
- `docs/DEPLOYMENT.md` — Deployment guide
- `docs/api.md` — API documentation
- `docs/architecture.md` — Architecture overview

---

## 16. FINAL NOTES

### Single Source of Truth

This file is the **single source of truth** for all project standards. All changes must comply with these guidelines.

### Updates to Guidelines

When updating these guidelines:

1. Update this file
2. Notify all team members
3. Update related documentation
4. Create a commit with clear message

### Questions or Conflicts

If you encounter:

- **Unclear guidelines:** Ask for clarification
- **Conflicting standards:** Reference this file
- **New situations:** Suggest guidelines update

### Continuous Improvement

These guidelines evolve with the project. Suggestions for improvements are welcome through:

- GitHub issues
- Pull request discussions
- Team meetings

---

**Last Updated:** November 30, 2025  
**Version:** 1.0  
**Maintained By:** Development Team  
**Status:** Active and Enforced
