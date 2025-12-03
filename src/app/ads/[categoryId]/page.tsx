import Link from "next/link";
import { notFound } from "next/navigation";
import { loadCategories } from "@/lib/categories";
import { getMockAdsByCategory, type Ad } from "@/lib/mockAds";

type AdsPageProps = {
  params: Promise<{
    categoryId: string;
  }>;
};

/**
 * Server-rendered listing page that shows mock ads for a given category slug.
 */
export default async function CategoryAdsPage({ params }: AdsPageProps) {
  const { categoryId } = await params;
  const categories = loadCategories();
  const category = categories.find((item) => item.id === categoryId) ?? notFound();

  // Using mock data for now - WordPress integration pending
  const ads = getMockAdsByCategory(category.id);

  // Summarize a few subcategories to add context to the header copy.
  const subcategorySummary = category.subcategories
    .slice(0, 3)
    .map((sub) => sub.name)
    .join(", ");

  return (
    <section className="space-y-8">
      <header className="space-y-3 rounded-2xl border border-slate-200 bg-white/80 p-6 shadow-sm dark:border-slate-800 dark:bg-slate-900/80">
        <p className="text-sm font-semibold uppercase tracking-wide text-brand">{category.name}</p>
        <h1 className="text-3xl font-bold text-slate-900 dark:text-slate-100">
          Featured ads in {category.name}
        </h1>
        <p className="text-base text-slate-600 dark:text-slate-300">
          Explore curated offers including {subcategorySummary} and more, all posted by the Slovor
          community.
        </p>
        <Link
          href="/"
          className="inline-flex items-center text-sm font-semibold text-brand transition hover:text-brand-light"
        >
          ← Back to categories
        </Link>
      </header>

      {ads.length === 0 ? (
        <p className="rounded-xl border border-dashed border-slate-300 bg-white/60 p-6 text-center text-sm text-slate-500 dark:border-slate-700 dark:bg-slate-900/60">
          No ads available for this category yet. Check back soon.
        </p>
      ) : (
        <div className="grid gap-5 sm:grid-cols-2 lg:grid-cols-3">
          {ads.map((ad: Ad) => (
            <article
              key={ad.id}
              className="flex h-full flex-col rounded-2xl border border-slate-200 bg-white p-5 shadow-sm transition hover:-translate-y-1 hover:border-brand hover:shadow-lg dark:border-slate-800 dark:bg-slate-900"
            >
              <div className="space-y-1">
                <h2 className="text-lg font-semibold text-slate-900 dark:text-slate-100">
                  {ad.title}
                </h2>
                <p className="text-sm text-slate-500 dark:text-slate-400">{ad.location}</p>
                <p className="text-xl font-bold text-brand">{ad.price}</p>
              </div>

              <p className="mt-3 flex-1 text-sm text-slate-600 dark:text-slate-300">
                {ad.description}
              </p>

              <button
                type="button"
                className="mt-5 inline-flex items-center justify-center rounded-xl border border-brand bg-brand/10 px-3 py-2 text-sm font-semibold text-brand transition hover:bg-brand hover:text-white focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-brand focus-visible:ring-offset-2 dark:bg-brand/20 dark:text-brand-light dark:hover:text-white"
              >
                Contact seller
              </button>
            </article>
          ))}
        </div>
      )}
    </section>
  );
}
