# Monitoring & Error Tracking

This document describes how to set up and use error tracking and performance monitoring for the Slovor frontend.

## Sentry Integration

Sentry is used for error tracking, performance monitoring, and session replay in production.

### Setup

1. **Create a Sentry account** at [sentry.io](https://sentry.io)

2. **Create a new project** for Next.js

3. **Get your DSN** from project settings

4. **Set environment variable** in `.env.local` or Vercel project settings:
   ```env
   NEXT_PUBLIC_SENTRY_DSN=https://your-key@sentry.io/your-project-id
   ```

### Configuration

Sentry is configured in:

- `sentry.client.config.ts` — Client-side configuration
- `sentry.server.config.ts` — Server-side configuration

### Features

- **Error Tracking:** Automatically captures unhandled errors
- **Performance Monitoring:** Tracks page load times and API calls
- **Session Replay:** Records user sessions for debugging (10% sample rate)
- **Source Maps:** Uploaded automatically for better stack traces

### Usage

Errors are captured automatically. To manually capture an error:

```typescript
import * as Sentry from "@sentry/nextjs";

try {
  // Your code
} catch (error) {
  Sentry.captureException(error);
}
```

### Viewing Errors

1. Go to [sentry.io](https://sentry.io)
2. Select your project
3. View errors in the Issues tab
4. Click on an error to see details, stack trace, and session replay

## Performance Monitoring

Sentry automatically monitors:

- Page load times
- API response times
- Database queries
- Custom transactions

### Setting Trace Sample Rate

In `sentry.client.config.ts` and `sentry.server.config.ts`:

```typescript
tracesSampleRate: 1.0, // 100% - for development
// For production, use lower rate (e.g., 0.1 for 10%)
```

## Environment Variables

| Variable                 | Description                          | Required      |
| ------------------------ | ------------------------------------ | ------------- |
| `NEXT_PUBLIC_SENTRY_DSN` | Sentry project DSN                   | No (optional) |
| `NODE_ENV`               | Environment (development/production) | Yes           |

## Disabling Sentry

To disable Sentry, simply don't set `NEXT_PUBLIC_SENTRY_DSN`. The app will work normally without error tracking.

## Best Practices

1. **Use meaningful error messages:**

   ```typescript
   throw new Error("Failed to fetch posts from WordPress API");
   ```

2. **Add context to errors:**

   ```typescript
   Sentry.captureException(error, {
     tags: {
       section: "posts",
       action: "fetch",
     },
   });
   ```

3. **Monitor critical paths:**

   ```typescript
   const transaction = Sentry.startTransaction({
     name: "fetch-posts",
     op: "http.client",
   });

   // Your code

   transaction.finish();
   ```

4. **Set appropriate sample rates:**
   - Development: 100% (`tracesSampleRate: 1.0`)
   - Production: 10-20% (`tracesSampleRate: 0.1`)

## Troubleshooting

### Errors not appearing in Sentry

1. Check that `NEXT_PUBLIC_SENTRY_DSN` is set
2. Verify DSN is correct
3. Check browser console for errors
4. Ensure Sentry is initialized before errors occur

### Too many errors

1. Lower `tracesSampleRate` in production
2. Filter out known errors in Sentry project settings
3. Use error grouping to consolidate similar errors

### Performance issues

1. Reduce `replaysSessionSampleRate` (default: 0.1)
2. Disable session replay: set `replaysSessionSampleRate: 0`
3. Monitor Sentry quota in project settings

## Resources

- [Sentry Documentation](https://docs.sentry.io/)
- [Sentry for Next.js](https://docs.sentry.io/platforms/javascript/guides/nextjs/)
- [Performance Monitoring](https://docs.sentry.io/platforms/javascript/performance/)
- [Session Replay](https://docs.sentry.io/platforms/javascript/session-replay/)
