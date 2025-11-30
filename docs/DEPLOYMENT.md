# Deployment Guide

This document describes how to deploy the Slovor frontend to Vercel and other platforms.

## Vercel Deployment (Recommended)

Vercel is the recommended platform for Next.js applications. It provides:
- Automatic deployments on git push
- Edge functions and middleware support
- Automatic SSL certificates
- Built-in analytics and monitoring
- Serverless functions

### Prerequisites

- GitHub account with the repository
- Vercel account (free tier available)
- Admin access to the repository

### Step 1: Connect Repository to Vercel

1. Go to [vercel.com](https://vercel.com)
2. Click "New Project"
3. Select "Import Git Repository"
4. Choose your GitHub repository
5. Click "Import"

### Step 2: Configure Environment Variables

In Vercel project settings, add the following environment variables:

#### Required

| Variable | Value | Example |
|----------|-------|---------|
| `NEXT_PUBLIC_WP_BASE` | WordPress REST API base URL | `https://slovor.sk/wp-json/wp/v2` |

#### Optional

| Variable | Value | Purpose |
|----------|-------|---------|
| `NEXT_PUBLIC_SENTRY_DSN` | Sentry project DSN | Error tracking in production |
| `NEXT_PUBLIC_USE_WORDPRESS` | `true` or `false` | Use live WordPress API for ads |

### Step 3: Configure Build Settings

Vercel will automatically detect Next.js and use the settings from `vercel.json`:

- **Build Command:** `npm run build`
- **Output Directory:** `.next`
- **Install Command:** `npm ci`
- **Development Command:** `npm run dev`

### Step 4: Deploy

1. Commit and push your changes to the main branch
2. Vercel will automatically detect the push
3. Deployment will start automatically
4. Check deployment status in Vercel dashboard

### Monitoring Deployments

- **Vercel Dashboard:** https://vercel.com/dashboard
- **Deployment logs:** Available in project settings
- **Preview deployments:** Created for each pull request

---

## Environment Variables Setup

### For Development

Create `.env.local` in the project root:

```bash
cp .env.example .env.local
```

Then edit `.env.local`:

```env
NEXT_PUBLIC_WP_BASE=http://slovor.ct.ws/wp-json/wp/v2
NEXT_PUBLIC_USE_WORDPRESS=false
# NEXT_PUBLIC_SENTRY_DSN=your_sentry_dsn
```

### For Production (Vercel)

1. Go to Vercel project settings
2. Navigate to "Environment Variables"
3. Add each variable:
   - Name: `NEXT_PUBLIC_WP_BASE`
   - Value: `https://slovor.sk/wp-json/wp/v2`
   - Environments: Production, Preview, Development

4. (Optional) Add Sentry DSN:
   - Name: `NEXT_PUBLIC_SENTRY_DSN`
   - Value: `https://your-key@sentry.io/your-project-id`
   - Environments: Production

### Vercel Configuration

The `vercel.json` file in the project root contains:

```json
{
  "buildCommand": "npm run build",
  "devCommand": "npm run dev",
  "installCommand": "npm ci",
  "framework": "nextjs",
  "env": [
    {
      "key": "NEXT_PUBLIC_WP_BASE",
      "description": "WordPress REST API base URL",
      "value": "http://slovor.ct.ws/wp-json/wp/v2"
    }
  ]
}
```

---

## Build & Start Locally

### Build for Production

```bash
npm run build
```

This creates an optimized production build in `.next/`.

### Start Production Server

```bash
npm run start
```

Starts the production server on `http://localhost:3000`.

### Test Production Build Locally

```bash
npm run build
npm run start
```

Then open http://localhost:3000 in your browser.

---

## Other Deployment Platforms

### Netlify

1. Connect GitHub repository to Netlify
2. Set build command: `npm run build`
3. Set publish directory: `.next`
4. Add environment variables in Netlify UI
5. Deploy

### Railway

1. Create new project on Railway
2. Connect GitHub repository
3. Add environment variables
4. Railway will auto-detect Next.js and deploy

### Self-Hosted (VPS/Docker)

1. Build the application:
   ```bash
   npm run build
   ```

2. Start the server:
   ```bash
   npm run start
   ```

3. Use a reverse proxy (nginx) to handle traffic
4. Set up SSL with Let's Encrypt
5. Configure environment variables

---

## Monitoring & Debugging

### Vercel Analytics

- **Real User Monitoring:** Track Core Web Vitals
- **Performance:** Monitor page load times
- **Errors:** View error rates and details

Access in Vercel dashboard → Analytics tab.

### Sentry Integration

If `NEXT_PUBLIC_SENTRY_DSN` is set:

1. Go to [sentry.io](https://sentry.io)
2. Select your project
3. View errors in Issues tab
4. Monitor performance in Performance tab

### Logs

- **Vercel Logs:** Available in project settings → Deployments
- **Application Logs:** Check browser console for client-side errors
- **Server Logs:** Available in Vercel function logs

---

## Troubleshooting

### Build Fails

**Error:** `npm ERR! code ERESOLVE`

**Solution:** Use `--legacy-peer-deps` flag:
```bash
npm install --legacy-peer-deps
```

### Environment Variables Not Working

1. Verify variable names are correct (case-sensitive)
2. Ensure `NEXT_PUBLIC_` prefix for client-side variables
3. Redeploy after adding variables
4. Check `.env.example` for required variables

### WordPress API Not Accessible

1. Verify `NEXT_PUBLIC_WP_BASE` URL is correct
2. Check WordPress server is accessible from Vercel
3. Verify CORS headers are configured on WordPress
4. Test URL directly: `curl {NEXT_PUBLIC_WP_BASE}/posts`

### Sentry Not Capturing Errors

1. Verify `NEXT_PUBLIC_SENTRY_DSN` is set
2. Check DSN format is correct
3. Ensure Sentry project is active
4. Check browser console for errors

---

## Deployment Checklist

Before deploying to production:

- [ ] All tests pass: `npm test`
- [ ] Linting passes: `npm run lint`
- [ ] Build succeeds: `npm run build`
- [ ] Environment variables are set in Vercel
- [ ] `NEXT_PUBLIC_WP_BASE` points to production WordPress
- [ ] Sentry DSN is configured (optional)
- [ ] Database backups are current
- [ ] DNS records point to Vercel
- [ ] SSL certificate is active
- [ ] Monitoring is configured

---

## Rollback

### Rollback to Previous Deployment

1. Go to Vercel dashboard
2. Select project
3. Go to Deployments tab
4. Find the previous deployment
5. Click "Promote to Production"

### Rollback Code

If you need to revert code changes:

```bash
git revert <commit-hash>
git push origin main
```

Vercel will automatically deploy the reverted code.

---

## Performance Optimization

### Caching Strategy

- **Static pages:** Cached indefinitely
- **API responses:** Cached for 60 seconds (ISR)
- **Images:** Optimized and cached by Vercel CDN

### Image Optimization

Images are automatically optimized by Next.js:
- WebP format for modern browsers
- AVIF format for latest browsers
- Responsive images for different screen sizes

### Bundle Analysis

Check bundle size:

```bash
npm run build
```

Look for warnings about large chunks.

---

## Resources

- [Vercel Documentation](https://vercel.com/docs)
- [Next.js Deployment](https://nextjs.org/docs/deployment)
- [Vercel Environment Variables](https://vercel.com/docs/concepts/projects/environment-variables)
- [Sentry Integration](https://docs.sentry.io/platforms/javascript/guides/nextjs/)
