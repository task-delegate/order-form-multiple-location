# ✅ COMPLETE GITHUB & VERCEL DEPLOYMENT GUIDE

## 📋 STEP 1: Files to Upload to GitHub

### ✅ MUST UPLOAD (Source Files)
```
├── App.tsx                    # Main React component
├── index.tsx                  # Entry point
├── index.html                 # HTML template
├── constants.ts               # App constants & configuration
├── types.ts                   # TypeScript type definitions
├── supabaseClient.ts          # Supabase client setup
├── tsconfig.json              # TypeScript config
├── vite.config.ts             # Vite bundler config
├── package.json               # Dependencies & scripts
├── package-lock.json          # Locked dependency versions
├── vercel.json                # Vercel deployment config (NEW)
├── .gitignore                 # Files to exclude from Git
├── .env.example               # Environment variables template
├── manifest.json              # PWA manifest
├── metadata.json              # App metadata
├── README.md                  # Project documentation
├── components/
│   ├── Button.tsx
│   ├── Input.tsx
├── services/
│   ├── geminiService.ts
│   ├── sheetService.ts
│   └── supabaseService.ts
└── api/
    └── proxy.js               # Vercel serverless function
```

### ❌ DO NOT UPLOAD
- `node_modules/` - Gets installed automatically
- `dist/` - Gets built automatically
- `.env.local` - Contains secrets (use .env.example instead)
- `New folder/` - Temporary folder
- All `.md` documentation files (keep README.md only)

---

## 📝 STEP 2: Setup .env.example (Template for Secrets)

Check if `.env.example` exists. If not, create it with this content:

```env
# Supabase Configuration
VITE_SUPABASE_URL=https://your-project.supabase.co
VITE_SUPABASE_ANON_KEY=your-anon-key-here

# Google Gemini API (optional)
GEMINI_API_KEY=your-gemini-key-here

# Google Apps Script Proxy
GAS_URL=https://script.google.com/macros/s/YOUR_DEPLOYMENT_ID/exec
```

**NOTE:** Users will copy this to `.env.local` and fill in their own values.

---

## 🚀 STEP 3: Verify Configuration Files

### ✅ package.json (Should Have)
```json
{
  "name": "ginza-industries-order-portal",
  "type": "module",
  "scripts": {
    "dev": "vite",
    "build": "vite build",
    "preview": "vite preview"
  }
}
```

### ✅ vite.config.ts (Should Have)
- React plugin configured
- Environment variables loaded
- Port set to 3000

### ✅ vercel.json (MUST HAVE - NEWLY CREATED)
```json
{
  "buildCommand": "npm run build",
  "outputDirectory": "dist",
  "rewrites": [
    {
      "source": "/(.*)",
      "destination": "/index.html"
    }
  ]
}
```

### ✅ .gitignore (UPDATED)
- Excludes node_modules
- Excludes dist
- Excludes .env.local
- Excludes documentation files

---

## 📤 STEP 4: Push to GitHub

```powershell
# 1. Initialize Git (if not already done)
git init

# 2. Add all files
git add .

# 3. Commit
git commit -m "Initial commit: Ginza Industries Order Portal"

# 4. Create main branch
git branch -M main

# 5. Add remote (replace with your GitHub URL)
git remote add origin https://github.com/YOUR_USERNAME/ginza-industries-order-portal.git

# 6. Push to GitHub
git push -u origin main
```

---

## 🌐 STEP 5: Deploy to Vercel

### Option A: Using Vercel CLI
```powershell
# 1. Install Vercel CLI
npm i -g vercel

# 2. Deploy (first time)
vercel --prod

# 3. Follow the prompts:
#    - Link to existing project? → Create new project
#    - Set project name
#    - Set root directory: (leave as .)
#    - Confirm deployment
```

### Option B: Using Vercel Web Dashboard
1. Go to https://vercel.com/dashboard
2. Click "New Project"
3. Select your GitHub repository
4. Click "Import"
5. Add Environment Variables (see Step 6)
6. Click "Deploy"

---

## 🔑 STEP 6: Set Environment Variables on Vercel

**Important:** These are set on Vercel Dashboard, NOT in your code!

1. Go to Vercel Project Settings → Environment Variables
2. Add these variables:

```
VITE_SUPABASE_URL     = https://your-project.supabase.co
VITE_SUPABASE_ANON_KEY = your-anon-key
GEMINI_API_KEY        = your-gemini-key (optional)
GAS_URL               = https://script.google.com/macros/s/YOUR_ID/exec
```

3. Click "Save"
4. Redeploy: Settings → Deployments → Latest → Redeploy

---

## ✅ STEP 7: Verify Deployment

After deployment:

1. **Check Vercel URL:** 
   - Vercel auto-generates: `https://ginza-industries-order-portal.vercel.app`
   - Verify page loads without errors

2. **Check Console (F12):**
   - No red errors
   - Should see: "✅ Processed 9653 items"
   - Should see: "✅ Fetched 205 customers"

3. **Test Form Submission:**
   - Fill form with test data
   - Click Submit
   - Check: Order saved to Supabase ✅
   - Check: Data sent to Google Sheet ✅

---

## ⚠️ COMMON DEPLOYMENT ERRORS & FIXES

### Error: "Build failed: Cannot find module"
**Fix:** Ensure `package.json` has all dependencies:
```bash
npm install
npm run build
```

### Error: "Environment variables not found"
**Fix:** Set them in Vercel Dashboard:
- Settings → Environment Variables
- Add all VITE_* and other variables

### Error: "dist folder not found"
**Fix:** Vercel tries to build. Check:
- `vercel.json` has `"outputDirectory": "dist"`
- `package.json` has `"build": "vite build"`
- No TypeScript errors: `npm run build`

### Error: "CORS error on Google Sheet submission"
**Fix:** Already handled! Use:
- Proxy URL: `https://your-vercel-app.vercel.app/api/proxy`
- Configure in app Settings

### Error: "Supabase connection fails"
**Fix:** Verify environment variables are set:
- VITE_SUPABASE_URL (correct format with .co domain)
- VITE_SUPABASE_ANON_KEY (full key, not truncated)

---

## 📊 Quick Checklist Before Uploading

- [ ] Created `vercel.json` ✅
- [ ] Updated `.gitignore` ✅
- [ ] Created `.env.example` with template
- [ ] No sensitive keys in source files
- [ ] All source files included (components/, services/)
- [ ] package.json and package-lock.json present
- [ ] README.md updated (optional)
- [ ] Local build works: `npm run build` → no errors
- [ ] No `node_modules/` in upload
- [ ] No `dist/` in upload
- [ ] No `.env.local` in upload

---

## 🎯 Files Summary by Purpose

| File/Folder | Purpose | GitHub | Vercel |
|---|---|---|---|
| App.tsx | Main component | ✅ | ✅ |
| index.tsx | Entry point | ✅ | ✅ |
| components/ | UI components | ✅ | ✅ |
| services/ | Business logic | ✅ | ✅ |
| api/proxy.js | Serverless proxy | ✅ | ✅ |
| package.json | Dependencies | ✅ | ✅ |
| .env.local | Secrets | ❌ | ❌ |
| .env.example | Template | ✅ | - |
| node_modules/ | Installed packages | ❌ | Auto |
| dist/ | Build output | ❌ | Auto |
| vercel.json | Deployment config | ✅ | ✅ |

---

## 📞 If You Still Get Errors

Check these in order:
1. `npm run build` works locally (no errors)
2. All environment variables set on Vercel
3. vercel.json exists and is correct
4. .gitignore excludes node_modules and dist
5. package.json has all dependencies

If issues persist, check Vercel Build Logs:
- Vercel Dashboard → Deployments → Click deployment → Logs

---

**✅ You're ready to deploy!** 

Share your Vercel link with friends:
```
https://ginza-industries-order-portal.vercel.app
```

NOT the localhost link!
