# 📋 VERCEL DEPLOYMENT - QUICK REFERENCE CARD

## Your Project Details:

```
GitHub Repo: https://github.com/task-delegate/order-form-multiple-location
Vercel Team: Tushar's projects
Project Name: order-form-multiple-location
```

---

## Environment Variables to Add in Vercel:

### Copy-Paste These EXACTLY:

**Variable 1:**
```
Name:  VITE_SUPABASE_URL
Value: https://qtctkhkykkwntecxgezs.supabase.co
```

**Variable 2:**
```
Name:  VITE_SUPABASE_ANON_KEY
Value: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InF0Y3RraGt5a2t3bnRlY3hnZXpzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjM2Mzc5MzEsImV4cCI6MjA3OTIxMzkzMX0.JYwNRCuadt34wvKpIwjQjvfkMVr73iCphMnZ3oc-xFM
```

**Variable 3:**
```
Name:  GEMINI_API_KEY
Value: AIzaSyCNBhSoKkehZSOuY3PtUMGj3O41ysBR8pA
```

**Variable 4:**
```
Name:  GAS_URL
Value: https://script.google.com/macros/s/AKfycby7hX97jGL2A5hJ4YhJu5STdOQa1rYQOI4jgKsteuN0FPDZuAYD4OoEXFSrEYtCqfbq5A/exec
```

---

## Build Settings:

```
Build Command:     npm run build
Output Directory:  dist
Framework:         Vite
```

---

## Expected Result After Deployment:

```
Your app will be live at:
https://order-form-multiple-location.vercel.app

(Or similar URL provided by Vercel)
```

---

## Deployment Steps (1-2-3):

1. Go to https://vercel.com/dashboard
2. Select "Tushar's projects" team
3. Click "Add New" → "Project"
4. Import: `task-delegate/order-form-multiple-location`
5. Configure with settings above
6. Add 4 environment variables
7. Click "Deploy"
8. Wait 2-5 minutes ✅

---

## After Deployment - Test It:

1. Open your Vercel URL
2. Press F12 → Console
3. Should see: ✅ "Processed 9653 items"
4. Fill test order
5. Submit
6. Check Supabase ✅
7. Check Google Sheet ✅

---

## If Something Goes Wrong:

Check Vercel Deployment Logs:
- Deployments tab
- Click failed deployment
- Scroll to see error details
- 99% of time: Wrong environment variable format

---

**Ready to deploy? Follow the steps above!** 🚀
