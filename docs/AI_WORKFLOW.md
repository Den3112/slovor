# AI Autonomous Workflow

**AI Role:** Full automation agent with human approval checkpoints  
**Human Role:** Approve phase completion only  

---

## AI Instructions (READ CAREFULLY)

You are an autonomous development agent. Follow this workflow for EVERY task:

### Step 1: Execute Task
- Read task from TASK_TRACKER.md
- Create/modify files as specified
- Write production-ready code (no placeholders)

### Step 2: Self-Update Task Tracker
**IMPORTANT:** After completing task, update TASK_TRACKER.md:
- Change `[ ]` to `[x]` for completed subtasks
- Update task count (e.g., "0/3" → "3/3")
- Change status from "Not Started" to "✅ Completed"
- Add completion timestamp

Example:
```markdown
### 1.1 Dev Container Setup (3/3) ✅
- [x] Create `.devcontainer/devcontainer.json`
- [x] Create `.devcontainer/docker-compose.yml`  
- [x] Create `.devcontainer/Dockerfile`
- **Status:** ✅ Completed
- **Completed:** 2025-12-08 20:45 EET
```

### Step 3: Log Issues (if any)
If you encounter problems:
- Add entry to ISSUES_LOG.md with issue number
- Mark severity: 🔴 Critical / 🟡 Warning / 🟢 Minor
- Provide solution or mark "Under investigation"

### Step 4: Run Verification
Execute commands from task requirements:
```bash
npm install      # if package.json changed
npm run lint     # always
npm run build    # for major changes
npx tsc --noEmit # always
```

Report verification results in response.

### Step 5: Report to Human
Provide structured report:

```
✅ TASK COMPLETED: [Task Number] - [Task Name]

📁 FILES CREATED/MODIFIED:
- path/to/file1.ext (created, 150 lines)
- path/to/file2.ext (modified, +50 lines)

✔️ VERIFICATION RESULTS:
- TypeScript: ✅ No errors
- Linting: ✅ Passed
- Build: ✅ Success (2.3s)

⚠️ ISSUES FOUND:
- Issue #001 logged in ISSUES_LOG.md (🟡 Warning, resolved)
- OR: None

📊 PHASE PROGRESS: X/13 tasks complete (Y%)

🔄 NEXT ACTION:
Moving to Task [Number] - [Name]
OR
Phase [X] complete! Generating report...

❓ AWAITING HUMAN CONFIRMATION: Continue? (yes/no)
```

### Step 6: Wait for Human Response

**If human says "yes":**
- Proceed to next task immediately
- Repeat Steps 1-6

**If human says "no":**
- Ask: "What needs changes?"
- Wait for feedback
- Make changes
- Re-verify
- Ask approval again

### Step 7: Phase Completion (when all tasks done)

When all tasks in phase are complete:

1. **Create Phase Report:**
   - Generate `PHASE_REPORTS/phase-X-report.md` using template
   - Include all tasks, files, issues, verification results
   - Calculate metrics (build time, task completion %, issues count)

2. **Update PROJECT_ROADMAP.md:**
   - Change phase status from "🔄 In Progress" to "✅ Complete"
   - Add completion date
   - Update timeline table
   - Mark milestone checkbox

3. **Ask for Approval:**
```
🎉 PHASE [X] COMPLETE!

📊 Summary:
- Tasks completed: Y/Y (100%)
- Files created: Z
- Issues encountered: W (all resolved)
- Build status: ✅ Passing
- Verification: ✅ All checks passed

📄 Report generated: PHASE_REPORTS/phase-X-report.md

🔄 NEXT PHASE: Phase [X+1] - [Name]

❓ AWAITING HUMAN APPROVAL:
Ready to commit changes and start Phase [X+1]? (yes/no)

If yes: I will commit with message "feat: complete phase X - [description]"
If no: Please specify what needs review/changes
```

4. **On Human "yes":**
   - Execute: `git add .`
   - Execute: `git commit -m "feat: complete phase X - [description]"`
   - Update TASK_TRACKER.md: add Phase X+1 tasks
   - Start Task 1 of Phase X+1

5. **On Human "no":**
   - Ask: "What needs to be reviewed or changed?"
   - Wait for specific feedback
   - Make requested changes
   - Re-run verification
   - Ask for approval again

---

## Master Prompt for Phase 1 Start

**Copy this to Killo Code to begin:**

```
You are an autonomous AI development agent for Slovor marketplace project.

CURRENT STATUS:
- Phase: 1 (MVP Foundation)
- Task: 1.1 (Dev Container Setup)
- Mode: Autonomous with human checkpoints

YOUR WORKFLOW:
1. Execute task from docs/TASK_TRACKER.md
2. Self-update docs/TASK_TRACKER.md (mark completed)
3. Log issues to docs/ISSUES_LOG.md (if any)
4. Run verification commands
5. Report completion to human
6. Ask "Continue to next task? (yes/no)"
7. On "yes": proceed to next task automatically
8. On "no": wait for feedback
9. When phase complete: generate report, update roadmap, ask for commit approval

TASK 1.1 REQUIREMENTS:
Create Dev Container configuration in .devcontainer/ directory.

Files to create:
1. .devcontainer/devcontainer.json
   - Name: "Slovor Development"
   - dockerComposeFile: "docker-compose.yml"
   - service: "app"
   - workspaceFolder: "/workspace"
   - customizations.vscode.extensions: ["dbaeumer.vscode-eslint", "esbenp.prettier-vscode", "bradlc.vscode-tailwindcss", "supabase.supabase-vscode", "Codeium.codeium", "ms-azuretools.vscode-docker"]
   - customizations.vscode.settings: formatOnSave true, defaultFormatter prettier, eslint autofix
   - forwardPorts: [3000, 5432, 54321]
   - postCreateCommand: "npm install && npm run prepare"
   - remoteUser: "node"
   - features: Node 18, GitHub CLI, Docker-in-Docker

2. .devcontainer/docker-compose.yml
   - version: "3.8"
   - services: app (build from Dockerfile, volumes workspace + node_modules, command sleep infinity, ports 3000, depends postgres) + postgres (image supabase/postgres:15, env POSTGRES_USER/PASSWORD/DB, ports 5432, volumes postgres-data + migrations:/docker-entrypoint-initdb.d:ro)
   - networks: slovor-net
   - volumes: postgres-data, node_modules

3. .devcontainer/Dockerfile
   - FROM node:18-bullseye
   - RUN apt-get update && install git curl postgresql-client
   - RUN npm install -g supabase typescript ts-node
   - RUN useradd -m -s /bin/bash node
   - USER node
   - WORKDIR /workspace

After creating files:
1. Update docs/TASK_TRACKER.md → mark Task 1.1 as [x] completed
2. Verify: docker compose -f .devcontainer/docker-compose.yml config
3. Report completion with file list
4. Ask: "Task 1.1 complete. Continue to Task 1.2? (yes/no)"

BEGIN EXECUTION NOW.
```

---

## Phase 2+ Prompts

After Phase 1, use continuation prompt:

```
Continue Slovor development. Current phase from docs/PROJECT_ROADMAP.md.
Execute next incomplete task from docs/TASK_TRACKER.md.
Follow autonomous workflow from docs/AI_WORKFLOW.md.
Self-update tracker, log issues, verify, report, ask approval.
BEGIN.
```

---

## Human Responses

**To continue next task:**
```
yes
```

**To approve phase completion:**
```
yes
```

**To request changes:**
```
no - [specific feedback]
Example: no - update typescript config to use stricter rules
```

**To skip to specific task:**
```
skip to task 1.5
```

**To review before continuing:**
```
pause - let me review
```

---

## AI Self-Management Rules

### MUST DO:
✅ Always update TASK_TRACKER.md after task completion
✅ Always run verification commands
✅ Always log issues with severity
✅ Always ask for human approval before phase transition
✅ Always provide structured reports

### MUST NOT:
❌ Never skip verification
❌ Never leave placeholders in code
❌ Never commit without human approval
❌ Never proceed to next phase without complete report

---

## Emergency Commands

**Human can interrupt with:**
- `stop` - AI pauses, waits for instructions
- `rollback` - AI reverts last task changes
- `status` - AI reports current phase/task/progress
- `skip phase X` - AI jumps to specified phase
