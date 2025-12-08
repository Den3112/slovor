# Lando Setup Guide for Slovor

**Lando Version:** 3.21+  
**Last Updated:** 2025-12-08  

---

## Why Lando?

✅ **Simpler** than Docker Desktop + Dev Containers  
✅ **Faster** setup (one command)  
✅ **Smaller** footprint (~200MB vs 500MB)  
✅ **Auto-configuration** for Node.js + PostgreSQL  
✅ **No Docker-in-Docker issues**  

---

## Installation

### Windows

1. **Download Lando:**
   https://github.com/lando/lando/releases/latest

2. **Run installer:**
   - Download `lando-x64-v3.x.x.exe`
   - Run as Administrator
   - Follow wizard (default options OK)

3. **Restart computer**

4. **Verify installation:**
   ```bash
   lando version
   # Should show: v3.x.x
   ```

### macOS

```bash
brew install lando
```

### Linux

```bash
wget https://files.lando.dev/installer/lando-x64-stable.deb
sudo dpkg -i lando-x64-stable.deb
```

---

## Quick Start

### 1. Clone & Start

```bash
# Clone repository
git clone https://github.com/Den3112/slovor.git
cd slovor

# Start Lando
lando start

# Wait 2-3 minutes for first start
# Lando will:
# - Pull Docker images
# - Create containers
# - Install npm dependencies
# - Run setup checks
# - Start services
```

### 2. Access Services

**URLs after `lando start`:**
- **App:** http://localhost:3000
- **Database:** localhost:5432

### 3. Work

```bash
# Start development server
lando dev

# In another terminal:
lando npm install    # Install dependencies
lando lint           # Run linting
lando test           # Run tests
lando tsc            # Type check
```

---

## Common Commands

### Development

```bash
lando start          # Start all services
lando stop           # Stop all services
lando restart        # Restart all services
lando rebuild        # Rebuild containers (after config changes)
lando destroy        # Remove all containers
lando poweroff       # Stop all Lando projects
```

### npm & Node.js

```bash
lando npm install
lando npm run dev
lando npm run build
lando node --version
lando npx next dev
```

### Database

```bash
lando psql                    # Connect to PostgreSQL
lando db-reset                # Drop & recreate database
lando db-migrate              # Run migrations
lando database export         # Export database dump
lando database import dump.sql # Import database dump
```

### Quality Checks

```bash
lando lint           # ESLint
lando format         # Prettier
lando test           # Jest
lando tsc            # TypeScript check
lando setup-check    # Validate environment
lando setup-repair   # Auto-fix issues
```

### Logs

```bash
lando logs           # All logs
lando logs -s appserver  # App logs only
lando logs -s database   # Database logs only
lando logs -f        # Follow logs (live)
```

---

## Configuration

### Environment Variables

Edit `.lando.yml` → `services.appserver.overrides.environment`

Or create `.env.local` (will be loaded automatically):

```bash
cp .env.example .env.local
# Edit .env.local with your credentials
```

### Custom Commands

Add to `.lando.yml` → `tooling`:

```yaml
tooling:
  custom-command:
    service: appserver
    description: My custom command
    cmd: echo "Hello from Lando!"
```

Then run: `lando custom-command`

---

## Troubleshooting

### Port Already in Use

```bash
# Change ports in .lando.yml
services:
  appserver:
    ports:
      - '3001:3000'  # Use 3001 instead of 3000
```

### Containers Won't Start

```bash
lando rebuild -y
```

### Database Connection Issues

```bash
# Check database is running
lando info

# Restart database
lando restart -s database

# Reset database
lando db-reset
```

### npm Install Fails

```bash
# Clear npm cache
lando ssh -c "npm cache clean --force"

# Remove node_modules and reinstall
lando ssh -c "rm -rf node_modules package-lock.json"
lando npm install
```

### Lando Hangs

```bash
# Stop all Lando projects
lando poweroff

# Restart Docker
# Windows: Restart Docker Desktop
# Linux: sudo systemctl restart docker

# Start again
lando start
```

---

## Advanced Usage

### SSH into Container

```bash
lando ssh              # Default service (appserver)
lando ssh -s database  # Specific service
```

### Run Custom Scripts

```bash
lando ssh -c "bash scripts/my-script.sh"
```

### Access Files

```bash
# Files are mounted automatically
# Edit locally → changes reflect in container immediately
```

### Use Different Node Version

Edit `.lando.yml`:

```yaml
services:
  appserver:
    type: node:20  # Change to Node 20
```

Then: `lando rebuild -y`

---

## Performance Tips

### 1. Exclude node_modules from File Sync

Add to `.lando.yml`:

```yaml
services:
  appserver:
    overrides:
      volumes:
        - /app/node_modules
```

### 2. Use Cached Volumes

```yaml
services:
  appserver:
    overrides:
      volumes:
        - .:/app:cached
```

### 3. Limit Docker Resources

Docker Desktop → Settings → Resources:
- CPUs: 4
- Memory: 4GB
- Swap: 1GB

---

## Lando vs Dev Containers

| Feature | Lando | Dev Containers |
|---------|-------|----------------|
| Setup Time | 5 min | 15 min |
| Commands | `lando start` | F1 → Rebuild |
| Configuration | `.lando.yml` | `.devcontainer/` folder |
| Learning Curve | ⭐⭐ Easy | ⭐⭐⭐⭐ Hard |
| Debugging | ⭐⭐⭐⭐ Simple | ⭐⭐ Complex |
| Performance | ⭐⭐⭐⭐⭐ Fast | ⭐⭐⭐ OK |

---

## Migration from Dev Containers

If you were using Dev Containers before:

1. **Keep old config** (optional backup):
   ```bash
   mv .devcontainer .devcontainer.bak
   ```

2. **Use Lando instead:**
   ```bash
   lando start
   ```

3. **That's it!** Everything works the same, just simpler commands.

---

## Resources

- **Lando Docs:** https://docs.lando.dev
- **Lando GitHub:** https://github.com/lando/lando
- **Our Project:** https://github.com/Den3112/slovor

---

## Support

Issues? Check:
1. `lando logs` - See what's wrong
2. `lando rebuild -y` - Rebuild from scratch
3. GitHub Issues - Report bugs

---

**Happy coding with Lando! 🚀**