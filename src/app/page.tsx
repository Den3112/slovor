import Link from "next/link";
import { fetchPosts } from "@/lib/wordpress/client";
import { stripHtmlTags, sanitizeHtmlContent } from "@/lib/html";

/**
 * Landing page for Slovor showcasing the top marketplace categories.
 * Now renders recent posts fetched from the WordPress site.
 */
export default async function HomePage() {
  const posts = await fetchPosts();

  return (
    <section className="space-y-8">
      <div className="space-y-2">
        <p className="text-sm font-semibold uppercase tracking-wide text-brand">
          Browse by category
        </p>
        <h1 className="text-3xl font-bold text-slate-900 dark:text-slate-100">
          Find what you need across Slovakia
        </h1>
        <p className="max-w-2xl text-base text-slate-600 dark:text-slate-300">
          Discover vehicles, homes, jobs, services, and more—all in one place.
        </p>
      </div>

      <div className="grid gap-6 sm:grid-cols-2 xl:grid-cols-4">
        {posts.length > 0 ? (
          posts.map((post) => (
            <article
              key={post.id}
              className="group flex h-full flex-col rounded-2xl border border-slate-200 bg-white/5 p-5 shadow-sm transition hover:-translate-y-1 hover:border-brand hover:shadow-lg dark:border-slate-800 dark:bg-slate-900/80"
            >
              <div className="flex items-start justify-between gap-3">
                <div className="flex-1">
                  <h2
                    className="text-xl font-semibold text-slate-100 mb-2"
                    // Title is sanitized to prevent XSS attacks
                    dangerouslySetInnerHTML={{ __html: sanitizeHtmlContent(post.title.rendered) }}
                  />

                  <p className="text-sm text-slate-400 leading-relaxed max-h-20 overflow-hidden">
                    {stripHtmlTags(post.excerpt.rendered)}
                  </p>
                </div>
              </div>

              <div className="mt-auto pt-4">
                <Link
                  href={`/posts/${post.id}`}
                  className="inline-flex w-full items-center justify-center rounded-xl border border-brand bg-brand/10 px-4 py-2 text-sm font-medium text-brand transition hover:bg-brand hover:text-white"
                >
                  Read post
                </Link>
              </div>
            </article>
          ))
        ) : (
          <div className="text-slate-400">No posts found.</div>
        )}
      </div>
    </section>
  );
}
