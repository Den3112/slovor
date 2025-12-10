# Slovor Project - Easy Commands
# Usage: make <command>

.PHONY: help setup install check lint typecheck build dev start ssh clean deploy

# Default command - show help
help:
	@echo "Slovor Project Commands:"
	@echo ""
	@echo "  make setup     - Initial project setup (git pull + install deps)"
	@echo "  make dev       - Start development server"
	@echo "  make check     - Run all quality checks (typecheck + lint + build)"
	@echo "  make build     - Build for production"
	@echo "  make lint      - Run ESLint"
	@echo "  make typecheck - Check TypeScript"
	@echo "  make ssh       - SSH into Lando container"
	@echo "  make clean     - Remove node_modules"
	@echo "  make deploy    - Check + push to GitHub"
	@echo ""

# Initial setup
setup:
	@echo "==> Setting up Slovor project..."
	lando ssh -c "cd slovor && git pull origin main && npm install --no-optional --legacy-peer-deps"
	@echo "==> Setup complete!"

# Install dependencies
install:
	@echo "==> Installing dependencies..."
	lando ssh -c "cd slovor && npm install --no-optional --legacy-peer-deps"

# Quality checks
check:
	@echo "==> Running quality checks..."
	lando ssh -c "cd slovor && npm run check"

lint:
	@echo "==> Running ESLint..."
	lando ssh -c "cd slovor && npm run lint"

typecheck:
	@echo "==> Checking TypeScript..."
	lando ssh -c "cd slovor && npm run typecheck"

build:
	@echo "==> Building for production..."
	lando ssh -c "cd slovor && npm run build"

# Development
dev:
	@echo "==> Starting development server..."
	@echo "==> Open http://slovor.lndo.site in your browser"
	lando ssh -c "cd slovor && npm run dev"

start:
	@echo "==> Starting production server..."
	lando ssh -c "cd slovor && npm run start"

# Utilities
ssh:
	@echo "==> Opening Lando SSH..."
	lando ssh

clean:
	@echo "==> Cleaning node_modules..."
	lando ssh -c "cd slovor && rm -rf node_modules package-lock.json"

deploy:
	@echo "==> Deploying to GitHub..."
	lando ssh -c "cd slovor && npm run deploy"
