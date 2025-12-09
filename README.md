# Slovor Development Environment

**Production-ready development setup with Lando, Docker, and WSL2**

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Lando](https://img.shields.io/badge/Lando-3.21-blue.svg)](https://lando.dev)
[![Node](https://img.shields.io/badge/Node-18-green.svg)](https://nodejs.org)
[![Next.js](https://img.shields.io/badge/Next.js-15-black.svg)](https://nextjs.org)

**🌐 Production:** https://slovor.vercel.app

---

## 🚀 Quick Start

```bash
# Clone
git clone https://github.com/Den3112/slovor.git slovor_dev
cd slovor_dev

# Start (everything auto-installs)
lando start

# Run dev server
lando dev
```

**Done!** Open http://localhost:3000

---

## 📁 Project Structure

```
slovor_dev/                    # Repository root
├── slovor/                    # Main Next.js application
│   ├── src/                   # Source code
│   ├── public/                # Static assets
│   ├── supabase/              # Supabase config & migrations
│   ├── package.json
│   └── .env.example          # Environment template
├── docs/                      # Documentation
│   ├── PROJECT_ROADMAP.md
│   ├── LANDO_SETUP.md
│   ├── WSL2_SETUP.md
│   ├── SHELL_SETUP.md
│   └── TESTING.md
├── scripts/                   # Development scripts
│   ├── setup-check.sh         # Validate setup
│   ├── setup-repair.sh        # Auto-fix issues
│   ├── lando-doctor.sh        # System diagnostics
│   ├── cleanup-docker.sh      # Docker cleanup
│   └── show-urls.sh           # Show all URLs
├── .github/                   # GitHub workflows
├── .lando.yml                 # Lando configuration
└── README.md                  # This file
```

---

## 📚 Common Commands

### Development

```bash
lando dev          # Start Next.js dev server
lando build        # Build for production
lando lint         # Run ESLint
lando lint:fix     # Auto-fix lint issues
lando test         # Run tests
lando health       # Quick health check
lando doctor       # Full system diagnostics
lando urls         # Show all URLs
```

### Database

```bash
lando psql         # PostgreSQL shell
lando db-dump      # Export database
lando db-reset     # Reset database
lando db-migrate   # Run migrations
```

### Docker Management

```bash
# Docker cleanup (run from WSL, not via lando)
bash scripts/cleanup-docker.sh        # Safe cleanup
bash scripts/cleanup-docker.sh --hard # Nuclear cleanup

# Container info
lando info         # Show container info
lando logs         # Show container logs
```

### Project Management

```bash
lando start        # Start containers
lando stop         # Stop containers
lando restart      # Restart containers
lando rebuild      # Rebuild from scratch
lando ssh          # Shell into app container
```

---

## 🧹 Docker Cleanup & Optimization

### Quick Cleanup (Safe)

Removes unused containers, images, and volumes:

```bash
bash scripts/cleanup-docker.sh
```

Run this **weekly** to keep Docker tidy.

### Nuclear Cleanup (Dangerous)

Removes **EVERYTHING** (use only if really needed):

```bash
bash scripts/cleanup-docker.sh --hard
```

⚠️ **WARNING:** This will delete all Docker data. You'll need to run `lando rebuild` after.

### What Gets Cleaned

**Safe cleanup:**
- Stopped containers
- Unused images
- Unused volumes
- Unused networks
- Old Lando proxy containers

**Hard cleanup:**
- **ALL** containers (running and stopped)
- **ALL** images
- **ALL** volumes (including data!)
- **ALL** networks

### Manual Cleanup

```bash
# Remove old Lando proxy containers
docker stop $(docker ps -a | grep landoproxy | awk '{print $1}') 2>/dev/null || true
docker rm $(docker ps -a | grep landoproxy | awk '{print $1}') 2>/dev/null || true

# Clean everything manually
docker container prune -f
docker image prune -f
docker volume prune -f
docker network prune -f
```

### Docker Desktop Settings

For optimal performance:

1. Open Docker Desktop → Settings → Resources
2. Set:
   - **CPU:** 2-4 cores
   - **Memory:** 4-6 GB
   - **Swap:** 1 GB
   - **Disk:** 64 GB

These limits prevent Docker from consuming all system resources.

---

## 🌐 Access URLs

### Development

- **Local:** http://localhost:3000
- **API:** http://localhost:3000/api

### Production

- **Live Site:** https://slovor.vercel.app

### Database

- **PostgreSQL:** localhost:5432
- **User:** postgres
- **Password:** postgres
- **Database:** slovor

### External Services

- **Production:** https://slovor.vercel.app
- **Supabase:** https://rsywmmnxkvwvhgrgzlei.supabase.co
- **GitHub:** https://github.com/Den3112/slovor

Run `lando urls` to see all endpoints.

---

## 📖 Documentation

- **[Project Roadmap](docs/PROJECT_ROADMAP.md)** - Development plan
- **[Lando Setup](docs/LANDO_SETUP.md)** - Lando configuration guide
- **[WSL2 Setup](docs/WSL2_SETUP.md)** - Windows + WSL2 installation
- **[Shell Setup](docs/SHELL_SETUP.md)** - Terminal auto-navigation
- **[Testing Guide](docs/TESTING.md)** - How to test everything
- **[Coding Standards](.github/CODING_STANDARDS.md)** - Code style guide

---

## 🛠️ Tech Stack

### Application (slovor/)

- **Framework:** Next.js 15 (React 19)
- **Language:** TypeScript
- **Database:** PostgreSQL + Supabase
- **Styling:** Tailwind CSS
- **Linting:** ESLint + Prettier
- **Testing:** Jest + React Testing Library
- **Deployment:** Vercel (https://slovor.vercel.app)

### Development Environment (root)

- **Container Platform:** Lando 3.21+ (Docker)
- **Runtime:** Node.js 18
- **Database:** PostgreSQL 15
- **OS:** WSL2 (Ubuntu 24.04)
- **Automation:** Bash scripts

---

## 🤖 AI-Powered Development

This project is optimized for AI-assisted development:

- **Cursor/Windsurf:** Auto-opens in project directory
- **GitHub Copilot:** Enhanced with project context
- **AI Prompts:** Pre-configured in `.github/AI_GUIDELINES.md`

---

## 🔗 Links

- **Production:** https://slovor.vercel.app
- **GitHub:** https://github.com/Den3112/slovor
- **Issues:** https://github.com/Den3112/slovor/issues
- **Discussions:** https://github.com/Den3112/slovor/discussions
- **Lando Docs:** https://docs.lando.dev
- **Next.js Docs:** https://nextjs.org/docs
- **Supabase Docs:** https://supabase.com/docs
- **Vercel Docs:** https://vercel.com/docs

---

## 🐛 Troubleshooting

### Containers won't start?

```bash
lando poweroff
sudo service docker restart
lando start
```

### Port already in use?

```bash
sudo lsof -ti:3000 | xargs kill -9
lando restart
```

### Database connection failed?

```bash
lando db-reset
lando restart
```

### Docker taking too much space?

```bash
bash scripts/cleanup-docker.sh        # Safe cleanup
bash scripts/cleanup-docker.sh --hard # Nuclear option
```

### Full diagnostic:

```bash
lando doctor
```

For more help: [docs/TESTING.md](docs/TESTING.md)

---

## 🤝 Contributing

1. Fork the repository
2. Create feature branch (`git checkout -b feature/amazing`)
3. Make changes in `slovor/` directory for app code
4. Commit changes (`git commit -m 'feat: add amazing feature'`)
5. Push to branch (`git push origin feature/amazing`)
6. Open Pull Request

[Coding standards →](.github/CODING_STANDARDS.md)

---

## 📄 License

MIT License - see [LICENSE](LICENSE) file

---

## 💬 Support

- **Issues:** [GitHub Issues](https://github.com/Den3112/slovor/issues)
- **Discussions:** [GitHub Discussions](https://github.com/Den3112/slovor/discussions)
- **Production:** https://slovor.vercel.app

---

**Made with ❤️ using Lando & AI**
