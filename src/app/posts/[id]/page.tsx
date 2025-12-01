import Link from "next/link";
import { fetchPost } from "@/lib/wordpress/client";
import { sanitizeHtmlContent } from "@/lib/html";

type Params = { params: { id: string } };

/**
 * Post detail page for a single WordPress post.
 * Fetches post data on the server using the WordPress client and
 * renders the full title, content, and publication date.
 */
export default async function PostPage({ params }: Params) {
  const { id } = await params;
  const post = await fetchPost(id);

  if (!post) {
    return (
      <div className="max-w-6xl mx-auto px-4 py-12">
        <div className="text-center text-slate-400">Post not found.</div>
        <div className="mt-6 text-center">
          <Link
            href="/"
            className="inline-flex items-center rounded-md border border-slate-700 bg-slate-800 px-4 py-2 text-sm font-medium text-slate-200 hover:bg-slate-700"
          >
            ← Back to home
          </Link>
        </div>
      </div>
    );
  }

  const published = new Date(post.date).toLocaleString(undefined, {
    year: "numeric",
    month: "long",
    day: "numeric",
    hour: "2-digit",
    minute: "2-digit",
  });

  return (
    <article className="max-w-6xl mx-auto px-4 py-12">
      <div className="mb-6">
        <Link href="/" className="text-sm text-slate-400 hover:text-slate-200">
          ← Back to home
        </Link>
      </div>

      <header className="mb-8">
        <h1
          className="text-4xl md:text-5xl font-extrabold text-white leading-tight"
          dangerouslySetInnerHTML={{ __html: sanitizeHtmlContent(post.title.rendered) }}
        />

        <div className="mt-3 text-sm text-slate-400">{published}</div>
      </header>

      <section className="prose prose-invert max-w-none text-slate-100 leading-relaxed">
        <div dangerouslySetInnerHTML={{ __html: sanitizeHtmlContent(post.content.rendered) }} />
      </section>
    </article>
  );
}
