import * as dotenv from 'dotenv';
import { exec } from 'child_process';

dotenv.config({ path: '.env.local' });

const dbUrl = process.env.DATABASE_URL || 
  `postgresql://postgres:${process.env.SUPABASE_DB_PASSWORD}@${process.env.NEXT_PUBLIC_SUPABASE_URL?.replace('https://', '')}:5432/postgres`;

console.log('Executing database check...');
const process = exec(`psql "${dbUrl}" -f scripts/check_db.sql`);

process.stdout?.on('data', (data) => {
  console.log(data);
});

process.stderr?.on('data', (data) => {
  console.error(data);
});

process.on('close', (code) => {
  console.log(`Database check completed with code ${code}`);
});
