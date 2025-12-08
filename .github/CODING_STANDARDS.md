# Universal Coding Standards & Best Practices

**Version:** 1.0  
**Purpose:** World-class development standards for any project  
**Stack Agnostic:** Applicable to all tech stacks

---

## Core Principles

### 1. Code Quality

**ALWAYS:**
- ✅ Write self-documenting code with clear variable/function names
- ✅ Keep functions under 50 lines (Single Responsibility Principle)
- ✅ Use TypeScript strict mode (or equivalent type safety)
- ✅ Write pure functions when possible (no side effects)
- ✅ Follow DRY principle (Don't Repeat Yourself)

**NEVER:**
- ❌ Use `any` type (TypeScript) or untyped variables
- ❌ Leave commented-out code
- ❌ Use magic numbers/strings (use named constants)
- ❌ Write functions with >4 parameters (use objects)
- ❌ Nest code >3 levels deep

---

### 2. Naming Conventions

| Type | Convention | Example |
|------|-----------|----------|
| Files | kebab-case | `user-profile.tsx` |
| Components | PascalCase | `UserProfile` |
| Functions | camelCase | `getUserById()` |
| Constants | UPPER_SNAKE_CASE | `MAX_UPLOAD_SIZE` |
| Types/Interfaces | PascalCase | `UserData` |
| CSS Classes | kebab-case | `user-profile-card` |
| Database Tables | snake_case | `user_profiles` |

---

### 3. Git Workflow

**Commit Message Format (Conventional Commits):**
```
type(scope): subject

body (optional)
footer (optional)
```

**Types:**
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation
- `style`: Formatting
- `refactor`: Code change
- `test`: Tests
- `chore`: Tooling

**Examples:**
```bash
feat(auth): add email verification
fix(api): handle null response
docs(readme): update setup steps
```

---

### 4. Testing

**Test Pyramid:**
- 70% Unit tests
- 20% Integration tests
- 10% E2E tests

**Coverage Target:** >80%

---

### 5. Security (OWASP Top 10)

- ✅ Validate all inputs (client + server)
- ✅ Sanitize HTML (prevent XSS)
- ✅ Use parameterized queries (prevent SQL injection)
- ✅ Encrypt sensitive data
- ✅ Never commit credentials
- ✅ Implement rate limiting
- ✅ Use HTTPS only

---

### 6. Performance Targets

| Metric | Target |
|--------|--------|
| Lighthouse Score | >90 |
| Bundle Size | <200KB gzipped |
| Time to Interactive | <5s |
| First Contentful Paint | <1.5s |

---

### 7. Accessibility (WCAG 2.1 AA)

- ✅ Semantic HTML
- ✅ ARIA labels
- ✅ Keyboard navigation
- ✅ Color contrast >4.5:1
- ✅ Alt text for images
- ✅ Screen reader tested

---

**Last Updated:** 2025-12-08