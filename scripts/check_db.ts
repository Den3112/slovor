import * as dotenv from 'dotenv';
import { exec } from 'child_process';

dotenv.config({ path: '.env.local' });

const dbUrl: string = process.env.DATABASE_URL ||
  `postgresql://postgres:${process.env.SUPABASE_DB_PASSWORD}@${process.env.NEXT_PUBLIC_SUPABASE_URL?.replace('https://', '')}:5432/postgres`;

console.log('Executing database check...');
const childProcess = exec(`psql "${dbUrl}" -f scripts/check_db.sql`);

childProcess.stdout?.on('data', (data) => {
  console.log(data);
});

childProcess.stderr?.on('data', (data) => {
  console.error(data);
});

childProcess.on('close', (code) => {
  console.log(`Database check completed with code ${code}`);
});
