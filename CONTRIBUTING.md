# Contributing to Slovor Frontend

Thanks for your interest in contributing! This document outlines the workflow, coding standards, and expectations for contributions to the Slovor Marketplace frontend.

How to contribute
- Fork the repository and create a feature branch: `git checkout -b feature/short-description`
- Keep PRs focused and small — one change per PR when possible
- Write a clear PR description describing what you changed and why

Development workflow
- Pull the latest `main` before starting work: `git fetch && git rebase origin/main`
- Open a draft PR early for design/architecture feedback
- Use descriptive commit messages and squash small WIP commits before merge

Coding standards
- Language: TypeScript only
- Use the App Router `src/app` for pages
- Business logic lives in `src/lib/` and `src/hooks/`
- Components in `src/components/` should be presentational and small
- Comments and JSDoc: English only; export public functions/components must include a short JSDoc comment
- Prefer small, pure functions and avoid side-effects in UI components

Formatting and linting
- Run `npm run lint` and `npm run format` before opening a PR (if scripts are configured)
- Keep Tailwind utility usage consistent; prefer semantic class groupings for layout and typography

Pull request process
- Target branch: `main`
- Include screenshots for visual changes
- Include a short checklist in the PR description: tests (if any), lint, manual QA steps

Issue reporting
- Use the issue templates under `.github/ISSUE_TEMPLATE/` to report bugs and request features

Security
- If you discover a security issue, see `SECURITY.md` and report it privately instead of opening a public issue
