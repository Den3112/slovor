# AI Agent System - Simple Commands

**Purpose:** Control AI with simple commands  
**Human Role:** Give commands, approve milestones  
**AI Role:** Execute, report, ask approval

---

## Quick Commands

### Start Development
```
start phase 1
```

### Continue After Break
```
continue
```

### Check Status
```
status
```

### Skip to Task
```
skip to task 2.5
```

### Approve Phase
```
approve phase 1
```

### Stop/Pause
```
stop
```

---

## Command Reference

| Command | Action | Example |
|---------|--------|----------|
| `start phase X` | Begin phase | `start phase 1` |
| `continue` | Resume work | `continue` |
| `status` | Show progress | `status` |
| `skip to task X.Y` | Jump to task | `skip to task 1.5` |
| `approve phase X` | Commit & next | `approve phase 1` |
| `stop` | Pause AI | `stop` |
| `help` | Show commands | `help` |
| `rollback` | Undo last task | `rollback` |

---

## AI Auto Actions

✅ AI does automatically:
- Create/modify files
- Update task tracker
- Run verification
- Log issues
- Report completion

⚠️ AI asks approval for:
- Git commits
- New phase start
- Destructive changes
- Production deploys

---

## Example Usage

```
Human: start phase 1

AI: 🚀 Starting Phase 1
Executing Task 1.1...
✅ Task 1.1 complete (1/13)
✅ Task 1.2 complete (2/13)
...
🎉 Phase 1 Complete!
❓ Approve commit? (yes/no)

Human: yes

AI: ✅ Committed
🚀 Starting Phase 2...
```

---

**Last Updated:** 2025-12-08