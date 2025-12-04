# 🔧 FIX VERCEL ERROR - EXACT STEPS

## ❌ Error:
```
Environment Variable "VITE_SUPABASE_URL" references Secret "supabase_url", which does not exist.
```

---

## ✅ EXACT FIX STEPS:

### Step 1: Go to Vercel Project Settings
1. Open https://vercel.com/dashboard
2. Click your project: `ginza-industries-order-portal`
3. Click **"Settings"** tab

### Step 2: Go to Environment Variables
- Click **"Environment Variables"** in left sidebar

### Step 3: DELETE OLD VARIABLES
Look for these and DELETE them:
- ❌ VITE_SUPABASE_URL (if it shows error)
- ❌ VITE_SUPABASE_ANON_KEY (if it shows error)
- ❌ Any other variables with ❌ red X marks

Click the **trash icon** to delete each one.

### Step 4: ADD NEW VARIABLES (CORRECT WAY)

Click **"Add Environment Variable"** button

#### Variable 1: VITE_SUPABASE_URL
```
Name:  VITE_SUPABASE_URL
Value: https://qtctkhkykkwntecxgezs.supabase.co
```
(Just the URL, nothing else - NO @ symbol!)

Click **"Save"**

#### Variable 2: VITE_SUPABASE_ANON_KEY
```
Name:  VITE_SUPABASE_ANON_KEY
Value: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InF0Y3RraGt5a2t3bnRlY3hnZXpzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjM2Mzc5MzEsImV4cCI6MjA3OTIxMzkzMX0.JYwNRCuadt34wvKpIwjQjvfkMVr73iCphMnZ3oc-xFM
```
(The full key, nothing else - NO @ symbol!)

Click **"Save"**

---

## ⚠️ IMPORTANT:

### ❌ WRONG (what you did):
```
Name:  VITE_SUPABASE_URL
Value: @supabase_url       ← This tells Vercel to look for a Secret
```

### ✅ CORRECT (what to do):
```
Name:  VITE_SUPABASE_URL
Value: https://qtctkhkykkwntecxgezs.supabase.co   ← Actual URL value
```

---

## 📝 NO @ SYMBOL NEEDED

- ❌ `@supabase_url` - WRONG
- ❌ `$supabase_url` - WRONG
- ✅ `https://qtctkhkykkwntecxgezs.supabase.co` - CORRECT

---

## Step 5: REDEPLOY

1. Go to **Deployments** tab
2. Find the **FAILED** deployment
3. Click **"Redeploy"** button
4. Wait 2-5 minutes

---

## 🎯 SUMMARY

The `@` symbol is for Vercel Secrets/Projects. You don't need it here.

Just paste the **actual value** directly:
- Supabase URL: `https://qtctkhkykkwntecxgezs.supabase.co`
- Supabase Key: The long JWT string

That's it! ✅

---

## ✅ AFTER FIX:

You should see:
```
✓ VITE_SUPABASE_URL
✓ VITE_SUPABASE_ANON_KEY
```

(Green checkmarks, no errors)

Then redeploy and app will work! 🚀
