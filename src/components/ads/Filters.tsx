'use client';

import { useState } from 'react';

type FiltersProps = {
  onFiltersChange: (filters: { minPrice?: number; maxPrice?: number; sortBy: string }) => void;
};

export function Filters({ onFiltersChange }: FiltersProps) {
  const [minPrice, setMinPrice] = useState<string>('');
  const [maxPrice, setMaxPrice] = useState<string>('');
  const [sortBy, setSortBy] = useState<string>('newest');

  const handleFilterChange = () => {
    const filters = {
      minPrice: minPrice ? parseInt(minPrice) : undefined,
      maxPrice: maxPrice ? parseInt(maxPrice) : undefined,
      sortBy,
    };
    onFiltersChange(filters);
  };

  const handleSortChange = (newSortBy: string) => {
    setSortBy(newSortBy);
    const filters = {
      minPrice: minPrice ? parseInt(minPrice) : undefined,
      maxPrice: maxPrice ? parseInt(maxPrice) : undefined,
      sortBy: newSortBy,
    };
    onFiltersChange(filters);
  };

  return (
    <div className="space-y-4 p-4 border rounded-lg bg-card">
      <h3 className="font-semibold">Filters</h3>

      {/* Price Range */}
      <div className="space-y-2">
        <label className="text-sm font-medium">Price Range</label>
        <div className="flex gap-2">
          <input
            type="number"
            placeholder="Min €"
            value={minPrice}
            onChange={(e) => {
              setMinPrice(e.target.value);
              setTimeout(handleFilterChange, 300);
            }}
            className="flex-1 px-3 py-1 text-sm border rounded"
          />
          <input
            type="number"
            placeholder="Max €"
            value={maxPrice}
            onChange={(e) => {
              setMaxPrice(e.target.value);
              setTimeout(handleFilterChange, 300);
            }}
            className="flex-1 px-3 py-1 text-sm border rounded"
          />
        </div>
      </div>

      {/* Sort By */}
      <div className="space-y-2">
        <label className="text-sm font-medium">Sort By</label>
        <select
          value={sortBy}
          onChange={(e) => handleSortChange(e.target.value)}
          className="w-full px-3 py-1 text-sm border rounded"
        >
          <option value="newest">Newest First</option>
          <option value="oldest">Oldest First</option>
          <option value="price-low">Price: Low to High</option>
          <option value="price-high">Price: High to Low</option>
        </select>
      </div>

      {/* Clear Filters */}
      <button
        onClick={() => {
          setMinPrice('');
          setMaxPrice('');
          setSortBy('newest');
          onFiltersChange({ sortBy: 'newest' });
        }}
        className="w-full px-3 py-2 text-sm bg-secondary hover:bg-secondary/80 rounded"
      >
        Clear Filters
      </button>
    </div>
  );
}
