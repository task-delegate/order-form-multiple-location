import { createClient } from '@supabase/supabase-js';

// Get credentials from environment variables
const supabaseUrl = import.meta.env.VITE_SUPABASE_URL || ''; 
const supabaseKey = import.meta.env.VITE_SUPABASE_ANON_KEY || '';

// Export a flag to check if DB is connected
export const isSupabaseConfigured = supabaseUrl.length > 0 && supabaseKey.length > 0;

// Initialize the Supabase client
export const supabase = isSupabaseConfigured
  ? createClient(supabaseUrl, supabaseKey)
  : { 
      // Mock implementation to prevent crashes if keys are somehow missing in future
      from: () => ({ 
        select: () => Promise.resolve({ data: [], error: null }),
        insert: () => ({ select: () => ({ single: () => Promise.resolve({ data: {}, error: null }) }) }),
        upsert: () => Promise.resolve({ data: null, error: null }),
        delete: () => Promise.resolve({ data: null, error: null })
      }) 
    } as any;

// This is the code block that represents the suggested code change:
// https://docs.google.com/spreadsheets/d/1xVSJlNilOKu2zi-R1Jeuv__buGkzbECSWef0MSLr4oM/edit
