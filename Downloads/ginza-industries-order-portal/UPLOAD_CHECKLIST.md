# 🚀 QUICK UPLOAD CHECKLIST

## Before you upload to GitHub, verify these files exist:

### ✅ Configuration Files
- [ ] `package.json` - Dependencies list
- [ ] `package-lock.json` - Locked versions
- [ ] `tsconfig.json` - TypeScript config
- [ ] `vite.config.ts` - Build config
- [ ] `vercel.json` - Deployment config (NEWLY CREATED)
- [ ] `.gitignore` - Exclude rules (UPDATED)
- [ ] `.env.example` - Template for secrets (UPDATED)

### ✅ Source Code Files
- [ ] `App.tsx` - Main component
- [ ] `index.tsx` - Entry point
- [ ] `index.html` - HTML template
- [ ] `constants.ts` - Configuration
- [ ] `types.ts` - TypeScript types
- [ ] `supabaseClient.ts` - Database client

### ✅ Folders
- [ ] `components/` folder with:
  - [ ] `Button.tsx`
  - [ ] `Input.tsx`
- [ ] `services/` folder with:
  - [ ] `geminiService.ts`
  - [ ] `sheetService.ts`
  - [ ] `supabaseService.ts`
- [ ] `api/` folder with:
  - [ ] `proxy.js`

### ✅ Metadata Files
- [ ] `manifest.json` - PWA manifest
- [ ] `metadata.json` - App metadata
- [ ] `README.md` - Project documentation (KEEP THIS ONLY)

### ❌ These should NOT be uploaded
- [ ] `node_modules/` - Automatically installed
- [ ] `dist/` - Built automatically
- [ ] `.env.local` - Contains your secrets
- [ ] `New folder/` - Temporary
- [ ] `.md` documentation (except README.md)

---

## Git Commands to Upload

```powershell
# 1. Initialize Git (first time only)
git init

# 2. Add all files
git add .

# 3. Check what will be uploaded
git status

# 4. Commit with message
git commit -m "Initial commit: Ginza Industries Order Portal"

# 5. Rename branch to main (if needed)
git branch -M main

# 6. Add GitHub remote
git remote add origin https://github.com/YOUR_USERNAME/ginza-industries-order-portal.git

# 7. Push to GitHub
git push -u origin main
```

---

## After Upload to GitHub

1. Go to https://vercel.com/dashboard
2. Click "New Project"
3. Select your GitHub repository
4. Add Environment Variables:
   - VITE_SUPABASE_URL
   - VITE_SUPABASE_ANON_KEY
   - GEMINI_API_KEY
   - GAS_URL
5. Click "Deploy"

---

## Test Deployment

After Vercel deployment:
1. Open your Vercel URL
2. Open Browser Console (F12)
3. Check for:
   - ✅ "Processed 9653 items"
   - ✅ "Fetched 205 customers"
4. Test form submission
5. Check Google Sheet for new row

---

**Everything is ready! Just push to GitHub now!**
