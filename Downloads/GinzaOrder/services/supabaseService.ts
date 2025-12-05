
import { supabase, isSupabaseConfigured } from '../supabaseClient';
import { Customer, Item, OrderFormData, OrderLineItem, RegisteredUser } from '../types';

// --- Auth (Users) ---

export const registerUser = async (user: Omit<RegisteredUser, 'id'>): Promise<{ success: boolean, message: string, user?: RegisteredUser }> => {
  if (!isSupabaseConfigured) {
    return { success: false, message: "Database not connected. Check API Keys." };
  }

  try {
    // 1. Check if email exists
    const { data: existingUsers, error: checkError } = await supabase
      .from('app_users')
      .select('email')
      .eq('email', user.email);

    if (checkError) {
      console.error("DB Check Error:", checkError);
      return { success: false, message: `DB Error (Check SQL Permissions): ${checkError.message}` };
    }

    if (existingUsers && existingUsers.length > 0) {
      return { success: false, message: "Email is already registered. Please Login." };
    }

    // 2. Insert new user
    const { data, error } = await supabase
      .from('app_users')
      .insert([{
        first_name: user.firstName,
        last_name: user.lastName,
        email: user.email,
        password: user.password,
        branch_id: user.branchId
      }])
      .select()
      .single();

    if (error) {
      console.error("Registration Insert Error:", error);
      if (error.code === '42501') {
         return { success: false, message: "Permission Denied. Run 'ALTER TABLE app_users DISABLE ROW LEVEL SECURITY;' in Supabase SQL Editor." };
      }
      return { success: false, message: `Save Error: ${error.message}` };
    }

    return { 
      success: true, 
      message: "Registration successful!", 
      user: {
        id: data.id,
        firstName: data.first_name,
        lastName: data.last_name,
        email: data.email,
        password: data.password,
        branchId: data.branch_id
      }
    };

  } catch (error: any) {
    console.error("Registration Exception:", error);
    return { success: false, message: `Registration Exception: ${error.message}` };
  }
};

export const createGhostUser = async (fullName: string, targetBranchId: string = 'mum'): Promise<RegisteredUser | null> => {
  if (!isSupabaseConfigured) return null;
  
  // Create dummy data
  const nameParts = fullName.trim().split(' ');
  const firstName = nameParts[0];
  const lastName = nameParts.length > 1 ? nameParts.slice(1).join(' ') : 'Sales';
  const cleanName = fullName.toLowerCase().replace(/[^a-z0-9]/g, '');
  const email = `${cleanName}.${Date.now().toString().slice(-4)}@ginza.temp`;
  const password = '123'; 
  
  // Use provided branchId
  const branchId = targetBranchId; 

  try {
     const { data, error } = await supabase
      .from('app_users')
      .insert([{
        first_name: firstName,
        last_name: lastName,
        email: email,
        password: password,
        branch_id: branchId
      }])
      .select()
      .single();

    if (error) {
      console.error("Ghost User Creation Failed:", error);
      return null;
    }

    return {
        id: data.id,
        firstName: data.first_name,
        lastName: data.last_name,
        email: data.email,
        password: data.password,
        branchId: data.branch_id
    };

  } catch (e) {
    console.error("Ghost User Error:", e);
    return null;
  }
};

export const loginUser = async (email: string, password: string): Promise<{ success: boolean, message: string, user?: RegisteredUser }> => {
  if (!isSupabaseConfigured) {
     return { success: false, message: "Database not connected." };
  }

  try {
    const { data, error } = await supabase
      .from('app_users')
      .select('*')
      .eq('email', email)
      .eq('password', password) 
      .maybeSingle(); 

    if (error) {
      console.error("Login DB Error:", error);
      return { success: false, message: `DB Connection Error: ${error.message}` };
    }

    if (!data) {
      return { success: false, message: "Invalid Email or Password." };
    }

    return { 
      success: true, 
      message: "Login successful!", 
      user: {
        id: data.id,
        firstName: data.first_name,
        lastName: data.last_name,
        email: data.email,
        password: data.password,
        branchId: data.branch_id
      }
    };

  } catch (error: any) {
    console.error("Login Exception:", error);
    return { success: false, message: `Login Failed: ${error.message}` };
  }
};

export const fetchAllAppUsers = async (): Promise<RegisteredUser[]> => {
  if (!isSupabaseConfigured) return [];
  
  const { data, error } = await supabase
    .from('app_users')
    .select('*');
    
  if (error) {
    console.error("Error fetching users:", error);
    return [];
  }

  return data.map((u: any) => ({
    id: u.id,
    firstName: u.first_name || '', // Safety fallback
    lastName: u.last_name || '',   // Safety fallback
    email: u.email,
    password: '',
    branchId: u.branch_id
  }));
};

// --- Customers ---

export const fetchCustomersBySalesPerson = async (salesPersonId: string): Promise<Customer[]> => {
  if (!isSupabaseConfigured) return []; 
  
  if (!salesPersonId) {
    console.warn("fetchCustomersBySalesPerson called with empty ID");
    return [];
  }

  const { data, error } = await supabase
    .from('customers')
    .select('*')
    .eq('sales_person_id', salesPersonId)
    .order('name', { ascending: true });

  if (error) {
    // Log the message string explicitly
    console.error('Error fetching customers:', error.message);
    return [];
  }

  return data.map((c: any) => ({
    id: c.id,
    name: c.name,
    email: c.email,
    contactNo: c.contact_no,
    billingAddress: c.billing_address,
    deliveryAddress: c.delivery_address,
    salesPersonId: c.sales_person_id,
    branch: c.branch
  }));
};

export const fetchCustomersByBranchAndSalesPerson = async (branchId: string, salesPersonName?: string): Promise<Customer[]> => {
  if (!isSupabaseConfigured) {
    console.error('❌ Supabase NOT configured - check supabaseClient.ts');
    return [];
  }

  console.log('🔍 FETCHING CUSTOMERS:');
  console.log('   Branch ID:', branchId);
  console.log('   Sales Person Name:', salesPersonName);

  try {
    // First, check if table exists and has data
    const { data: tableCheck, error: tableError } = await supabase
      .from('customers')
      .select('id', { count: 'exact' })
      .limit(1);

    if (tableError) {
      console.error('❌ Cannot access customers table:', tableError.message);
      console.error('   Error Code:', tableError.code);
      if (tableError.code === '42501' || tableError.message.includes('permission')) {
        console.error('   ⚠️  Row Level Security (RLS) might be blocking access');
        console.error('   💡 Fix: Go to Supabase Dashboard → customers table → Disable Row Level Security');
      }
      return [];
    }

    console.log('✅ Customers table is accessible');

    // Build flexible branch matching - try multiple variations
    // Priority: Specific branch names (with HO) first, then fallbacks
    const branchVariations = [
      // Priority 1: Exact branch names with HO suffix (matches Supabase data)
      branchId === 'mumbai' ? 'Mumbai HO' : null,
      branchId === 'ulhasnagar' ? 'Ulhasnagar HO' : null,
      branchId === 'delhi' ? 'Delhi HO' : null,
      branchId === 'bangalore' ? 'Banglore HO' : null,
      // Priority 2: Alternative names
      branchId === 'mumbai' ? 'Mumbai' : null,
      branchId === 'ulhasnagar' ? 'Ulhasnagar' : null,
      branchId === 'delhi' ? 'Delhi' : null,
      branchId === 'bangalore' ? 'Banglore' : null,
      // Priority 3: Fallbacks
      branchId,
      branchId.toUpperCase(),
      branchId.charAt(0).toUpperCase() + branchId.slice(1),
    ].filter(Boolean);

    console.log('   Branch variations to search:', branchVariations);

    // Fetch ALL customers first
    const { data: allData, error: fetchError } = await supabase
      .from('customers')
      .select('*');

    if (fetchError) {
      console.error('❌ Error fetching customers:', fetchError.message);
      console.error('   Code:', fetchError.code);
      return [];
    }

    console.log(`✅ Fetched ${allData?.length || 0} total customers from database`);
    
    if (!allData || allData.length === 0) {
      console.error('   ❌ Customers table is EMPTY - no data to load');
      return [];
    }

    // Show sample of database structure
    if (allData.length > 0) {
      console.log('📊 Sample data from database:');
      console.log('   Columns:', Object.keys(allData[0]));
      console.log('   First record:', allData[0]);
    }

    // Filter by branch - case insensitive match
    let branchFiltered = allData.filter((c: any) => {
      const customerBranch = (c.branch || '').toLowerCase();
      return branchVariations.some(v => v && customerBranch === v.toLowerCase());
    });

    console.log(`✅ After branch filter: ${branchFiltered.length} customers`);

    // Filter by sales person name if provided
    let filteredData = branchFiltered;
    if (salesPersonName) {
      filteredData = filteredData.filter((c: any) => 
        c.sales_person_name && c.sales_person_name.toLowerCase() === salesPersonName.toLowerCase()
      );
      console.log(`✅ After sales person filter: ${filteredData.length} customers for "${salesPersonName}"`);
    }
    
    if (filteredData.length === 0) {
      console.warn('⚠️  No customers match:');
      console.warn('   Branch:', branchId);
      console.warn('   Branch variations tried:', branchVariations);
      console.warn('   Sales Person Name:', salesPersonName);
      console.log('📊 Available data in database:');
      
      const branches = new Set(allData.map((c: any) => c.branch));
      const salesPersons = new Set(allData.map((c: any) => c.sales_person_name));
      console.log('   Unique branches:', Array.from(branches));
      console.log('   Unique sales persons:', Array.from(salesPersons));
      console.log('   Sample customers:');
      allData.slice(0, 10).forEach((c: any) => {
        console.log(`     • ${c.customer_name || '(no name)'} | Branch: ${c.branch} | Sales Person: ${c.sales_person_name || '(no sales person)'}`);
      });
    }
    
    // Filter out null names
    const validCustomers = filteredData.filter((c: any) => c.customer_name && c.customer_name.trim());
    
    const result = validCustomers.map((c: any) => ({
      id: c.id,
      name: c.customer_name,
      email: c.email_id,
      contactNo: c.mob_no,
      billingAddress: c.billing_address,
      deliveryAddress: c.delivery_address,
      salesPersonId: c.sales_person_name,
      branch: c.branch
    }));

    console.log('✅ Returning customers:', result);
    return result;
  } catch (err) {
    console.error('❌ Exception in fetchCustomersByBranchAndSalesPerson:', err);
    return [];
  }
};

export const createNewCustomer = async (
  salesPersonName: string,
  formData: OrderFormData
): Promise<{ success: boolean; message: string; customerData?: Customer }> => {
  if (!isSupabaseConfigured) {
    return { success: false, message: 'Database not connected' };
  }

  if (!formData.customerName) {
    return { success: false, message: 'Customer name is required' };
  }

  if (!salesPersonName) {
    return { success: false, message: 'Sales person must be selected' };
  }

  if (!formData.branch) {
    return { success: false, message: 'Branch must be selected' };
  }

  try {
    // Map branch name to database branch name (with HO suffix if needed)
    let dbBranch = formData.branch;
    if (formData.branch === 'Mumbai' || formData.branch === 'mumbai') {
      dbBranch = 'Mumbai HO';
    } else if (formData.branch === 'Ulhasnagar' || formData.branch === 'ulhasnagar') {
      dbBranch = 'Ulhasnagar HO';
    }

    const newCustomer = {
      customer_name: formData.customerName,
      sales_person_name: salesPersonName,
      email_id: formData.customerEmail || '',
      mob_no: formData.customerContactNo || '',
      billing_address: formData.billingAddress || '',
      delivery_address: formData.deliveryAddress || '',
      branch: dbBranch
    };

    console.log('📝 Creating new customer:', newCustomer);

    const { data, error } = await supabase
      .from('customers')
      .insert([newCustomer])
      .select()
      .single();

    if (error) {
      console.error('❌ Error creating customer:', error.message);
      return { 
        success: false, 
        message: `Database error: ${error.message}` 
      };
    }

    console.log('✅ Customer created successfully:', data);

    const customerData: Customer = {
      id: data.id,
      name: data.customer_name,
      email: data.email_id,
      contactNo: data.mob_no,
      billingAddress: data.billing_address,
      deliveryAddress: data.delivery_address,
      salesPersonId: data.sales_person_name,
      branch: data.branch
    };

    return { 
      success: true, 
      message: 'Customer added to database!',
      customerData
    };
  } catch (err: any) {
    console.error('❌ Exception creating customer:', err);
    return { 
      success: false, 
      message: `Error: ${err.message}` 
    };
  }
};

export const bulkUpsertCustomers = async (customers: { sales_person_id: string, name: string, email?: string, contact_no: string, billing_address: string, delivery_address: string, branch?: string }[]): Promise<boolean> => {
  if (!isSupabaseConfigured || customers.length === 0) return false;

  const BATCH_SIZE = 100;
  try {
    for (let i = 0; i < customers.length; i += BATCH_SIZE) {
      const batch = customers.slice(i, i + BATCH_SIZE);
      const { error } = await supabase
        .from('customers')
        .upsert(batch, { onConflict: 'name,sales_person_id' }); 

      if (error) throw error;
    }
    return true;
  } catch (error) {
    console.error("Bulk customer upload failed:", error);
    return false;
  }
};

// --- Items (items_new) ---

export const fetchMasterItems = async (): Promise<Item[]> => {
  if (!isSupabaseConfigured) {
    console.error('❌ Supabase not configured');
    return [];
  }

  console.log('📥 Fetching items from items_new table...');

  // Map of form category names to Supabase column names and width columns
  // Handles both common spellings (embroidary/embroidery, etc)
  const categoryMap: { [key: string]: { itemCols: string[]; widthCols: string[] } } = {
      'WARP': { itemCols: ['warp'], widthCols: ['width_warp'] },
      'CKU': { itemCols: ['cku'], widthCols: ['width_cku'] },
      'EMBROIDARY': { itemCols: ['embroidary', 'embroidery'], widthCols: ['width_embroidary', 'width_embroidery'] },
      'CRO': { itemCols: ['cro'], widthCols: ['width_cro'] },
      'ELASTIC': { itemCols: ['elastic'], widthCols: ['width_elastic'] },
      'EYE-N-HOOK': { itemCols: ['eye_n_hook', 'eye_hook', 'eye_n_hooks'], widthCols: ['width_eye_n_hook', 'width_eye_hook'] },
      'CUP': { itemCols: ['cup'], widthCols: ['width_cup'] },
      'TLU': { itemCols: ['tlu'], widthCols: ['width_tlu'] },
      'VAU': { itemCols: ['vau'], widthCols: ['width_vau'] },
      'PRINTING': { itemCols: ['printing'], widthCols: ['width_printing'] }
    };

  try {
    console.log('🔗 Checking Supabase connection...');
    console.log('   isSupabaseConfigured:', isSupabaseConfigured);
    
    const { data, error } = await supabase
      .from('items_new') 
      .select('*');

    if (error) {
      console.error('❌ Error fetching items from items_new table');
      console.error('   Message:', error.message);
      console.error('   Code:', error.code);
      if (error.code === '42501') {
        console.error('   ⚠️  RLS (Row Level Security) permission issue');
        console.error('      → Go to Supabase → items_new table → RLS → Enable public SELECT');
      }
      if (error.code === '42P01') {
        console.error('   ⚠️  Table "items_new" does not exist');
        console.error('      → Create the items_new table in Supabase with your item data');
      }
      return [];
    }

    if (!data) {
      console.error('❌ No data returned from query (data is null/undefined)');
      return [];
    }

    console.log(`✅ Fetched ${data.length} items from items_new table`);
    
    if (data.length === 0) {
      console.warn('⚠️  items_new table is empty - no rows of data');
      console.warn('   → Add your item data to Supabase items_new table');
      return [];
    }
    
    if (data.length > 0) {
      console.log('📋 Sample first item:', JSON.stringify(data[0], null, 2));
      console.log('📊 Available columns:', Object.keys(data[0]));
      
      // Debug: Check which categories have data
      console.log('🔍 Checking categories with data:');
      Object.entries(categoryMap).forEach(([categoryName, { itemCols }]) => {
        const itemsInCategory = data.filter(row => 
          itemCols.some(col => row[col] && row[col].toString().trim())
        ).length;
        if (itemsInCategory > 0) {
          console.log(`   ✅ ${categoryName}: ${itemsInCategory} items`);
        }
      });
    }

    // Flatten all items from all category columns
    const allItems: Item[] = [];
    const categoryItemCounts: { [key: string]: number } = {};
    
    (data || []).forEach((row: any, rowIndex: number) => {
      // For each category, check if it has items
      Object.entries(categoryMap).forEach(([categoryName, { itemCols, widthCols }]) => {
        // Find which column has data (try all variants)
        const itemCol = itemCols.find(col => {
          const val = row[col];
          return val && (typeof val === 'string' ? val.trim() : val);
        });
        if (!itemCol) return; // No data in this category for this row
        
        const itemName = row[itemCol];
        if (!itemName || (typeof itemName === 'string' && !itemName.trim())) return;
        
        // Find width column (first available)
        let width = '';
        for (const widthCol of widthCols) {
          const val = row[widthCol];
          if (val) {
            width = val.toString();
            break;
          }
        }
        
        // Try multiple rate column name variants (very flexible)
        let rate = 0;
        const rateColumnVariants = [
          `rate_${itemCol}`,           // rate_embroidary
          `rate_${categoryName.toLowerCase()}`, // rate_embroidary
          `rate`,                      // rate (fallback)
          `${itemCol}_rate`,           // embroidary_rate
          `${categoryName.toLowerCase()}_rate` // embroidary_rate
        ];
        
        for (const rateCol of rateColumnVariants) {
          const val = row[rateCol];
          if (val !== undefined && val !== null && val !== '') {
            rate = parseFloat(val) || 0;
            if (rate > 0) break; // Found a valid rate
          }
        }
        
        // Add item
        const cleanItemName = typeof itemName === 'string' ? itemName.trim() : itemName;
        if (cleanItemName) {
          allItems.push({
            id: `${row.id}_${categoryName}_${rowIndex}`,
            category: categoryName,
            itemName: cleanItemName,
            defaultRate: rate,
            defaultWidth: width || ''
          });
          
          categoryItemCounts[categoryName] = (categoryItemCounts[categoryName] || 0) + 1;
        }
      });
    });

    console.log(`✅ Processed ${allItems.length} total items across all categories`);
    if (allItems.length > 0) {
      const categories = new Set(allItems.map(i => i.category));
      console.log('📊 Available categories:', Array.from(categories));
      console.log('📊 Items per category:', categoryItemCounts);
      console.log('📊 Sample items:', allItems.slice(0, 5));
    } else {
      console.warn('⚠️  No items processed - check if column names match categoryMap');
      console.warn('   categoryMap expects:', Object.keys(categoryMap));
      console.warn('   but table has columns:', data.length > 0 ? Object.keys(data[0]) : 'none');
    }
    
    return allItems;
  } catch (err) {
    console.error('❌ Exception fetching items:', err);
    return [];
  }
};

export const bulkUpsertItems = async (items: { category: string, item_name: string, default_width?: string }[]): Promise<boolean> => {
  if (!isSupabaseConfigured || items.length === 0) return false;

  const BATCH_SIZE = 100;
  
  try {
    for (let i = 0; i < items.length; i += BATCH_SIZE) {
      const batch = items.slice(i, i + BATCH_SIZE);
      const { error } = await supabase
        .from('items_new') 
        .upsert(batch, { onConflict: 'item_name' }); 

      if (error) throw error;
    }
    return true;
  } catch (error) {
    console.error("Bulk upload failed:", error);
    return false;
  }
};

// --- Orders ---

export const saveOrderToDb = async (
  salesPersonId: string,
  formData: OrderFormData,
  items: OrderLineItem[]
) => {
  if (!isSupabaseConfigured) return;

  const { error } = await supabase
    .from('orders')
    .insert([{
      sales_person_id: salesPersonId,
      branch_id: formData.branch,
      customer_name: formData.customerName,
      order_date: formData.orderDate,
      order_data: {
        formData,
        items
      }
    }]);

  if (error) console.error("Error saving order to DB:", error.message);
};

// --- Seed Test Data ---

export const seedTestCustomers = async (branchId: string, salesPersonId: string): Promise<boolean> => {
  if (!isSupabaseConfigured) return false;

  console.log('🌱 Seeding test customers...');

  const testCustomers = [
    {
      name: 'Amit Kumar',
      email: 'amit@email.com',
      contact_no: '9876543210',
      billing_address: 'Mumbai, Maharashtra',
      delivery_address: 'Mumbai, Maharashtra',
      sales_person_id: salesPersonId,
      branch: branchId
    },
    {
      name: 'Rajesh Singh',
      email: 'rajesh@email.com',
      contact_no: '9876543211',
      billing_address: 'Mumbai, Maharashtra',
      delivery_address: 'Mumbai, Maharashtra',
      sales_person_id: salesPersonId,
      branch: branchId
    },
    {
      name: 'Vikram Patel',
      email: 'vikram@email.com',
      contact_no: '9876543212',
      billing_address: 'Mumbai, Maharashtra',
      delivery_address: 'Mumbai, Maharashtra',
      sales_person_id: salesPersonId,
      branch: branchId
    },
    {
      name: 'Ankit Sharma',
      email: 'ankit@email.com',
      contact_no: '9876543213',
      billing_address: 'Mumbai, Maharashtra',
      delivery_address: 'Mumbai, Maharashtra',
      sales_person_id: salesPersonId,
      branch: branchId
    },
    {
      name: 'Pradeep Kumar',
      email: 'pradeep@email.com',
      contact_no: '9876543214',
      billing_address: 'Mumbai, Maharashtra',
      delivery_address: 'Mumbai, Maharashtra',
      sales_person_id: salesPersonId,
      branch: branchId
    }
  ];

  try {
    const { data, error } = await supabase
      .from('customers')
      .insert(testCustomers)
      .select();

    if (error) {
      console.error('❌ Failed to seed customers:', error.message);
      return false;
    }

    console.log(`✅ Seeded ${data?.length || 0} test customers`);
    return true;
  } catch (error: any) {
    console.error('❌ Exception seeding customers:', error);
    return false;
  }
};

// Diagnostic function to check what tables exist and their structure
export const diagnoseSupabaseTables = async () => {
  console.log('\n🔍 SUPABASE DIAGNOSTIC - Checking available tables...\n');
  
  const tablesToCheck = ['items_new', 'items', 'products', 'item'];
  
  for (const tableName of tablesToCheck) {
    try {
      const { data, error } = await supabase
        .from(tableName)
        .select('*')
        .limit(1);
      
      if (error) {
        console.log(`❌ Table "${tableName}": ${error.message}`);
      } else {
        console.log(`✅ Table "${tableName}" EXISTS`);
        if (data && data.length > 0) {
          console.log(`   Columns:`, Object.keys(data[0]));
          console.log(`   Sample data:`, data[0]);
        }
      }
    } catch (err: any) {
      console.log(`❌ Table "${tableName}": Exception - ${err.message}`);
    }
  }
};

