# 🔧 FIX VERCEL ENVIRONMENT VARIABLES ERROR

## ❌ Error Message:
```
Environment Variable "VITE_SUPABASE_URL" references Secret "supabase_url", which does not exist.
```

## ✅ Solution:

You entered: `$supabase_url` or `@supabase_url`

**But you should enter the ACTUAL URL value, NOT a reference!**

---

## 🚀 HOW TO FIX:

### Step 1: Go to Vercel Project Settings
1. Open https://vercel.com/dashboard
2. Click your project: `ginza-industries-order-portal`
3. Go to **Settings** tab → **Environment Variables**

### Step 2: Delete the Wrong Variables
Look for these variables with ❌ status:
- VITE_SUPABASE_URL
- VITE_SUPABASE_ANON_KEY
- GEMINI_API_KEY
- GAS_URL

Click the **trash icon** to delete them.

### Step 3: Add Variables CORRECTLY

**IMPORTANT:** Enter the ACTUAL VALUES, not references!

#### Add Variable 1: VITE_SUPABASE_URL
```
Name:  VITE_SUPABASE_URL
Value: https://qtctkhkykkwntecxgezs.supabase.co
```
(Use your actual Supabase URL - the one from the error message)

#### Add Variable 2: VITE_SUPABASE_ANON_KEY
```
Name:  VITE_SUPABASE_ANON_KEY
Value: eyJ0eXAiOiJKV1QiLCJhbGc... (your full anon key)
```

Get this from:
- Go to https://app.supabase.com
- Project Settings → API
- Copy "anon public" key (the long string starting with eyJ)

#### Add Variable 3: GAS_URL
```
Name:  GAS_URL
Value: https://script.google.com/macros/s/AKfycby7hX97jGL2A5hJ4YhJu5STdOQa1rYQOI4jgKsteuN0FPDZuAYD4OoEXFSrEYtCqfbq5A/exec
```

#### Add Variable 4: GEMINI_API_KEY (Optional)
```
Name:  GEMINI_API_KEY
Value: AIzaSy... (your key or leave empty)
```

### Step 4: Save & Redeploy

1. After adding all variables, go to **Deployments** tab
2. Click on the **FAILED** deployment
3. Click **"Redeploy"** button at the top right
4. Wait for new build to complete

---

## ⚠️ WHAT WENT WRONG:

You entered: `$supabase_url` or `@supabase_url`

This tells Vercel to look for a **Secret** named `supabase_url`, but you never created it.

**Instead, enter the actual URL value directly!**

---

## 📸 VISUAL GUIDE:

### ❌ WRONG:
```
Name:  VITE_SUPABASE_URL
Value: @supabase_url        ← ERROR! This is a reference
```

### ✅ CORRECT:
```
Name:  VITE_SUPABASE_URL
Value: https://qtctkhkykkwntecxgezs.supabase.co   ← Actual URL
```

---

## 🔑 YOUR ACTUAL VALUES TO USE:

Use these exact values:

```
VITE_SUPABASE_URL = https://qtctkhkykkwntecxgezs.supabase.co

VITE_SUPABASE_ANON_KEY = (Get from Supabase Settings → API → anon public)

GAS_URL = https://script.google.com/macros/s/AKfycby7hX97jGL2A5hJ4YhJu5STdOQa1rYQOI4jgKsteuN0FPDZuAYD4OoEXFSrEYtCqfbq5A/exec
```

---

## ✅ AFTER FIXING:

Once you add the correct values:
1. All environment variables will show ✅ (no error)
2. Click "Redeploy"
3. App will deploy successfully
4. You'll get live link: https://ginza-industries-order-portal.vercel.app

---

## 🎯 NEXT STEPS:

1. Delete wrong variables from Vercel
2. Add correct values (not references)
3. Click "Redeploy"
4. Wait 2-5 minutes
5. App will be live! 🚀

**The Supabase URL you already have is correct!**
