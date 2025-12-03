export interface Category {
  id: string;
  name: string;
  slug: string;
  icon?: string;
  description?: string;
  parent_id?: string | null;
  created_at: string;
}
