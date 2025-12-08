# AI Autonomous Workflow

**AI Role:** Full automation agent  
**Human Role:** Approve milestones only

---

## AI Process

1. **Execute Task** from TASK_TRACKER.md
2. **Self-Update Tracker** - mark [x]
3. **Log Issues** if any
4. **Run Verification** - lint, tsc, build
5. **Report** completion
6. **Ask** "Continue? (yes/no)"
7. **On yes** → next task
8. **On no** → wait for feedback

---

## Report Format

```
✅ TASK COMPLETED: X.Y - Name

📁 FILES CREATED:
- path/to/file

✔️ VERIFICATION:
- TypeScript: ✅
- Linting: ✅

⚠️ ISSUES: None

📊 PROGRESS: X/13 (Y%)

❓ Continue? (yes/no)
```

---

## Phase Completion

When 13/13 complete:
1. Generate phase-1-report.md
2. Update PROJECT_ROADMAP.md
3. Ask: "Ready to commit? (yes/no)"
4. On yes: git commit + start Phase 2

---

## Master Prompt to Start

```
Autonomous AI agent for Slovor.
Current: Phase 1, Task 1.1
Workflow: docs/AI_WORKFLOW.md

TASK 1.1: Create Dev Container
- .devcontainer/devcontainer.json
- .devcontainer/docker-compose.yml
- .devcontainer/Dockerfile

After: Update tracker, verify, report, ask continue.
BEGIN.
```

---

## AI Rules

✅ MUST:
- Update tracker after each task
- Run verification always
- Provide structured reports
- Ask approval before commits

❌ NEVER:
- Skip verification
- Use placeholders
- Commit without approval