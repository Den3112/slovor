# GitHub Projects Integration

**Status:** ✅ Configured  
**Board:** https://github.com/users/Den3112/projects/1  
**Project Name:** @Slovor-Development

---

## ✅ Your Setup is Perfect!

You correctly created:
- ✅ Project: "@Slovor-Development"
- ✅ 3 Columns: Todo, In Progress, Done
- ✅ 2 Issues already added (#5, #6)
- ✅ Automation running ("setup workflows" message visible)

---

## How It Works

### 1. Task → Issue → Project

```
Task in TASK_TRACKER.md
  ↓
AI creates GitHub Issue
  ↓
GitHub Actions add to Project
  ↓
Issue appears in "Todo" column
```

### 2. Work Progress

```
AI starts task
  ↓
Adds label: in-progress
  ↓
Actions move to "In Progress"
  ↓
You see it on board immediately
```

### 3. Completion

```
AI finishes task
  ↓
Closes GitHub Issue
  ↓
Actions move to "Done"
  ↓
Progress automatically tracked
```

---

## Next Step: Create All Phase 1 Issues

Run this command to create 13 issues for all Phase 1 tasks:

```bash
cd slovor
node scripts/create-issues-from-tasks.js
```

**This will:**
- Create issues #7 through #19 (Tasks 1.1 - 1.13)
- Add labels: `phase-1`, `infrastructure`, `configuration`
- Auto-assign to you
- Auto-add to your project board

---

## Board Structure

### Columns

| Column | Description | Auto-move trigger |
|--------|-------------|------------------|
| 📋 Todo | Not started | Issue opened |
| 🔄 In Progress | Currently working | Label: `in-progress` |
| ✅ Done | Completed | Issue closed |

### Labels

- `phase-1`, `phase-2`, etc. - Phase identifier
- `infrastructure` - Dev env setup
- `configuration` - Config files
- `feature` - New functionality
- `in-progress` - Currently working

---

## AI Commands

AI will use these automatically:

### Create Task
```bash
gh issue create \
  --title "Task 1.1: Dev Container Setup" \
  --body "Setup description" \
  --label "phase-1,infrastructure" \
  --assignee @me
```

### Start Task
```bash
gh issue edit 7 --add-label "in-progress"
```

### Complete Task
```bash
gh issue close 7 --comment "✅ Task completed"
```

---

## Viewing Progress

### Desktop
https://github.com/users/Den3112/projects/1

### Mobile
GitHub Mobile App → Projects → @Slovor-Development

### CLI
```bash
# List all issues
gh issue list

# List by phase
gh issue list --label "phase-1"

# List in progress
gh issue list --label "in-progress"
```

---

## Enable Project Automation

### Step 1: Go to Project Settings
1. Open: https://github.com/users/Den3112/projects/1
2. Click **⋯** (three dots) → **Settings**

### Step 2: Enable Workflows
1. Click **Workflows** tab
2. Enable **"Auto-add to project"**
   - Repository: `Den3112/slovor`
   - Filter: `is:issue,pr`
3. Enable **"Auto-archive items"**
   - When: Status is Done

### Step 3: Done!
GitHub Actions (from `.github/workflows/project-automation.yml`) will handle the rest.

---

## Production Links

- **Live Site:** https://slovor.vercel.app
- **Vercel Dashboard:** https://vercel.com/slovors-projects/slovor
- **GitHub Repo:** https://github.com/Den3112/slovor
- **Supabase:** https://rsywmmnxkvwvhgrgzlei.supabase.co

---

**Last Updated:** 2025-12-08 21:10 EET