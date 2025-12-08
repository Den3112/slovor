# CI/CD Pipeline

**Continuous Integration & Deployment** for Slovor using Lando + GitHub Actions

---

## Overview

Our CI/CD pipeline runs automatically on:
- ✅ Every push to `main` or `develop`
- ✅ Every pull request
- ✅ Daily scheduled checks
- ✅ Manual triggers

---

## Workflows

### 1. CI (Continuous Integration)

**File:** `.github/workflows/ci.yml`

**Triggers:**
- Push to `main` or `develop`
- Pull requests to `main` or `develop`

**Steps:**
1. Checkout code
2. Setup Lando
3. Start services
4. Verify installation
5. Run setup checks
6. Run linting (ESLint)
7. Run type checking (TypeScript)
8. Run tests (Jest)
9. Build production
10. Deploy preview (for PRs)
11. Deploy production (for main)

**Duration:** ~5-10 minutes

---

### 2. Validate Setup

**File:** `.github/workflows/validate-setup.yml`

**Triggers:**
- Daily at 6 AM UTC
- Manual dispatch

**Steps:**
1. Setup Lando
2. Validate project configuration
3. Check environment variables
4. Test database connection
5. Verify tooling commands
6. Create issue if failed

**Purpose:** Ensure project setup stays valid

---

### 3. Security Audit

**File:** `.github/workflows/security-audit.yml`

**Triggers:**
- Weekly (Mondays at 9 AM UTC)
- Manual dispatch
- When `package.json` or `package-lock.json` changes

**Steps:**
1. Run `npm audit`
2. Check for outdated packages
3. Create security issue if vulnerabilities found

**Purpose:** Keep dependencies secure

---

## GitHub Secrets

### Required Secrets

Configure in: **GitHub → Settings → Secrets → Actions**

```
VERCEL_TOKEN          # Vercel deployment token
VERCEL_ORG_ID         # Your Vercel organization ID
VERCEL_PROJECT_ID     # Slovor project ID in Vercel
```

### Get Vercel Credentials:

1. **Token:**
   ```bash
   vercel login
   vercel token create
   ```

2. **Org & Project IDs:**
   ```bash
   vercel project ls
   ```
   Or check `.vercel/project.json`

---

## Local CI Testing

Test CI pipeline locally before pushing:

### Using act (GitHub Actions locally)

```bash
# Install act
brew install act  # macOS
# or
choco install act-cli  # Windows

# Run CI workflow
act push

# Run specific job
act -j test

# Run with secrets
act -s VERCEL_TOKEN=xxx
```

### Manual CI simulation

```bash
# Start Lando
lando start

# Run all CI steps
lando setup-check
lando lint
lando tsc
lando test
lando build

# If all pass ✅ CI will pass
```

---

## Deployment Flow

### Pull Requests

```
1. Open PR
2. CI runs tests
3. If ✅ → Deploy preview to Vercel
4. Comment added to PR with preview URL
5. Review & merge
```

### Main Branch

```
1. Merge to main
2. CI runs tests
3. If ✅ → Deploy to production (slovor.vercel.app)
4. Commit comment added with deployment URL
```

---

## Monitoring

### Check Workflow Status

**GitHub UI:**
- Go to: https://github.com/Den3112/slovor/actions
- See all workflow runs
- Click on run for details

**Badge in README:**
```markdown
[![CI](https://github.com/Den3112/slovor/workflows/CI/badge.svg)](https://github.com/Den3112/slovor/actions)
```

### Failed Workflows

If workflow fails:
1. Check logs in GitHub Actions
2. Run locally: `lando start && lando test`
3. Fix issue
4. Push fix
5. Workflow re-runs automatically

---

## Notifications

### GitHub Issues

Auto-created for:
- ❌ Setup validation failures
- 🔒 Security vulnerabilities

### Email

GitHub sends email on:
- Workflow failures
- Your commits failing CI

### Slack/Discord

Add webhook notification:

```yaml
# In workflow:
- name: Notify Slack
  if: failure()
  uses: slackapi/slack-github-action@v1
  with:
    webhook-url: ${{ secrets.SLACK_WEBHOOK }}
    payload: |
      {
        "text": "CI failed on ${{ github.ref }}"
      }
```

---

## Troubleshooting

### Lando setup fails in CI

**Check:**
- `.lando-version` file exists
- Version is valid (3.21+)

**Fix:**
```bash
echo "3.21.2" > .lando-version
git add .lando-version
git commit -m "fix: add lando version file"
```

### Tests fail in CI but pass locally

**Possible causes:**
- Environment variables missing
- Database not ready
- Port conflicts

**Fix:**
```yaml
# Add wait for services
- name: Wait for database
  run: |
    lando ssh -c "until pg_isready -h database; do sleep 1; done"
```

### Deployment fails

**Check:**
- Vercel secrets are set
- Build command works: `lando build`
- `.vercel/project.json` exists

---

## Optimization

### Cache Dependencies

```yaml
- name: Cache node_modules
  uses: actions/cache@v3
  with:
    path: node_modules
    key: ${{ runner.os }}-node-${{ hashFiles('package-lock.json') }}
```

### Parallel Jobs

```yaml
jobs:
  lint:
    runs-on: ubuntu-latest
    steps: [...]
  
  test:
    runs-on: ubuntu-latest
    steps: [...]
  
  build:
    needs: [lint, test]
    runs-on: ubuntu-latest
    steps: [...]
```

### Matrix Testing

```yaml
strategy:
  matrix:
    node-version: [18, 20]
    os: [ubuntu-latest, macos-latest]
```

---

## Best Practices

1. ✅ **Always run CI checks locally first**
   ```bash
   lando lint && lando test && lando build
   ```

2. ✅ **Keep workflows fast** (<10 min)
   - Use caching
   - Parallel jobs
   - Only run necessary steps

3. ✅ **Protect main branch**
   - Require CI to pass
   - Require reviews
   - Settings → Branches → Add rule

4. ✅ **Monitor regularly**
   - Check weekly for failures
   - Fix broken workflows immediately

---

## Resources

- **GitHub Actions Docs:** https://docs.github.com/actions
- **Lando CI/CD:** https://docs.lando.dev/install/gha.html
- **Vercel GitHub Integration:** https://vercel.com/docs/git

---

**Questions? Check logs in GitHub Actions!**