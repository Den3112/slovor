import Link from "next/link";
import { notFound } from "next/navigation";
import Image from "next/image";
import { createSupabaseServiceClient } from "@/lib/supabase/server";

type AdDetailPageProps = {
  params: Promise<{
    categorySlug: string;
    adId: string;
  }>;
};

async function getAdWithCategory(adId: string) {
  try {
    const supabase = createSupabaseServiceClient();
    const { data, error } = await supabase
      .from("ads")
      .select(`
        *,
        categories:category_id (
          id,
          name,
          slug
        )
      `)
      .eq("id", adId)
      .eq("status", "active")
      .single();

    if (error) throw error;
    return data;
  } catch (err) {
    console.warn("Supabase connection failed, using mock data:", err);
    // Mock data for development
    return {
      id: adId,
      title: "Sample Ad - " + adId,
      description: "This is a sample ad description. The full ad details will be loaded when Supabase is connected.",
      price: 100,
      currency: "EUR",
      location: "Bratislava",
      status: "active",
      views_count: 42,
      created_at: new Date().toISOString(),
      categories: {
        id: "sample",
        name: "Sample Category",
        slug: "sample"
      }
    };
  }
}

export default async function AdDetailPage({ params }: AdDetailPageProps) {
  const { categorySlug, adId } = await params;
  const ad = await getAdWithCategory(adId);

  if (!ad) notFound();

  return (
    <div className="space-y-8">
      {/* Header with breadcrumbs */}
      <nav className="text-sm text-muted-foreground">
        <Link href="/" className="hover:text-foreground">Home</Link>
        {" > "}
        <Link href={`/ads/${ad.categories.slug}`} className="hover:text-foreground">
          {ad.categories.name}
        </Link>
        {" > "}
        <span className="text-foreground">{ad.title}</span>
      </nav>

      <div className="grid gap-8 lg:grid-cols-3">
        {/* Main content */}
        <div className="lg:col-span-2 space-y-6">
          {/* Image gallery placeholder */}
          <div className="aspect-video bg-muted rounded-lg flex items-center justify-center">
            <div className="text-center text-muted-foreground">
              <div className="text-6xl mb-2">📷</div>
              <p>Image gallery will be implemented in Phase 4</p>
            </div>
          </div>

          {/* Ad details */}
          <div className="space-y-4">
            <div>
              <h1 className="text-3xl font-bold">{ad.title}</h1>
              <p className="text-xl font-semibold text-primary mt-2">
                €{ad.price.toLocaleString()} {ad.currency}
              </p>
              <p className="text-muted-foreground mt-1">{ad.location}</p>
            </div>

            <div className="border-t pt-4">
              <h2 className="font-semibold mb-2">Description</h2>
              <p className="text-muted-foreground leading-relaxed">{ad.description}</p>
            </div>

            <div className="border-t pt-4">
              <div className="flex items-center gap-4 text-sm text-muted-foreground">
                <span>Posted {new Date(ad.created_at).toLocaleDateString()}</span>
                <span>•</span>
                <span>{ad.views_count} views</span>
              </div>
            </div>
          </div>
        </div>

        {/* Sidebar */}
        <div className="space-y-6">
          {/* Contact seller */}
          <div className="border rounded-lg p-6 bg-card">
            <h3 className="font-semibold mb-4">Contact Seller</h3>
            <div className="space-y-3">
              <button className="w-full bg-primary text-primary-foreground hover:bg-primary/90 px-4 py-2 rounded">
                Show Phone Number
              </button>
              <button className="w-full border hover:bg-accent px-4 py-2 rounded">
                Send Message
              </button>
            </div>
          </div>

          {/* Share */}
          <div className="border rounded-lg p-6 bg-card">
            <h3 className="font-semibold mb-4">Share</h3>
            <div className="flex gap-2">
              <button className="flex-1 border hover:bg-accent px-3 py-2 rounded text-sm">
                Copy Link
              </button>
              <button className="flex-1 border hover:bg-accent px-3 py-2 rounded text-sm">
                WhatsApp
              </button>
            </div>
          </div>

          {/* Seller info placeholder */}
          <div className="border rounded-lg p-6 bg-card">
            <h3 className="font-semibold mb-4">Seller</h3>
            <div className="flex items-center gap-3">
              <div className="w-10 h-10 bg-muted rounded-full flex items-center justify-center">
                👤
              </div>
              <div>
                <p className="font-medium">Seller Name</p>
                <p className="text-sm text-muted-foreground">Member since 2024</p>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}
