import apiConfig from "../../config/api.json";
import { createApiClient } from "./apiClient";

const { wordpressBaseUrl, adsEndpoint } = apiConfig;
const request = createApiClient(wordpressBaseUrl);
const shouldUseLiveApi = process.env.NEXT_PUBLIC_USE_WORDPRESS === "true";

/**
 * Minimal listing view returned by the WordPress ads endpoint.
 */
export type WpAdSummary = {
  id: string;
  title: string;
  price: string;
  location: string;
  categoryId: string;
  excerpt: string;
  createdAt: string;
};

/**
 * Detailed WordPress ad payload used on item pages.
 */
export type WpAdDetail = WpAdSummary & {
  description: string;
  images: string[];
  contactEmail: string;
  contactPhone?: string;
};

/**
 * Fetches ad summaries scoped to a category.
 */
export async function fetchAdsByCategory(categoryId: string, page = 1): Promise<WpAdSummary[]> {
  const url = `${adsEndpoint}?category=${categoryId}&page=${page}`;

  if (shouldUseLiveApi) {
    return request<WpAdSummary[]>(url);
  }

  return buildMockSummaries(categoryId, page);
}

/**
 * Fetches a single ad by identifier.
 */
export async function fetchAdById(adId: string): Promise<WpAdDetail | null> {
  const url = `${adsEndpoint}/${adId}`;

  if (shouldUseLiveApi) {
    return request<WpAdDetail>(url);
  }

  return buildMockDetail(adId);
}

const buildMockSummaries = (categoryId: string, page: number): WpAdSummary[] => {
  return Array.from({ length: 6 }).map((_, idx) => {
    const id = `${categoryId}-${page}-${idx + 1}`;
    return {
      id,
      title: `Sample ${categoryId} offer #${idx + 1}`,
      price: `€${(idx + 1) * 150}`,
      location: ["Bratislava", "Košice", "Žilina"][idx % 3],
      categoryId,
      excerpt: "Placeholder data returned while the WordPress backend is still under development.",
      createdAt: new Date(Date.now() - idx * 86_400_000).toISOString(),
    };
  });
};

const buildMockDetail = (adId: string): WpAdDetail => {
  return {
    id: adId,
    title: `Detailed view for ${adId}`,
    price: "€999",
    location: "Bratislava",
    categoryId: adId.split("-")[0] ?? "general",
    excerpt: "Extended teaser used on list pages.",
    createdAt: new Date().toISOString(),
    description: "Full ad description returned by the upcoming WordPress integration.",
    images: [
      "https://placehold.co/600x400?text=Slovor+Ad",
      "https://placehold.co/600x400?text=Gallery",
    ],
    contactEmail: "contact@example.com",
    contactPhone: "+421 900 000 000",
  };
};
