# Slovor Issues Log

**Purpose:** Track all problems encountered during development with solutions.  
**Last Updated:** 2025-12-08

---

## Active Issues

_No active issues_

---

## Resolved Issues

_No resolved issues yet_

---

## Common Problems & Solutions

### Problem: Docker container fails to start
**Solution:**
```bash
docker system prune -a
docker compose -f .devcontainer/docker-compose.yml build --no-cache
```

### Problem: TypeScript compilation errors
**Solution:**
```bash
rm -rf node_modules .next
npm install
npx tsc --noEmit
```

### Problem: Supabase migrations not applying
**Solution:**
```bash
supabase db reset
supabase db push
```

### Problem: ESLint errors after update
**Solution:**
```bash
rm -rf node_modules package-lock.json
npm install
npm run lint -- --fix
```

---

## Issue Template

### Issue #XXX: [Title]
- **Date Reported:** YYYY-MM-DD HH:MM
- **Phase:** Phase X
- **Task:** Task X.Y
- **Severity:** 🔴 Critical / 🟡 Warning / 🟢 Minor
- **Status:** Open / In Progress / Resolved
- **Reported By:** [Name/AI]

**Description:**
[Detailed description of the issue]

**Steps to Reproduce:**
1. Step 1
2. Step 2
3. Step 3

**Expected Behavior:**
[What should happen]

**Actual Behavior:**
[What actually happens]

**Error Message:**
```
[Error output if applicable]
```

**Solution:**
[How it was fixed, or "Under investigation"]

**Verification:**
```bash
[Commands to verify fix]
```

---

## Issue Statistics

- Total Issues: 0
- Resolved: 0
- In Progress: 0
- Open: 0
- Critical: 0
- Warnings: 0
- Minor: 0
