# GitHub Projects Integration

**Status:** Fully automated  
**Board:** https://github.com/users/Den3112/projects/1

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
Issue appears in "Backlog" column
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

## Board Structure

### Columns

| Column | Description | Auto-move trigger |
|--------|-------------|------------------|
| 📋 Backlog | Not started | Issue opened |
| ✅ Todo | Ready to start | Label: `ready` |
| 🔄 In Progress | Currently working | Label: `in-progress` |
| 👀 Review | Code review | PR opened |
| ✅ Done | Completed | Issue/PR closed |

### Labels

- `phase-1`, `phase-2`, etc. - Phase identifier
- `infrastructure` - Dev env setup
- `feature` - New functionality
- `bug` - Bug fix
- `documentation` - Docs only
- `in-progress` - Currently working
- `ready` - Ready to start

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
gh issue edit 1 --add-label "in-progress"
```

### Complete Task
```bash
gh issue close 1 --comment "✅ Task completed"
```

### Create PR
```bash
gh pr create \
  --title "feat: complete phase 1" \
  --body "Closes #1, #2, #3" \
  --label "phase-1"
```

---

## Viewing Progress

### Desktop
https://github.com/users/Den3112/projects/1

### Mobile
GitHub Mobile App → Projects → Slovor Development

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

## Metrics

### Velocity
Tasks completed per day (auto-calculated)

### Burndown
Remaining tasks over time

### Cycle Time
Time from "Todo" to "Done"

---

## Setup (One-time)

### 1. Create Project
```bash
# Using GitHub CLI
gh project create --owner Den3112 --title "Slovor Development"
```

### 2. Run Issue Creation Script
```bash
node scripts/create-issues-from-tasks.js
```

### 3. Done!
Everything else is automated.

---

**Last Updated:** 2025-12-08