import {createClient} from '@supabase/supabase-js';
const s = createClient(
'https://uwwwpecychokixajrmpbi.supabase.co',
'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InV3d3BlY3ljaG9raXhhanJtcGJpIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc2NDY4MDg2MCwiZXhwIjoyMDgwMjU2ODYwfQ.GFj-Z4rFmoDvYrq1hFK7169ihqKx8Cl2cBDebqcvcRE'
);
try {
const {count,error} = await s.from('categories').select('*',{count:'exact',head:true});
console.log(error?'❌ Supabase error:'+error.message:'✅ Supabase works. Categories:'+count);
} catch(e) {
console.log('❌ Network error:'+e.message);
}
