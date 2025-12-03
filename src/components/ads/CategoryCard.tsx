import Link from "next/link";
import type { Category } from "../../types/db";

type Props = {
  category: Category;
};

export function CategoryCard({ category }: Props) {
  return (
    <Link
      href={`/ads/category/${category.slug}`}
      className="group flex flex-col rounded-lg border border-slate-800 bg-slate-900/60 p-4 shadow-sm transition hover:border-brand-500/60 hover:bg-slate-900"
    >
      <div className="mb-2 flex items-center gap-2">
        <div className="flex h-8 w-8 items-center justify-center rounded-full bg-slate-800 text-lg">
          {category.icon ?? "📦"}
        </div>
        <h3 className="text-sm font-semibold text-slate-50">{category.name}</h3>
      </div>
      {category.description && (
        <p className="line-clamp-2 text-xs text-slate-400">{category.description}</p>
      )}
      <span className="mt-3 text-xs text-brand-300 group-hover:text-brand-200">Browse ads →</span>
    </Link>
  );
}
