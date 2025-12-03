import { AdCard } from './AdCard';

type Ad = {
  id: string;
  title: string;
  price: number;
  location: string;
  created_at: string;
  image_url?: string;
};

type AdListProps = {
  ads: Ad[];
  categorySlug: string;
  loading?: boolean;
};

export function AdList({ ads, categorySlug, loading = false }: AdListProps) {
  if (loading) {
    return (
      <div className="grid gap-5 sm:grid-cols-2 lg:grid-cols-3">
        {Array.from({ length: 6 }).map((_, i) => (
          <div key={i} className="overflow-hidden rounded-lg border bg-card">
            <div className="aspect-video bg-muted animate-pulse" />
            <div className="p-4 space-y-3">
              <div className="h-4 bg-muted animate-pulse rounded" />
              <div className="h-6 bg-muted animate-pulse rounded w-1/2" />
              <div className="h-3 bg-muted animate-pulse rounded w-3/4" />
            </div>
          </div>
        ))}
      </div>
    );
  }

  if (ads.length === 0) {
    return (
      <p className="rounded-xl border border-dashed border-slate-300 bg-white/60 p-6 text-center text-sm text-slate-500 dark:border-slate-700 dark:bg-slate-900/60">
        No ads available for this category yet. Check back soon.
      </p>
    );
  }

  return (
    <div className="grid gap-5 sm:grid-cols-2 lg:grid-cols-3">
      {ads.map((ad) => (
        <AdCard key={ad.id} ad={ad} categorySlug={categorySlug} />
      ))}
    </div>
  );
}
