/**
 * Tests for categories utility functions
 */

import { loadCategories, type Category, type Subcategory } from "../categories";

describe("Categories", () => {
  describe("loadCategories", () => {
    it("should return an array of categories", () => {
      const categories = loadCategories();

      expect(Array.isArray(categories)).toBe(true);
      expect(categories.length).toBeGreaterThan(0);
    });

    it("should return categories with correct structure", () => {
      const categories = loadCategories();

      categories.forEach((category: Category) => {
        expect(typeof category.id).toBe("string");
        expect(category.id).toBeTruthy();

        expect(typeof category.name).toBe("string");
        expect(category.name).toBeTruthy();

        expect(typeof category.icon).toBe("string");
        expect(category.icon).toBeTruthy();

        expect(Array.isArray(category.subcategories)).toBe(true);

        category.subcategories.forEach((subcategory: Subcategory) => {
          expect(typeof subcategory.id).toBe("string");
          expect(subcategory.id).toBeTruthy();

          expect(typeof subcategory.name).toBe("string");
          expect(subcategory.name).toBeTruthy();
        });
      });
    });

    it("should return the same result on multiple calls", () => {
      const categories1 = loadCategories();
      const categories2 = loadCategories();

      expect(categories1).toEqual(categories2);
      expect(categories1).toBe(categories2); // Same reference
    });

    it("should contain expected category structure", () => {
      const categories = loadCategories();

      // Check that we have at least one category with subcategories
      const categoryWithSubcategories = categories.find((cat) => cat.subcategories.length > 0);
      expect(categoryWithSubcategories).toBeDefined();

      if (categoryWithSubcategories) {
        expect(categoryWithSubcategories.subcategories.length).toBeGreaterThan(0);
        expect(typeof categoryWithSubcategories.subcategories[0].id).toBe("string");
        expect(typeof categoryWithSubcategories.subcategories[0].name).toBe("string");
      }
    });
  });

  describe("Type definitions", () => {
    it("should export Category and Subcategory types", () => {
      // This test ensures the types are properly exported
      const categories: Category[] = loadCategories();

      categories.forEach((category: Category) => {
        const subcategory: Subcategory = category.subcategories[0];

        // TypeScript will catch any type mismatches here
        expect(category.id).toBeDefined();
        expect(subcategory?.id).toBeDefined();
      });
    });
  });
});
