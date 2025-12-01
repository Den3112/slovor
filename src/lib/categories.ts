/**
 * Utility types and helpers for working with the classifieds category config.
 */
import categoriesData from "../../config/categories.json";

/**
 * Represents a single subcategory under a parent category.
 */
export type Subcategory = {
  id: string;
  name: string;
};

/**
 * Represents a top-level category along with its subcategories.
 */
export type Category = {
  id: string;
  name: string;
  icon: string;
  subcategories: Subcategory[];
};

const categories = categoriesData as Category[];

/**
 * Loads the static category config for rendering in server components.
 */
export function loadCategories(): Category[] {
  return categories;
}
