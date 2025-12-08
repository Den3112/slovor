# Slovor Marketplace

**Classifieds marketplace for Slovakia** - Buy and sell vehicles, real estate, jobs, and more.

[![Production](https://img.shields.io/badge/Production-Live-green)](https://slovor.vercel.app)
[![GitHub](https://img.shields.io/badge/GitHub-slovor-blue)](https://github.com/Den3112/slovor)
[![Lando](https://img.shields.io/badge/Lando-Ready-orange)](https://lando.dev)

---

## 🚀 Quick Start (2 commands!)

### Prerequisites
- **Lando** - [Install here](https://github.com/lando/lando/releases/latest)
- **Git** - For cloning repository

### Setup

```bash
# Clone repository
git clone https://github.com/Den3112/slovor.git
cd slovor

# Start everything!
lando start

# Wait 2-3 minutes... Done! 🎉
```

**That's it!** Lando automatically:
- ✅ Sets up Node.js 18
- ✅ Creates PostgreSQL database
- ✅ Installs dependencies
- ✅ Runs setup checks
- ✅ Starts dev server

---

## 📚 Common Commands

```bash
lando dev          # Start development server (http://localhost:3000)
lando lint         # Run ESLint
lando test         # Run tests
lando format       # Format code with Prettier
lando psql         # Connect to database
lando npm install  # Install dependencies
lando stop         # Stop all services
```

[See all commands →](docs/LANDO_SETUP.md)

---

## 🛠️ Tech Stack

- **Frontend:** Next.js 15, React 19, TypeScript 5, Tailwind CSS 4
- **Backend:** Supabase (PostgreSQL, Auth, Storage)
- **Deployment:** Vercel
- **Development:** Lando, ESLint, Prettier, Jest

---

## 📖 Documentation

- [Lando Setup Guide](docs/LANDO_SETUP.md) - Installation & usage
- [Project Roadmap](docs/PROJECT_ROADMAP.md) - Development phases
- [Task Tracker](docs/TASK_TRACKER.md) - Current tasks
- [Coding Standards](. github/CODING_STANDARDS.md) - Code guidelines
- [AI Workflow](docs/AI_WORKFLOW.md) - AI automation

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
### Port conflicts?
Edit `.lando.yml` and change ports

[Full troubleshooting guide →](docs/LANDO_SETUP.md#troubleshooting)

---

## 📋 Project Status

**Current Phase:** Phase 1 - MVP Foundation  
**Progress:** 0/13 tasks  
**Next Milestone:** Development environment ready

[View roadmap →](docs/PROJECT_ROADMAP.md)

---

## 👥 Contributing

1. Fork the repository
2. Create feature branch (`git checkout -b feature/amazing`)
3. Commit changes (`git commit -m 'feat: add amazing feature'`)
4. Push to branch (`git push origin feature/amazing`)
5. Open Pull Request

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