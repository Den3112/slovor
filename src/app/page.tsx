import { createSupabaseServiceClient } from "../lib/supabase/server";
import { CategoryGrid } from "../components/ads/CategoryGrid";

async function getCategories() {
  try {
    const supabase = createSupabaseServiceClient();
    const { data, error } = await supabase
      .from("categories")
      .select("*")
      .order("name", { ascending: true });
    if (error) throw error;
    return data ?? [];
  } catch (err) {
    console.warn("Supabase connection failed, using mock data:", err);
    return [
      {
        id: "1",
        name: "Electronics",
        slug: "electronics",
        icon: "💻",
        description: "Phones, laptops, gadgets",
        parent_id: null,
        created_at: new Date().toISOString(),
      },
      {
        id: "2",
        name: "Vehicles",
        slug: "vehicles",
        icon: "🚗",
        description: "Cars, motorcycles, bikes",
        parent_id: null,
        created_at: new Date().toISOString(),
      },
      {
        id: "3",
        name: "Real Estate",
        slug: "real-estate",
        icon: "🏠",
        description: "Apartments, houses, land",
        parent_id: null,
        created_at: new Date().toISOString(),
      },
    ];
  }
}

export default async function HomePage() {
  const categories = await getCategories();

  return (
    <div className="space-y-8">
      <section className="space-y-3">
        <h1 className="text-2xl font-semibold text-slate-50">
          Slovor – simple classifieds for Slovakia
        </h1>
        <p className="max-w-2xl text-sm text-slate-400">
          Browse categories and post your own ads. This is an MVP focused on speed and simplicity,
          built on top of Supabase and Next.js.
        </p>
      </section>
      <section className="space-y-4">
        <h2 className="text-sm font-semibold uppercase tracking-wide text-slate-400">Categories</h2>
        <CategoryGrid categories={categories} />
      </section>
    </div>
  );
}
