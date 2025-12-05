# Deploy करने के लिए सबसे आसान Platforms

## सारे Platforms की तुलना:

| Platform | Environment Variables | Setup | Free Tier | Speed |
|----------|----------------------|-------|-----------|-------|
| **Vercel** | ❌ Dashboard में manually add करना पड़ता है | कठिन | ✓ अच्छा | बहुत तेज़ |
| **Netlify** | ❌ Dashboard में manually add करना पड़ता है | कठिन | ✓ अच्छा | तेज़ |
| **Railway** | ✓ `.env` file से automatic | आसान | ✗ Limited | अच्छा |
| **Render** | ✓ `.env` file से automatic | आसान | ✓ अच्छा | अच्छा |
| **Fly.io** | ✓ `.env` file से automatic | आसान | ✗ Limited | बहुत तेज़ |
| **Heroku** | ❌ Dashboard में manually add | कठिन | ✗ (paid) | ठीक है |

---

# Platform 1: Railway.app (सबसे आसान) ⭐⭐⭐

## फायदे:
- `.env` file से automatic environment variables लेता है
- GitHub से direct connect
- Free tier अच्छा है

## Steps:

### Step 1: Railway Account बनाएं
1. https://railway.app खोलें
2. **"Start Project"** क्लिक करें
3. **GitHub से login करें**

### Step 2: Project Create करें
1. **"New Project"** क्लिक करें
2. **"Deploy from GitHub repo"** चुनें
3. अपना repo **order-form-multiple-location** select करें
4. **"Deploy"** क्लिक करें

### Step 3: Environment Variables Add करें
1. Project dashboard में जाएं
2. **"Variables"** टैब खोलें
3. **"Add variable"** क्लिक करें
4. आपके `.env` file से copy-paste करें:

```
VITE_SUPABASE_URL=https://qtctkhkykkwntecxgezs.supabase.co
VITE_SUPABASE_ANON_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InF0Y3RraGt5a2t3bnRlY3hnZXpzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjM2Mzc5MzEsImV4cCI6MjA3OTIxMzkzMX0.JYwNRCuadt34wvKpIwjQjvfkMVr73iCphMnZ3oc-xFM
VITE_GEMINI_API_KEY=AIzaSyCNBhSoKkehZSOuY3PtUMGj3O41ysBR8pA
```

### Step 4: Deploy होगा automatically
- Railway automatically देख लेगा कि Vite project है
- Build करेगा
- 3-5 minutes में live हो जाएगा

### Your Live URL:
```
https://<your-project-name>.railway.app
```

---

# Platform 2: Render.com (बहुत आसान) ⭐⭐⭐

## फायदे:
- Environment variables automatically `.env` से
- बिना config सबसे आसान
- Free tier अच्छा

## Steps:

### Step 1: Render Account बनाएं
1. https://render.com खोलें
2. **"GitHub से sign up"** करें

### Step 2: Static Site Deploy करें
1. Dashboard पर **"New +"** क्लिक करें
2. **"Static Site"** चुनें
3. अपना GitHub repo select करें

### Step 3: Build Settings:
```
Build Command: npm run build
Publish directory: dist
```

### Step 4: Environment Variables
Dashboard में **"Environment"** टैब से add करें:
```
VITE_SUPABASE_URL=https://qtctkhkykkwntecxgezs.supabase.co
VITE_SUPABASE_ANON_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InF0Y3RraGt5a2t3bnRlY3hnZXpzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjM2Mzc5MzEsImV4cCI6MjA3OTIxMzkzMX0.JYwNRCuadt34wvKpIwjQjvfkMVr73iCphMnZ3oc-xFM
VITE_GEMINI_API_KEY=AIzaSyCNBhSoKkehZSOuY3PtUMGj3O41ysBR8pA
```

### Step 5: Deploy
1. **"Deploy"** बटन क्लिक करें
2. 2-3 minutes में live हो जाएगा

---

# Platform 3: GitHub Pages (सबसे फ्री) ⭐⭐

## फायदे:
- बिल्कुल फ्री
- GitHub से automatic
- कोई environment variables की चिंता नहीं (client-side values)

## Steps:

### Step 1: `vite.config.ts` में एक line add करें:
```typescript
export default defineConfig(({ mode }) => {
    return {
      base: '/order-form-multiple-location/',  // ← यह line add करें
      // बाकी सब same रहेगा
```

### Step 2: `.github/workflows/deploy.yml` file बनाएं:

```yaml
name: Deploy to GitHub Pages

on:
  push:
    branches:
      - main

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: actions/setup-node@v3
        with:
          node-version: '18'
      
      - run: npm install
      - run: npm run build
      
      - uses: peaceiris/actions-gh-pages@v3
        with:
          github_token: ${{ secrets.GITHUB_TOKEN }}
          publish_dir: ./dist
```

### Step 3: GitHub Settings
1. Repository → **Settings**
2. **Pages** → **Source**: Deploy from a branch
3. Branch: **gh-pages**, folder: **/(root)**
4. **Save**

### Your Live URL:
```
https://task-delegate.github.io/order-form-multiple-location/
```

---

# Vercel (अगर आप फिर भी use करना चाहते हो) 

अगर Vercel ही use करना है तो एक बार ये try करें:

### Option: Vercel CLI से
```bash
# Install करें
npm install -g vercel

# Login करें
vercel login

# Vercel को पूछेगा - environment variables add करो
# उसमें अपनी keys add करें

# Deploy करो
vercel deploy --prod
```

---

## मैं कौन सा recommend करूँ?

### सबसे आसान: **Railway.app** ✓
- GitHub connect करो
- 2 मिनट में ready
- सबसे कम headache

### अगर बिल्कुल फ्री चाहिए: **GitHub Pages** ✓
- सबसे सस्ता option
- सिर्फ static files के लिए

### सबसे reliable: **Render.com** ✓
- Dashboard interface अच्छा है
- Environment variables आसान

---

## Next Steps:

**Main recommendation: Railway.app use करो**

1. https://railway.app जाओ
2. GitHub से signup करो
3. अपना repo connect करो
4. Environment variables add करो
5. Deploy होगा automatically

**कौन सा platform use करना है बताओ, मैं और detailed steps दूँगा!** 🚀
