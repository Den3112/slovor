# Slovor Development Environment

**Monorepo structure** for Slovor marketplace development.

[![Production](https://img.shields.io/badge/Production-Live-green)](https://slovor.vercel.app)
[![GitHub](https://img.shields.io/badge/GitHub-slovor-blue)](https://github.com/Den3112/slovor)
[![Lando](https://img.shields.io/badge/Lando-Ready-orange)](https://lando.dev)

---

## 📁 Project Structure

```
slovor_dev/                    # Repository root
├── slovor/                    # Main Next.js application
│   ├── src/
│   ├── public/
│   ├── supabase/
│   ├── package.json
│   └── ...
├── docs/                      # Documentation
│   ├── PROJECT_ROADMAP.md
│   ├── LANDO_SETUP.md
│   └── ...
├── scripts/                   # Development scripts
│   ├── setup-check.sh
│   ├── setup-repair.sh
│   └── ...
├── .github/                   # GitHub workflows & configs
│   ├── workflows/
│   └── ...
├── .lando.yml                 # Lando configuration
├── .lando-version             # Lando version lock
└── README.md                  # This file
```

### Why This Structure?

✅ **Separation of concerns** - App code separate from dev environment  
✅ **Cleaner app folder** - `slovor/` contains only application code  
✅ **Scalability** - Easy to add more apps/packages later  
✅ **Clear organization** - Docs and scripts in logical places  

---

## 🚀 Quick Start

### Prerequisites
- **Lando** - [Install here](https://github.com/lando/lando/releases/latest)
- **Git** - For cloning repository

### Setup

```bash
# Clone as slovor_dev
git clone https://github.com/Den3112/slovor.git slovor_dev
cd slovor_dev

# Start everything!
lando start

# Wait 2-3 minutes... Done! 🎉
```

**That's it!** Lando automatically:
- ✅ Sets up Node.js 18
- ✅ Creates PostgreSQL database
- ✅ Installs dependencies in `slovor/`
- ✅ Runs setup checks
- ✅ Starts dev server

---

## 📚 Common Commands

### Development
```bash
lando dev          # Start dev server (http://localhost:3000)
lando npm install  # Install dependencies
lando npm run ...  # Any npm command
lando lint         # Run ESLint
lando test         # Run tests
lando build        # Build for production
```

### Database
```bash
lando psql         # Connect to database
lando db-reset     # Reset database
lando db-migrate   # Run migrations
```

### Project Management
```bash
lando setup-check  # Validate setup
lando setup-repair # Auto-fix issues
lando logs         # View logs
lando restart      # Restart services
lando stop         # Stop services
```

[See all commands →](docs/LANDO_SETUP.md)

---

## 📖 Documentation

- [Lando Setup Guide](docs/LANDO_SETUP.md) - Full Lando documentation
- [Quick Start](docs/QUICK_START.md) - Fast setup guide
- [Project Roadmap](docs/PROJECT_ROADMAP.md) - Development phases
- [Task Tracker](docs/TASK_TRACKER.md) - Current tasks
- [CI/CD Pipeline](docs/CI_CD.md) - Automated testing & deployment
- [Coding Standards](.github/CODING_STANDARDS.md) - Code guidelines
- [AI Workflow](docs/AI_WORKFLOW.md) - AI automation

---

## 🛠️ Tech Stack

### Application (`slovor/`)
- **Frontend:** Next.js 15, React 19, TypeScript 5, Tailwind CSS 4
- **Backend:** Supabase (PostgreSQL, Auth, Storage)
- **Deployment:** Vercel

### Development Environment (root)
- **Runtime:** Lando + Docker
- **Quality:** ESLint, Prettier, Jest
- **CI/CD:** GitHub Actions
- **Automation:** Bash scripts

---

## 🤖 AI-Powered Development

This project uses AI automation for development:

```
In Killo Code (Windsurf IDE):
  start phase 1    # AI starts Phase 1 tasks
  continue         # Resume work
  status           # Check progress
  approve phase 1  # Complete phase
```

[Learn more →](docs/AI_WORKFLOW.md)

---

## 🔗 Links

- **Production:** https://slovor.vercel.app
- **GitHub:** https://github.com/Den3112/slovor
- **GitHub Projects:** https://github.com/users/Den3112/projects/1
- **Vercel Dashboard:** https://vercel.com/slovors-projects/slovor
- **Supabase:** https://rsywmmnxkvwvhgrgzlei.supabase.co

---

## 🐛 Troubleshooting

### Containers won't start?
```bash
lando rebuild -y
```

### Database issues?
```bash
lando db-reset
lando db-migrate
```

### npm install fails?
```bash
lando ssh
cd slovor
rm -rf node_modules package-lock.json
npm install
```

[Full troubleshooting guide →](docs/LANDO_SETUP.md#troubleshooting)

---

## 📊 Project Status

**Current Phase:** Phase 1 - MVP Foundation  
**Progress:** 0/13 tasks  
**Next Milestone:** Development environment ready

[View roadmap →](docs/PROJECT_ROADMAP.md)

---

## 👥 Contributing

1. Fork the repository
2. Create feature branch (`git checkout -b feature/amazing`)
3. Work in `slovor/` directory for app code
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

---

**Made with ❤️ using Lando & AI**