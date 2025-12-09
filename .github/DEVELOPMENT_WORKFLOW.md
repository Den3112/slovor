# Development Workflow Standards

**Version:** 1.0  
**Last Updated:** 2025-12-10  
**Purpose:** Standardized workflow for completing development tasks from start to deployment

---

## Overview

Every development task MUST follow this complete workflow. A task is NOT done until all steps are completed.

---

## Complete Task Workflow

### Phase 1: Planning
1. **Understand Requirements**
   - Read task description thoroughly
   - Clarify any ambiguities
   - Identify dependencies

2. **Break Down Task**
   - Split into smaller sub-tasks
   - Estimate time for each
   - Plan implementation order

### Phase 2: Implementation
3. **Write Code**
   - Follow coding standards (see CODING_STANDARDS.md)
   - Use TypeScript strict mode
   - Write self-documenting code
   - Add comments only for complex logic

4. **Test Locally**
   ```bash
   pnpm lint        # Must pass
   pnpm type-check  # Must pass
   pnpm test        # Must pass
   pnpm build       # Must succeed
   pnpm dev         # Must run without errors
   ```

5. **Verify Functionality**
   - Test in browser/app
   - Check console for errors
   - Test edge cases
   - Verify mobile responsiveness (if UI)

### Phase 3: Documentation
6. **Update Documentation**
   - Update README.md if needed
   - Add/update code comments
   - Update API documentation
   - Add examples if needed

### Phase 4: Git Operations (CRITICAL)
7. **Stage Changes**
   ```bash
   git status                    # Review what changed
   git add .                     # Stage all changes
   git status                    # Verify staged files
   ```

8. **Commit with Proper Message**
   ```bash
   git commit -m "type(scope): subject

   [Detailed description of what was done]

   [Why this change was made]

   [Any breaking changes or important notes]

   Closes #[issue-number]"
   ```

   **Commit Message Guidelines:**
   - **type**: feat, fix, docs, style, refactor, test, chore
   - **scope**: component/feature affected (optional)
   - **subject**: imperative mood, lowercase, <50 chars
   - **body**: detailed explanation (optional but recommended)
   - **footer**: issue references, breaking changes

   **Examples:**
   ```bash
   # Feature
   git commit -m "feat(auth): add email verification

   Implement email verification flow:
   - Send verification email on signup
   - Create verification token table
   - Add email verification UI
   - Block unverified users from posting ads

   Closes #42"

   # Bug fix
   git commit -m "fix(search): handle empty query gracefully

   Previously crashed on empty search input.
   Now returns all results when query is empty.

   Closes #38"

   # Documentation
   git commit -m "docs(readme): update installation steps

   Add missing environment variable setup.
   Clarify Supabase configuration steps."
   ```

9. **Push to GitHub**
   ```bash
   git push origin main          # Or your branch name
   ```

   **Verify Push Success:**
   ```bash
   git log --oneline -1          # Should show your commit
   ```

### Phase 5: GitHub Issue Management
10. **Close Related Issues**

    **Option A: Via Commit (Automatic)**
    ```bash
    # Include in commit message:
    Closes #42
    Fixes #38
    Resolves #27
    ```

    **Option B: Manual Closure**
    - Visit issue on GitHub
    - Add completion comment:
      ```
      ✅ Completed

      **What was done:**
      - [List changes]

      **Verification:**
      - ✓ Tests passing
      - ✓ Build successful
      - ✓ Deployed to production

      Commit: [SHA]
      ```
    - Click "Close issue"

    **Option C: GitHub CLI**
    ```bash
    gh issue close 42 -c "✅ Completed. See commit [SHA]"
    ```

### Phase 6: Project Board Update
11. **Update Project Board**
    - Visit: https://github.com/users/Den3112/projects/3
    - Move completed issues to "Done" column
    - Update task status/labels if needed
    - Add notes if required

### Phase 7: Deployment Verification
12. **Verify Vercel Deployment**
    - Check: https://vercel.com/slovors-projects/slovor
    - Wait for deployment to complete (usually <2 min)
    - Status should show: ✓ Ready

13. **Test Production**
    - Visit: https://slovor.vercel.app
    - Test the new feature/fix
    - Check browser console (no errors)
    - Verify functionality works as expected

14. **Monitor for Issues**
    - Check Vercel logs if errors
    - Monitor Sentry/error tracking (if configured)
    - Be ready to hotfix if needed

### Phase 8: Final Verification
15. **Complete Task Checklist**
    - [ ] Code written and tested locally
    - [ ] All tests passing (`pnpm test`)
    - [ ] Linting passing (`pnpm lint`)
    - [ ] Type checking passing (`pnpm type-check`)
    - [ ] Build successful (`pnpm build`)
    - [ ] Code committed with proper message
    - [ ] Changes pushed to GitHub
    - [ ] Related issue(s) closed
    - [ ] Project board updated
    - [ ] Documentation updated (if needed)
    - [ ] Vercel deployment successful
    - [ ] Production site tested
    - [ ] No console errors in production

---

## AI Prompt Template

Every AI-generated task prompt MUST include this section at the end:

```markdown
## Commit & Deploy

After completing this task:

### 1. Verify Everything Works
```bash
cd slovor/
pnpm lint
pnpm type-check
pnpm test
pnpm build
pnpm dev  # Test in browser
```

### 2. Commit Changes
```bash
cd ..  # Back to repo root
git add .
git status  # Review changes

git commit -m "type(scope): descriptive title

[What was implemented]
[Why it was needed]
[Any important notes]

Closes #[issue-number]"
```

### 3. Push to GitHub
```bash
git push origin main
git log --oneline -1  # Verify
```

### 4. Close GitHub Issues
- Visit issue #[number]
- Add completion comment
- Close issue

OR use CLI:
```bash
gh issue close [number] -c "✅ Completed in [commit SHA]"
```

### 5. Update Project Board
- Move issue to "Done": https://github.com/users/Den3112/projects/3

### 6. Verify Deployment
- Check Vercel: https://vercel.com/slovors-projects/slovor
- Test production: https://slovor.vercel.app
- Verify functionality works

### 7. Final Checklist
- [ ] Tests passing
- [ ] Build successful
- [ ] Committed & pushed
- [ ] Issue closed
- [ ] Board updated
- [ ] Deployed & verified
```
---

## Common Mistakes to Avoid

### ❌ Don't Do This:
- Commit without testing
- Push without verifying build
- Leave issues open after completing work
- Skip documentation updates
- Forget to test in production
- Use vague commit messages like "fix bug" or "update code"
- Commit commented-out code
- Leave console.log statements

### ✅ Do This:
- Test thoroughly before committing
- Use descriptive commit messages
- Close issues immediately after push
- Update docs as you code
- Verify production deployment
- Keep commits atomic (one logical change)
- Clean up debug code before committing

---

## Emergency Hotfix Workflow

For critical production bugs:

1. **Create hotfix branch**
   ```bash
   git checkout -b hotfix/critical-bug-name
   ```

2. **Fix the bug**
   - Make minimal changes
   - Test thoroughly

3. **Fast-track commit**
   ```bash
   git add .
   git commit -m "fix(critical): [description]
   
   HOTFIX: [what broke]
   [how it's fixed]
   
   Closes #[issue]"
   ```

4. **Push and merge immediately**
   ```bash
   git push origin hotfix/critical-bug-name
   # Create PR and merge to main ASAP
   ```

5. **Verify deployment**
   - Watch Vercel deploy
   - Test production immediately
   - Monitor for new errors

---

## Branch Strategy

### Main Branch (main)
- Always production-ready
- Protected (requires PR for large teams)
- Auto-deploys to Vercel

### Feature Branches (optional for solo dev)
- `feature/task-name`
- `fix/bug-name`
- Merge to main when done

### For Solo Development
- Can commit directly to main for small changes
- Use branches for experimental features

---

## Pull Request Template

When using PRs (for team or large features):

```markdown
## Description
[What does this PR do?]

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Breaking change
- [ ] Documentation update

## Testing
- [ ] Local tests pass
- [ ] Build succeeds
- [ ] Tested in browser
- [ ] Mobile responsive (if UI)

## Checklist
- [ ] Code follows style guidelines
- [ ] Self-reviewed code
- [ ] Commented complex code
- [ ] Updated documentation
- [ ] No console warnings/errors

## Related Issues
Closes #[issue number]

## Screenshots (if UI change)
[Add screenshots]
```

---

## Workflow Automation Tips

### Git Aliases (optional)
```bash
# Add to ~/.gitconfig
[alias]
    cm = commit -m
    st = status
    ps = push origin main
    lg = log --oneline --graph --decorate
```

### Scripts
Create `scripts/commit.sh`:
```bash
#!/bin/bash
pnpm lint && pnpm type-check && pnpm build && git add . && echo "Ready to commit!"
```

---

## Summary

**Remember:** A task is NOT complete until:
1. ✅ Code works locally
2. ✅ Tests pass
3. ✅ Committed with good message
4. ✅ Pushed to GitHub
5. ✅ Issue closed
6. ✅ Board updated
7. ✅ Deployed to production
8. ✅ Verified working live

**This workflow ensures quality and prevents incomplete work.**

---

**Questions?** See related docs:
- [Coding Standards](CODING_STANDARDS.md)
- [AI Agent System](AI_AGENT_SYSTEM.md)
- [Project Setup](PROJECT_SETUP.md)
