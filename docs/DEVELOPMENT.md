# Development Workflow

## Team Structure

**AI (Perplexity):** Full development + documentation + GitHub management  
**Human + Grok:** Local testing + feedback + tasks AI cannot do  

---

## Workflow

### 1. AI Creates Feature

- Writes complete code
- Creates all necessary files
- Adds comprehensive documentation
- Pushes directly to GitHub `main` branch
- Updates documentation

### 2. Human Tests Locally

```bash
# Pull latest changes
git pull origin main

# Navigate to project
cd slovor

# Install dependencies (first time only)
npm install

# Test locally
npm run dev
# Open http://localhost:3000

# Test build
npm run build
```

### 3. Human Provides Feedback

Report to AI:
- ✅ What works
- ❌ What doesn't work
- 🐛 Bugs found
- 💡 Improvement suggestions

### 4. AI Fixes Issues

- Receives feedback
- Makes corrections
- Pushes fixes to GitHub
- Updates documentation

### 5. Repeat Until Complete

---

## Git Strategy

**Simple approach:**
- Single `main` branch
- AI commits directly to main
- Each commit is tested and working
- Clear commit messages describing changes

**Why no dev branch yet:**
- Team of 2 (AI + Human)
- Fast iteration needed
- Less overhead = faster progress
- Can add later when needed

---

## Commit Message Format

```
type: short description

- Detail 1
- Detail 2
- Detail 3
```

**Types:**
- `feat:` - new feature
- `fix:` - bug fix
- `docs:` - documentation
- `chore:` - maintenance
- `refactor:` - code improvement
- `test:` - tests

---

## Local Development Setup

See:
- `docs/LANDO_SETUP.md` - Docker/Lando environment
- `docs/WSL2_SETUP.md` - Windows WSL2 setup
- `docs/QUICK_START.md` - Quick start guide

---

## Testing Checklist

Before reporting "works":

- [ ] `npm install` succeeds
- [ ] `npm run dev` starts without errors
- [ ] Page loads at http://localhost:3000
- [ ] `npm run build` succeeds
- [ ] No console errors in browser
- [ ] Tested on actual use case

---

## Reporting Issues

**Good report:**
```
❌ Build fails

Command: npm run build
Error: [exact error message]
File: app/page.tsx line 15

Expected: Build succeeds
Actual: Type error
```

**Bad report:**
```
Doesn't work
```

---

## AI Responsibilities

- ✅ Write all code
- ✅ Create all files
- ✅ Manage GitHub repository
- ✅ Write documentation
- ✅ Fix bugs based on feedback
- ✅ Keep project structure clean
- ✅ Ensure code quality

## Human Responsibilities

- ✅ Test locally
- ✅ Provide detailed feedback
- ✅ Report bugs clearly
- ✅ Suggest improvements
- ✅ Test on real devices/browsers
- ✅ Verify Vercel deployment
- ✅ Handle tasks AI cannot do

---

## Deployment

**Automatic:**
- Every push to `main` → Vercel auto-deploys
- Check: https://slovor.vercel.app
- Dashboard: https://vercel.com/slovors-projects/slovor

**Manual verification:**
- Human checks deployed site
- Reports any production-only issues

---

## Current Status

**Phase:** Foundation Setup  
**Next:** Complete Phase 1 tasks  
**See:** `docs/PROJECT_ROADMAP.md`  

---

## Questions?

Ask AI in chat - it has full context of the project.
