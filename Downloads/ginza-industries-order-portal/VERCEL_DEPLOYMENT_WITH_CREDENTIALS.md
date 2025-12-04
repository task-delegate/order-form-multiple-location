# 🚀 COMPLETE VERCEL DEPLOYMENT GUIDE - WITH YOUR CREDENTIALS

## ✅ YOUR PROJECT DETAILS:

**GitHub Repo:** https://github.com/task-delegate/order-form-multiple-location
**Vercel Team:** Tushar's projects
**Supabase URL:** https://qtctkhkykkwntecxgezs.supabase.co
**Supabase API Key:** eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InF0Y3RraGt5a2t3bnRlY3hnZXpzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjM2Mzc5MzEsImV4cCI6MjA3OTIxMzkzMX0.JYwNRCuadt34wvKpIwjQjvfkMVr73iCphMnZ3oc-xFM
**Google AI Studio Key:** AIzaSyCNBhSoKkehZSOuY3PtUMGj3O41ysBR8pA

---

## 🔧 STEP-BY-STEP DEPLOYMENT:

### STEP 1: Go to Vercel Dashboard
1. Open: https://vercel.com/dashboard
2. Make sure you're in **"Tushar's projects"** team (select from top-left dropdown)
3. Click **"Add New..."** button
4. Select **"Project"**

---

### STEP 2: Import GitHub Repository
1. Click **"Continue with GitHub"**
2. Search for: `task-delegate/order-form-multiple-location`
3. Click on your repo when it appears
4. Click **"Import"**

---

### STEP 3: Configure Project
**Screen: Configure Project**

**Project Name:**
```
order-form-multiple-location
```

**Framework Preset:**
```
Vite
```

**Root Directory:**
```
. (leave blank)
```

**Build Command:**
```
npm run build
```

**Output Directory:**
```
dist
```

**Install Command:**
```
npm install
```

---

### STEP 4: Add Environment Variables (CRITICAL)

**⚠️ IMPORTANT:** Click **"Add Environment Variable"** for each one

#### Variable 1:
```
Name:  VITE_SUPABASE_URL
Value: https://qtctkhkykkwntecxgezs.supabase.co
```
Click **"Save"**

#### Variable 2:
```
Name:  VITE_SUPABASE_ANON_KEY
Value: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InF0Y3RraGt5a2t3bnRlY3hnZXpzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjM2Mzc5MzEsImV4cCI6MjA3OTIxMzkzMX0.JYwNRCuadt34wvKpIwjQjvfkMVr73iCphMnZ3oc-xFM
```
Click **"Save"**

#### Variable 3:
```
Name:  GEMINI_API_KEY
Value: AIzaSyCNBhSoKkehZSOuY3PtUMGj3O41ysBR8pA
```
Click **"Save"**

#### Variable 4:
```
Name:  GAS_URL
Value: https://script.google.com/macros/s/AKfycby7hX97jGL2A5hJ4YhJu5STdOQa1rYQOI4jgKsteuN0FPDZuAYD4OoEXFSrEYtCqfbq5A/exec
```
Click **"Save"**

---

### STEP 5: VERIFY SETTINGS

Before clicking Deploy, verify:

| Setting | Value | Status |
|---------|-------|--------|
| Team | Tushar's projects | ✅ |
| Project Name | order-form-multiple-location | ✅ |
| Framework | Vite | ✅ |
| Build Command | `npm run build` | ✅ |
| Output Directory | `dist` | ✅ |
| VITE_SUPABASE_URL | Set ✓ | ✅ |
| VITE_SUPABASE_ANON_KEY | Set ✓ | ✅ |
| GEMINI_API_KEY | Set ✓ | ✅ |
| GAS_URL | Set ✓ | ✅ |

---

### STEP 6: DEPLOY! 🚀

1. Scroll to bottom
2. Click **"Deploy"** button
3. Wait 2-5 minutes for build to complete

You'll see:
```
⏳ Analyzing source code...
⏳ Installing dependencies...
⏳ Building project...
✓ Deployment complete!
```

---

## 🎉 AFTER DEPLOYMENT

Your app will be live at:
```
https://order-form-multiple-location.vercel.app
```

(Or similar - Vercel will show the exact URL)

---

## ✅ VERIFICATION CHECKLIST

After deployment, test:

1. **App Loads:**
   - Open your Vercel URL
   - Should show order form ✅

2. **Check Console (F12):**
   - Should see: ✅ "Processed 9653 items"
   - Should see: ✅ "Fetched 205 customers"
   - Should NOT see: ❌ Red errors

3. **Test Form:**
   - Fill out order form
   - Click Submit
   - Check Supabase (data saved) ✅
   - Check Google Sheet (data appears) ✅

---

## 🔑 YOUR DEPLOYMENT CREDENTIALS (SAVED)

Use these exact values in Vercel:

```
VITE_SUPABASE_URL = https://qtctkhkykkwntecxgezs.supabase.co

VITE_SUPABASE_ANON_KEY = eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InF0Y3RraGt5a2t3bnRlY3hnZXpzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjM2Mzc5MzEsImV4cCI6MjA3OTIxMzkzMX0.JYwNRCuadt34wvKpIwjQjvfkMVr73iCphMnZ3oc-xFM

GEMINI_API_KEY = AIzaSyCNBhSoKkehZSOuY3PtUMGj3O41ysBR8pA

GAS_URL = https://script.google.com/macros/s/AKfycby7hX97jGL2A5hJ4YhJu5STdOQa1rYQOI4jgKsteuN0FPDZuAYD4OoEXFSrEYtCqfbq5A/exec
```

---

## ⚠️ IMPORTANT NOTES:

1. **NO @ or $ symbols** - Just paste the values as-is
2. **Select "All" environment** (not just Production)
3. **Build Command must be:** `npm run build`
4. **Output Directory must be:** `dist`
5. **Team must be:** "Tushar's projects"

---

## 📞 IF DEPLOYMENT FAILS:

1. Check Deployment Logs in Vercel
2. Look for errors
3. Most common: Wrong environment variable format
4. Fix: Delete variable and re-add without @ symbol

---

## 🎯 YOUR FINAL DEPLOYMENT URL:

Once deployment completes, you'll get a URL like:
```
https://order-form-multiple-location.vercel.app
```

**Share this with your team!**

---

**Follow these exact steps and your app will deploy successfully!** 🚀
