import Link from 'next/link';
import Image from 'next/image';

type AdCardProps = {
  ad: { id: string; title: string; price: number; location: string; created_at: string; image_url?: string };
  categorySlug: string;
};

export function AdCard({ ad, categorySlug }: AdCardProps) {
  return (
    <Link href={`/ads/${categorySlug}/${ad.id}`} className="group block">
      <div className="overflow-hidden rounded-lg border bg-card hover:shadow-lg transition">
        <div className="aspect-video relative bg-muted">
          {ad.image_url ? (
            <Image src={ad.image_url} alt={ad.title} fill className="object-cover" />
          ) : (
            <div className="flex items-center justify-center h-full text-muted-foreground">No image</div>
          )}
        </div>
        <div className="p-4">
          <h3 className="font-semibold truncate group-hover:text-primary">{ad.title}</h3>
          <p className="text-2xl font-bold mt-2">€{ad.price.toLocaleString()}</p>
          <p className="text-sm text-muted-foreground mt-1">{ad.location}</p>
        </div>
      </div>
    </Link>
  );
}
