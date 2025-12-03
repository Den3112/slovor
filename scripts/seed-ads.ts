import { createClient } from '@supabase/supabase-js';

// Hardcoded credentials for seeding (same as apply-schema.js)
const supabaseUrl = 'https://uwwwpecychokixajrmpbi.supabase.co';
const serviceRoleKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InV3d3BlY3ljaG9raXhhanJtcGJpIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc2NDY4MDg2MCwiZXhwIjoyMDgwMjU2ODYwfQ.GFj-Z4rFmoDvYrq1hFK7169ihqKx8Cl2cBDebqcvcRE';

const supabase = createClient(supabaseUrl, serviceRoleKey);

const testAds = [
  // Electronics
  {
    category_id: 'electronics',
    user_id: '00000000-0000-0000-0000-000000000000', // Placeholder user ID
    title: 'iPhone 13 Pro - Excellent Condition',
    description: 'Selling my iPhone 13 Pro with 256GB storage. Comes with original box, charger, and screen protector. Battery health is 92%. No scratches or dents.',
    price: 650,
    currency: 'EUR',
    location: 'Bratislava',
    status: 'active',
    views_count: 45,
    image_url: 'https://images.unsplash.com/photo-1592750475338-74b7b21085ab?w=400&h=300&fit=crop'
  },
  {
    category_id: 'electronics',
    user_id: '00000000-0000-0000-0000-000000000000',
    title: 'MacBook Air M1 - Like New',
    description: '13-inch MacBook Air with M1 chip, 8GB RAM, 256GB SSD. Perfect for students and professionals. Includes original charger and box.',
    price: 850,
    currency: 'EUR',
    location: 'Košice',
    status: 'active',
    views_count: 78,
    image_url: 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=400&h=300&fit=crop'
  },

  // Vehicles
  {
    category_id: 'vehicles',
    user_id: '00000000-0000-0000-0000-000000000000',
    title: 'BMW 320d 2018 - Low Mileage',
    description: 'BMW 320d Touring with only 95,000 km. Diesel engine, automatic transmission. Full service history, new tires. Price negotiable.',
    price: 18500,
    currency: 'EUR',
    location: 'Bratislava',
    status: 'active',
    views_count: 156,
    image_url: 'https://images.unsplash.com/photo-1555215695-3004980ad54e?w=400&h=300&fit=crop'
  },
  {
    category_id: 'vehicles',
    user_id: '00000000-0000-0000-0000-000000000000',
    title: 'Honda CB600F Hornet 2007',
    description: 'Honda CB600F Hornet 600cc sport bike. 45,000 km, recently serviced. Comes with helmet and protective gear. Perfect for city riding.',
    price: 3200,
    currency: 'EUR',
    location: 'Žilina',
    status: 'active',
    views_count: 89,
    image_url: 'https://images.unsplash.com/photo-1558981806-ec527fa84c39?w=400&h=300&fit=crop'
  },

  // Real Estate
  {
    category_id: 'real-estate',
    user_id: '00000000-0000-0000-0000-000000000000',
    title: '2-Bedroom Apartment - City Center',
    description: 'Beautiful 2-bedroom apartment in Bratislava city center. 75m², fully furnished, parking included. Available immediately. Perfect for young professionals.',
    price: 1200,
    currency: 'EUR',
    location: 'Bratislava',
    status: 'active',
    views_count: 203,
    image_url: 'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?w=400&h=300&fit=crop'
  },
  {
    category_id: 'real-estate',
    user_id: '00000000-0000-0000-0000-000000000000',
    title: 'Family House with Garden',
    description: 'Spacious 4-bedroom family house in quiet neighborhood. 180m² living space, large garden, garage. Recently renovated with modern kitchen.',
    price: 2800,
    currency: 'EUR',
    location: 'Košice',
    status: 'active',
    views_count: 167,
    image_url: 'https://images.unsplash.com/photo-1570129477492-45c003edd2be?w=400&h=300&fit=crop'
  },

  // More ads for variety
  {
    category_id: 'electronics',
    user_id: '00000000-0000-0000-0000-000000000000',
    title: 'Samsung Galaxy S23 Ultra',
    description: 'Latest Samsung flagship with S Pen, 512GB storage, excellent camera. Unlocked, comes with all accessories. Like new condition.',
    price: 950,
    currency: 'EUR',
    location: 'Nitra',
    status: 'active',
    views_count: 67,
    image_url: 'https://images.unsplash.com/photo-1610945415295-d9bbf067e59c?w=400&h=300&fit=crop'
  },
  {
    category_id: 'vehicles',
    user_id: '00000000-0000-0000-0000-000000000000',
    title: 'Škoda Octavia 2019',
    description: 'Reliable Škoda Octavia with 1.5 TSI engine. Only 60,000 km, one previous owner. Perfect family car with great fuel economy.',
    price: 12500,
    currency: 'EUR',
    location: 'Prešov',
    status: 'active',
    views_count: 134,
    image_url: 'https://images.unsplash.com/photo-1549399735-cef2e2c3f638?w=400&h=300&fit=crop'
  },
  {
    category_id: 'real-estate',
    user_id: '00000000-0000-0000-0000-000000000000',
    title: 'Studio Apartment - Student Housing',
    description: 'Cozy studio apartment perfect for students. Close to university, all utilities included. Furnished with bed, desk, and kitchen appliances.',
    price: 450,
    currency: 'EUR',
    location: 'Žilina',
    status: 'active',
    views_count: 92,
    image_url: 'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?w=400&h=300&fit=crop'
  },
  {
    category_id: 'electronics',
    user_id: '00000000-0000-0000-0000-000000000000',
    title: 'PlayStation 5 Console + Games',
    description: 'Brand new PS5 console with DualSense controller. Includes 3 games: Spider-Man 2, God of War Ragnarök, and Horizon Forbidden West.',
    price: 550,
    currency: 'EUR',
    location: 'Trnava',
    status: 'active',
    views_count: 178,
    image_url: 'https://images.unsplash.com/photo-1606813907291-d86efa9b94db?w=400&h=300&fit=crop'
  }
];

async function seedAds() {
  console.log('🌱 Starting to seed test ads...');

  try {
    // Clear existing ads first
    const { error: deleteError } = await supabase
      .from('ads')
      .delete()
      .neq('id', '00000000-0000-0000-0000-000000000000'); // Keep placeholder if exists

    if (deleteError) {
      console.warn('Warning: Could not clear existing ads:', deleteError.message);
    }

    // Insert new ads
    const { data, error } = await supabase
      .from('ads')
      .insert(testAds)
      .select();

    if (error) {
      console.error('❌ Error seeding ads:', error);
      return;
    }

    console.log(`✅ Successfully seeded ${data?.length || 0} test ads`);
    console.log('📊 Ads by category:');
    const categoryCount = testAds.reduce((acc, ad) => {
      acc[ad.category_id] = (acc[ad.category_id] || 0) + 1;
      return acc;
    }, {} as Record<string, number>);

    Object.entries(categoryCount).forEach(([category, count]) => {
      console.log(`  - ${category}: ${count} ads`);
    });

  } catch (err) {
    console.error('❌ Unexpected error:', err);
  }
}

seedAds();
