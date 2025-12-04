# 🚀 VERCEL DEPLOYMENT STEP-BY-STEP GUIDE

## ✅ STEP 1: Go to Vercel Dashboard

1. Open: https://vercel.com/dashboard
2. Sign in with GitHub (if not already)
3. Click **"New Project"** button

---

## ✅ STEP 2: Import GitHub Repository

### Screen: "Create Git Repository"
- Select **GitHub** (if not selected)
- Search for your repo: `ginza-industries-order-portal`
- Click on your repo when it appears
- Click **"Import"** button

### What you'll see:
```
✓ Repository found
✓ GitHub account connected
✓ Ready to configure project
```

---

## ✅ STEP 3: Configure Project Settings

### Screen: "Configure Project"

**Project Name:**
- Keep as: `ginza-industries-order-portal` (or your choice)

**Root Directory:**
- Leave BLANK or set to: `.` (dot)
- ✅ IMPORTANT: Do NOT select a subfolder

**Framework Preset:**
- Select: **Vite**
- (It should auto-detect, but select if not)

**Build Command:**
- Clear any existing value
- Enter: `npm run build`

**Output Directory:**
- Clear any existing value
- Enter: `dist`

**Install Command:**
- Leave as default: `npm install` or `npm ci`

---

## ✅ STEP 4: Add Environment Variables

### Screen: "Environment Variables"

Click **"Add Environment Variable"** and add EXACTLY these 4:

### Variable 1:
```
Name:  VITE_SUPABASE_URL
Value: https://your-project.supabase.co
```
(Get from: https://app.supabase.com → Settings → Project URL)

### Variable 2:
```
Name:  VITE_SUPABASE_ANON_KEY
Value: your-anon-key-here
```
(Get from: https://app.supabase.com → Settings → API → anon public)

### Variable 3:
```
Name:  GEMINI_API_KEY
Value: your-gemini-key-here
```
(Get from: https://aistudio.google.com/app/apikeys - OPTIONAL)

### Variable 4:
```
Name:  GAS_URL
Value: https://script.google.com/macros/s/AKfycby7hX97jGL2A5hJ4YhJu5STdOQa1rYQOI4jgKsteuN0FPDZuAYD4OoEXFSrEYtCqfbq5A/exec
```
(Your Google Apps Script deployment URL)

---

## ✅ STEP 5: FINAL SETTINGS REVIEW

Before clicking Deploy, verify:

| Setting | Value | Status |
|---------|-------|--------|
| Framework | Vite | ✅ |
| Build Command | `npm run build` | ✅ |
| Output Directory | `dist` | ✅ |
| Root Directory | `.` (blank) | ✅ |
| VITE_SUPABASE_URL | Set | ✅ |
| VITE_SUPABASE_ANON_KEY | Set | ✅ |
| GAS_URL | Set | ✅ |

---

## ✅ STEP 6: DEPLOY

Click **"Deploy"** button

Wait for deployment to complete:
```
⏳ Analyzing source code...
⏳ Installing dependencies...
⏳ Building project...
✓ Deployment complete!
```

---

## 🎉 AFTER DEPLOYMENT

### Your app is live at:
```
https://ginza-industries-order-portal.vercel.app
```

### Share this link with your friends!

---

## 🔍 IF DEPLOYMENT FAILS

### Check Logs:
1. Go to Vercel Dashboard
2. Click on your project
3. Go to **"Deployments"** tab
4. Click the **FAILED** deployment
5. Scroll down to see **Build Logs**
6. Look for error messages

### Common Errors & Fixes:

**Error: "Cannot find module"**
- Fix: Ensure VITE_SUPABASE_URL is correct format

**Error: "Build failed"**
- Fix: Run `npm run build` locally to check

**Error: "Environment variables not found"**
- Fix: Verify all 4 variables are added in Environment Variables

**Error: "dist folder not found"**
- Fix: Verify Output Directory is set to `dist`

---

## ✅ VERIFY APP WORKS

After deployment:

1. **Open your Vercel URL**
   ```
   https://ginza-industries-order-portal.vercel.app
   ```

2. **Check Console (Press F12)**
   - Should see: ✅ Processed 9653 items
   - Should see: ✅ Fetched 205 customers
   - Should NOT see: ❌ Red errors

3. **Test Form Submission**
   - Fill form with test data
   - Click Submit
   - Check: ✅ Order saved to Supabase
   - Check: ✅ Data in Google Sheet

---

## 📊 BUILD & OUTPUT SETTINGS SUMMARY

| Setting | Value | Why? |
|---------|-------|------|
| Build Command | `npm run build` | Vite builds React app |
| Output Directory | `dist` | Where Vite outputs |
| Root Directory | `.` | Project root is main dir |
| Framework | Vite | Uses Vite bundler |
| Node Version | 18+ | Auto-detected |

---

## 🔐 ENVIRONMENT VARIABLES EXPLANATION

| Variable | Where to Get | Example |
|----------|--------------|---------|
| VITE_SUPABASE_URL | Supabase Dashboard | `https://xyz.supabase.co` |
| VITE_SUPABASE_ANON_KEY | Supabase → Settings → API | Long string starting with `eyJ` |
| GEMINI_API_KEY | Google AI Studio | Long string (OPTIONAL) |
| GAS_URL | Google Apps Script → Deploy | URL ending with `/exec` |

---

## ⚠️ IMPORTANT NOTES

1. **Do NOT click "Deploy" before adding Environment Variables**
   - Build will fail without them

2. **Use your ACTUAL values, not examples**
   - Each project has unique keys

3. **Supabase URL must end with .co**
   - Example: `https://your-project.supabase.co`

4. **GAS_URL must end with /exec**
   - Example: `.../macros/s/YOUR_ID/exec`

5. **GEMINI_API_KEY is optional**
   - Leave blank if not using Gemini

---

## 🎯 QUICK CHECKLIST

Before clicking "Deploy":

- [ ] GitHub repo connected
- [ ] Build Command: `npm run build`
- [ ] Output Directory: `dist`
- [ ] VITE_SUPABASE_URL added
- [ ] VITE_SUPABASE_ANON_KEY added
- [ ] GAS_URL added
- [ ] Ready to click Deploy ✅

---

## 🚀 YOU'RE READY!

All settings are prepared. Just follow the steps above and click Deploy!

Your app will be live globally in 2-5 minutes.

**Share this link with your team:**
```
https://ginza-industries-order-portal.vercel.app
```

---

**Questions?** Check the logs in Vercel Dashboard if anything goes wrong.
