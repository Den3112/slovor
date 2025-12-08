# Issues Log

**Last Updated:** 2025-12-08

---

## Active Issues

_No active issues_

---

## Resolved Issues

_No resolved issues yet_

---

## Quick Fixes

### Docker won't start
```bash
docker system prune -a
docker compose -f .devcontainer/docker-compose.yml build --no-cache
```

### TypeScript errors
```bash
rm -rf node_modules .next
npm install
npx tsc --noEmit
```

### Supabase migrations fail
```bash
supabase db reset
supabase db push
```