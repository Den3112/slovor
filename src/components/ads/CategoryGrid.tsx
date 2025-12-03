import type { Category } from "../../types/db";
import { CategoryCard } from "./CategoryCard";

type Props = {
  categories: Category[];
};

export function CategoryGrid({ categories }: Props) {
  if (!categories.length) {
    return <p className="text-sm text-slate-400">No categories found. Please check back later.</p>;
  }

  return (
    <div className="grid gap-4 sm:grid-cols-2 lg:grid-cols-3">
      {categories.map((category) => (
        <CategoryCard key={category.id} category={category} />
      ))}
    </div>
  );
}
