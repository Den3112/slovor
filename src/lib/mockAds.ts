import { loadCategories, type Category } from "./categories";

/**
 * Represents a single mock advertisement shown on category pages.
 */
export type Ad = {
  id: string;
  title: string;
  price: string;
  location: string;
  description: string;
  categoryId: Category["id"];
};

type Template = {
  title: (category: Category) => string;
  price: string;
  location: string;
  description: (category: Category) => string;
};

const templates: Template[] = [
  {
    title: (category) => `Top ${category.name} pick`,
    price: "Price on request",
    location: "Bratislava",
    description: (category) =>
      `Featured ${category.name.toLowerCase()} listing from verified sellers.`,
  },
  {
    title: (category) => `${category.name} highlight deal`,
    price: "€450",
    location: "Košice",
    description: () => "Lightly used, includes all original accessories.",
  },
  {
    title: (category) => `${category.name} essentials`,
    price: "€120",
    location: "Žilina",
    description: () => "Ready for immediate pickup or courier delivery.",
  },
  {
    title: (category) => `${category.name} premium option`,
    price: "€1,250",
    location: "Trnava",
    description: () => "Fully maintained, detailed documentation available.",
  },
  {
    title: (category) => `${category.name} budget find`,
    price: "€75",
    location: "Nitra",
    description: () => "Great value for money, carefully looked after.",
  },
  {
    title: (category) => `${category.name} weekend special`,
    price: "€320",
    location: "Banská Bystrica",
    description: () => "Available this weekend with flexible pick-up times.",
  },
  {
    title: (category) => `${category.name} limited offer`,
    price: "€980",
    location: "Prešov",
    description: () => "Limited availability—contact now to reserve.",
  },
  {
    title: (category) => `${category.name} local favorite`,
    price: "€210",
    location: "Trenčín",
    description: () => "Highly rated by previous buyers in the region.",
  },
];

// Generate category-specific ads from shared templates to keep UI consistent.
const catalog: Record<Category["id"], Ad[]> = loadCategories().reduce(
  (acc, category) => {
    acc[category.id] = templates.map((template, index) => ({
      id: `${category.id}-${index + 1}`,
      title: template.title(category),
      price: template.price,
      location: template.location,
      description: template.description(category),
      categoryId: category.id,
    }));
    return acc;
  },
  {} as Record<Category["id"], Ad[]>,
);

/**
 * Returns placeholder ads for the specified category id.
 */
export function getMockAdsByCategory(categoryId: string): Ad[] {
  return catalog[categoryId as Category["id"]] ?? [];
}

