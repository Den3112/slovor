# GitHub Projects Setup Guide

**Purpose:** Integrate visual Kanban board with our automation system

---

## Step 1: Create GitHub Project

1. Go to: https://github.com/Den3112?tab=projects
2. Click **New project**
3. Choose **Board** template
4. Name: **Slovor Development**
5. Click **Create**

---

## Step 2: Configure Board Columns

### Default Columns (rename):
- **Backlog** - Not started tasks
- **Todo** - Ready to work
- **In Progress** - Currently working
- **Review** - Code review needed
- **Done** - Completed tasks

### Add Custom Fields:
1. **Phase** (Single select)
   - Phase 1: MVP Foundation
   - Phase 2: Browsing & Discovery
   - Phase 3: Authentication
   - Phase 4: Ad Management
   - Phase 5: Advanced Features

2. **Priority** (Single select)
   - 🔴 Critical
   - 🟡 High
   - 🟢 Medium
   - ⚪ Low

3. **Effort** (Number)
   - Hours estimate

---

## Step 3: Enable Automation

GitHub Project has built-in automations:

### Auto-add items
1. Project settings → Workflows
2. Enable **Auto-add to project**
3. Filter: `repo:Den3112/slovor is:issue,pr`

### Auto-archive
1. Enable **Auto-archive items**
2. Filter: `is:closed`

---

## Step 4: Create Issues from Task Tracker

Run this script to convert TASK_TRACKER.md to GitHub Issues:

```bash
# In project root
node scripts/create-issues-from-tasks.js
```

This will:
- Create 13 issues for Phase 1 tasks
- Add labels: `phase-1`, `infrastructure`
- Link to project automatically
- Set priority and effort

---

## Step 5: Configure GitHub Actions

Our `.github/workflows/project-automation.yml` automatically:

✅ Adds new issues to project  
✅ Moves issues with `in-progress` label to "In Progress"  
✅ Moves closed issues to "Done"  
✅ Adds PRs to project  
✅ Moves merged PRs to "Done"  

**No manual work needed!**

---

## Step 6: AI Integration

AI will automatically:

1. **Create issues** when starting tasks
2. **Add labels** (`phase-1`, `in-progress`, `done`)
3. **Update project** via labels (Actions do the moving)
4. **Close issues** when tasks complete
5. **Create PRs** for phase completion

**AI Workflow:**
```
AI starts Task 1.1
  ↓
Creates GitHub Issue #1
  ↓
Issue auto-added to Project (Backlog)
  ↓
AI adds label: in-progress
  ↓
Actions move to "In Progress" column
  ↓
AI completes task
  ↓
AI closes Issue #1
  ↓
Actions move to "Done" column
```

---

## Step 7: View Progress

### Project Board:
https://github.com/users/Den3112/projects/1

### Quick Stats:
- Total tasks
- Completed tasks
- In Progress
- Velocity (tasks/day)

---
## Step 8: Mobile Access

**GitHub Mobile App:**
- iOS: https://apps.apple.com/app/github/id1477376905
- Android: https://play.google.com/store/apps/details?id=com.github.android

View and update project on the go!

---

## Commands for AI

AI will use these when working:

```bash
# Create issue
gh issue create --title "Task 1.1: Dev Container Setup" --body "..." --label "phase-1,infrastructure"

# Add label (triggers automation)
gh issue edit 1 --add-label "in-progress"

# Close issue (moves to Done)
gh issue close 1 --comment "Task completed"

# Link to PR
gh pr create --title "feat: complete phase 1" --body "Closes #1, #2, #3"
```

---

## Benefits

✅ **Visual progress** - see status at a glance  
✅ **No manual updates** - automation handles everything  
✅ **Team collaboration** - everyone sees same board  
✅ **Mobile friendly** - check progress anywhere  
✅ **Historical data** - track velocity over time  

---

**Last Updated:** 2025-12-08