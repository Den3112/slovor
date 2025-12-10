-- Enable UUID extension
create extension if not exists "uuid-ossp";

-- Create categories table
create table if not exists public.categories (
  id uuid primary key default uuid_generate_v4(),
  name text not null,
  slug text not null unique,
  description text,
  icon text,
  parent_id uuid references public.categories(id) on delete cascade,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

-- Create profiles table (extends auth.users)
create table if not exists public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  email text not null unique,
  full_name text,
  avatar_url text,
  phone text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

-- Create listings table
create table if not exists public.listings (
  id uuid primary key default uuid_generate_v4(),
  title text not null,
  description text not null,
  price numeric(10,2) not null check (price >= 0),
  category_id uuid not null references public.categories(id) on delete restrict,
  user_id uuid not null references public.profiles(id) on delete cascade,
  status text not null default 'draft' check (status in ('draft', 'active', 'sold', 'archived')),
  images text[] default array[]::text[],
  location text not null,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

-- Create indexes
create index if not exists idx_categories_slug on public.categories(slug);
create index if not exists idx_categories_parent on public.categories(parent_id);
create index if not exists idx_listings_category on public.listings(category_id);
create index if not exists idx_listings_user on public.listings(user_id);
create index if not exists idx_listings_status on public.listings(status);
create index if not exists idx_listings_created on public.listings(created_at desc);

-- Enable Row Level Security
alter table public.categories enable row level security;
alter table public.profiles enable row level security;
alter table public.listings enable row level security;

-- RLS Policies for categories (public read)
create policy "Categories are viewable by everyone"
  on public.categories for select
  using (true);

-- RLS Policies for profiles
create policy "Profiles are viewable by everyone"
  on public.profiles for select
  using (true);

create policy "Users can update own profile"
  on public.profiles for update
  using (auth.uid() = id);

-- RLS Policies for listings
create policy "Active listings are viewable by everyone"
  on public.listings for select
  using (status = 'active' or auth.uid() = user_id);

create policy "Users can create own listings"
  on public.listings for insert
  with check (auth.uid() = user_id);

create policy "Users can update own listings"
  on public.listings for update
  using (auth.uid() = user_id);

create policy "Users can delete own listings"
  on public.listings for delete
  using (auth.uid() = user_id);

-- Create function to auto-update updated_at
create or replace function public.handle_updated_at()
returns trigger as $$
begin
  new.updated_at = now();
  return new;
end;
$$ language plpgsql;

-- Create triggers for updated_at
create trigger set_updated_at
  before update on public.categories
  for each row
  execute function public.handle_updated_at();

create trigger set_updated_at
  before update on public.profiles
  for each row
  execute function public.handle_updated_at();

create trigger set_updated_at
  before update on public.listings
  for each row
  execute function public.handle_updated_at();

-- Insert sample categories
insert into public.categories (name, slug, description, icon) values
  ('Electronics', 'electronics', 'Phones, computers, and gadgets', '📱'),
  ('Vehicles', 'vehicles', 'Cars, motorcycles, and bikes', '🚗'),
  ('Real Estate', 'real-estate', 'Apartments and houses', '🏠'),
  ('Jobs', 'jobs', 'Job listings', '💼'),
  ('Services', 'services', 'Professional services', '🔧')
on conflict (slug) do nothing;
