# Slovor Project Roadmap

**Project:** Slovor Marketplace for Slovakia  
**Status:** Phase 1 - Ready to Start  
**Last Updated:** 2025-12-08  

---

## Overview

Classifieds marketplace (like Avito/OLX) built with Next.js 15, TypeScript, Supabase, deployed on Vercel.

**Tech Stack:**
- Frontend: Next.js 15, React 19, TypeScript 5, Tailwind CSS 4
- Backend: Supabase (PostgreSQL, Auth, Storage)
- Deployment: Vercel
- Tools: ESLint, Prettier, Jest, Sentry, Husky

---

## Project Phases

### Phase 1: MVP Foundation (Infrastructure) 📋 READY TO START
**Goal:** Set up complete development environment and base infrastructure  
**Duration:** 1-2 days  
**Status:** 0/13 tasks completed

**Deliverables:**
- ✅ Dev Container configuration (Docker)
- ✅ Database schema with migrations
- ✅ Supabase clients (browser/server)
- ✅ TypeScript strict configuration
- ✅ ESLint + Prettier setup
- ✅ Basic Next.js app structure
- ✅ Environment variables configured
- ✅ Git hooks (Husky + commitlint)
- ✅ Testing setup (Jest)
- ✅ Deployment pipeline (Vercel)

**Success Criteria:**
- `npm run dev` works without errors
- Database migrations applied successfully
- Dev Container starts in Windsurf
- All linting/formatting passes
- Project builds for production

---

### Phase 2: Browsing & Discovery (Public Pages) 📋 PLANNED
**Goal:** Users can browse ads by categories with filters  
**Duration:** 3-4 days  
**Dependencies:** Phase 1 complete

**Deliverables:**
- Homepage with category grid
- Category listing page (`/ads/[categorySlug]`)
- Ad detail page (`/ads/[categorySlug]/[adId]`)
- Filters (price range, sorting)
- Image gallery component
- Breadcrumbs navigation
- SEO optimization (meta tags, Open Graph)
- Seed script for test data

**Success Criteria:**
- Category pages load via SSR
- Filters work without page reload
- SEO score 95+ (Lighthouse)
- Responsive design (mobile/tablet/desktop)
- Views counter increments on ad view

---

### Phase 3: User Authentication 📋 PLANNED
**Goal:** Users can register, login, and manage profiles  
**Duration:** 2-3 days  
**Dependencies:** Phase 2 complete

**Deliverables:**
- Registration form with validation
- Login form
- Email verification flow
- Password reset flow
- User profile page
- Protected routes middleware
- OAuth (Google/Facebook) - optional
- Session management

**Success Criteria:**
- Users can register and login
- Email verification sent
- Protected routes redirect to login
- Session persists across refreshes

---

### Phase 4: Ad Creation & Management 📋 PLANNED
**Goal:** Authenticated users can create and manage their ads  
**Duration:** 3-4 days  
**Dependencies:** Phase 3 complete

**Deliverables:**
- Create ad form with validation
- Image upload (max 5, Supabase Storage)
- Edit ad functionality
- Delete ad functionality
- My Ads page (user's listing)
- Draft/Pending/Active status management
- View statistics for own ads

**Success Criteria:**
- Users can create ads with images
- Validation works (client + server)
- Images upload to Supabase Storage
- Users can edit/delete own ads
- Status transitions work correctly

---

### Phase 5: Advanced Features 📋 PLANNED
**Goal:** Add favorites, messaging, search, and admin panel  
**Duration:** 5-7 days  
**Dependencies:** Phase 4 complete

**Deliverables:**
- Favorites system (add/remove)
- Favorites page
- Messaging system (real-time chat)
- Inbox and conversation view
- Full-text search
- Search results page
- Featured ads (paid promotion)
- Admin panel for moderation
- Email notifications

**Success Criteria:**
- Favorites sync across devices
- Messages delivered in real-time
- Search returns relevant results
- Admin can approve/reject ads

---

## Timeline

| Phase | Duration | Start Date | End Date | Status |
|-------|----------|------------|----------|--------|
| Phase 1 | 1-2 days | TBD | TBD | 📋 Ready |
| Phase 2 | 3-4 days | TBD | TBD | 📋 Planned |
| Phase 3 | 2-3 days | TBD | TBD | 📋 Planned |
| Phase 4 | 3-4 days | TBD | TBD | 📋 Planned |
| Phase 5 | 5-7 days | TBD | TBD | 📋 Planned |

**Total Estimated:** 14-20 days

---

## Key Milestones

- [ ] **M1:** Development environment ready (Phase 1)
- [ ] **M2:** MVP browsing functional (Phase 2)
- [ ] **M3:** User authentication working (Phase 3)
- [ ] **M4:** Users can post ads (Phase 4)
- [ ] **M5:** Full marketplace features (Phase 5)
- [ ] **M6:** Production launch

---

## Risk Management

### High Priority Risks
1. **Supabase RLS complexity** - Mitigation: Test policies thoroughly
2. **Image upload performance** - Mitigation: Optimize with compression
3. **Real-time messaging scalability** - Mitigation: Use Supabase Realtime limits

### Medium Priority Risks
1. **SEO optimization** - Mitigation: Follow Next.js SSR best practices
2. **Mobile responsiveness** - Mitigation: Test on multiple devices
3. **Security vulnerabilities** - Mitigation: Regular dependency updates

---

## Success Metrics

### Technical Metrics
- Lighthouse Performance > 90
- Zero critical security vulnerabilities
- Test coverage > 80%
- Build time < 2 minutes

### Business Metrics
- Page load time < 2 seconds
- Zero downtime deployments
- Error rate < 0.1%

---

## Resources

- **Repository:** https://github.com/Den3112/slovor
- **Supabase Dashboard:** https://rsywmmnxkvwvhgrgzlei.supabase.co
- **Vercel Dashboard:** https://vercel.com/den3112/slovor
- **Sentry Dashboard:** [Add link when configured]

---

## Team & Roles

- **Developer:** DeNiS (Den3112)
- **AI Assistant:** Grok (via Killo Code in Windsurf)
- **Design:** TBD
- **QA:** Manual testing + automated tests

---

## Notes

- All code must be in American English (comments, docs, commits)
- User-facing text in Slovak/Russian (translations TBD)
- Follow conventional commits format
- One PR per task with review before merge
