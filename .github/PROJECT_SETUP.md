# GitHub Projects Setup Guide

**Status:** ✅ Already Created!  
**Your Project:** https://github.com/users/Den3112/projects/1  
**Name:** @Slovor-Development

---

## ✅ What You Did Right

1. Created project "@Slovor-Development"
2. Set up 3 columns: Todo, In Progress, Done
3. Added initial issues (#5, #6)
4. Automation workflows are running

**Perfect setup!** Now let's finish configuration.

---

## Step 1: Enable Auto-Add Issues ✅ REQUIRED

1. Go to: https://github.com/users/Den3112/projects/1/settings
2. Click **Workflows** tab
3. Click **"Auto-add to project"**
4. Configure:
   - Repository: `Den3112/slovor`
   - Filter: `is:issue,pr`
   - Click **Save**

Now all new issues will automatically appear on your board!

---

## Step 2: Create All Phase 1 Tasks

Run this script to create 13 GitHub Issues from your task tracker:

```bash
cd slovor
node scripts/create-issues-from-tasks.js
```

**This creates:**
- Task 1.1: Dev Container Setup
- Task 1.2: Environment Configuration
- Task 1.3: Database Schema
- ... (all 13 tasks)

**Each issue includes:**
- Full description
- Subtask checklist
- Labels (phase-1, infrastructure, etc.)
- Auto-assigned to you
- Auto-added to project board

---

## Step 3: Configure Custom Fields (Optional)

### Add Phase Field
1. Project settings → **Custom fields**
2. Click **New field** → **Single select**
3. Name: **Phase**
4. Options:
   - Phase 1: MVP Foundation
   - Phase 2: Browsing & Discovery
   - Phase 3: Authentication
   - Phase 4: Ad Management
   - Phase 5: Advanced Features

### Add Priority Field
1. New field → **Single select**
2. Name: **Priority**
3. Options:
   - 🔴 Critical
   - 🟡 High
   - 🟢 Medium
   - ⚪ Low

### Add Effort Field
1. New field → **Number**
2. Name: **Effort (hours)**
3. Format: Number

---

## Step 4: Verify Automation

Our GitHub Action (`.github/workflows/project-automation.yml`) automatically:

✅ Adds new issues to project  
✅ Moves issues with `in-progress` label to "In Progress"  
✅ Moves closed issues to "Done"  
✅ Adds PRs to project  
✅ Moves merged PRs to "Done"  

**Test it:**
1. Create a test issue
2. Check if it appears in "Todo" column
3. Add label `in-progress`
4. Check if it moves to "In Progress"
5. Close issue
6. Check if it moves to "Done"

---

## Board Columns Explained

| Column | When item appears |
|--------|------------------|
| **📋 Todo** | Issue opened (default) |
| **🔄 In Progress** | Issue has label `in-progress` |
| **✅ Done** | Issue closed |

---

## AI Integration

When you tell AI to work:

```
Human: start phase 1

AI:
1. Creates GitHub Issue for Task 1.1
2. Issue auto-appears in "Todo"
3. Adds label "in-progress"
4. Automation moves to "In Progress"
5. Works on task
6. Closes issue when done
7. Automation moves to "Done"
```

**You see progress in real-time on the board!**

---

## Mobile Access

**GitHub Mobile App:**
- iOS: https://apps.apple.com/app/github/id1477376905
- Android: https://play.google.com/store/apps/details?id=com.github.android

View and update your board anywhere!

---

## Useful Commands

```bash
# View all issues
gh issue list --repo Den3112/slovor

# View Phase 1 tasks
gh issue list --label "phase-1" --repo Den3112/slovor

# View in-progress tasks
gh issue list --label "in-progress" --repo Den3112/slovor

# View project in CLI
gh project list
```

---

## Links

- **Your Project Board:** https://github.com/users/Den3112/projects/1
- **Repository:** https://github.com/Den3112/slovor
- **Production Site:** https://slovor.vercel.app
- **Vercel Dashboard:** https://vercel.com/slovors-projects/slovor

---

**Last Updated:** 2025-12-08 21:10 EET