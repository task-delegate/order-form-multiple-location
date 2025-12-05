# Flutter App Setup and Build Guide

## ✅ Complete Flutter App Created!

Your Flutter app has been created with all the same functionality as the web version:

### Features Included:
✓ Same UI/UX as React version  
✓ Supabase authentication  
✓ Supabase database integration  
✓ Gemini AI integration  
✓ Google Sheets export  
✓ Mobile-optimized interface  
✓ Desktop support (Windows, Mac, Linux)  
✓ Responsive design  

---

## 🚀 Setup और Build करने के लिए:

### Step 1: Flutter Install करो
```bash
# Windows पर (अगर पहले से नहीं है)
# Download: https://flutter.dev/docs/get-started/install/windows

# Check करो
flutter --version
```

### Step 2: Project Setup करो
```bash
cd flutter_app

# Dependencies install करो
flutter pub get

# Code generation करो (JSON serialization के लिए)
flutter pub run build_runner build --delete-conflicting-outputs
```

### Step 3: Android APK Build करो
```bash
# Release APK बनाओ
flutter build apk --release

# Output location:
# build/app/outputs/flutter-apk/app-release.apk
```

### Step 4: iOS IPA Build करो (Mac की ज़रूरत है)
```bash
flutter build ios --release
```

### Step 5: Windows Desktop App बनाओ
```bash
flutter build windows --release
```

---

## 📱 Run करने के लिए (Development):

### Android Emulator पर:
```bash
flutter emulators --launch <emulator_id>
flutter run
```

### iOS Simulator पर (Mac):
```bash
open -a Simulator
flutter run
```

### Desktop पर (Windows):
```bash
flutter run -d windows
```

---

## 📦 Production Release के लिए:

### Google Play Store पर Upload करो:

1. **App signing key generate करो:**
```bash
keytool -genkey -v -keystore ~/ginza_key.jks \
  -keyalg RSA -keysize 2048 -validity 10000 \
  -alias ginza_key
```

2. **Build signed APK:**
```bash
flutter build apk --release
```

3. **Google Play Console पर upload करो:**
   - https://play.google.com/console
   - Create new app
   - Upload APK

### App Store पर Upload करो (Mac):
```bash
flutter build ios --release
# फिर Xcode से upload करो
```

---

## ⚙️ Configuration:

### Environment Variables (.env file):
```
SUPABASE_URL=https://qtctkhkykkwntecxgezs.supabase.co
SUPABASE_ANON_KEY=eyJhbGc...
GEMINI_API_KEY=AIzaSyCNB...
GAS_URL=https://script.google.com/macros/s/.../exec
```

### Update करने के लिए:
```bash
# .env file को edit करो
# फिर से build करो
```

---

## 📱 Features:

### ✅ Mobile App Features:
- Login/Register
- Branch & Sales Person selection
- Customer order form
- Dynamic item addition
- Real-time calculation
- Supabase sync
- Google Sheets export
- Offline support (caching)

### ✅ Desktop Features:
- Full responsive UI
- Keyboard shortcuts
- Print support
- PDF export

---

## 🔧 Common Commands:

```bash
# Run app
flutter run

# Build APK
flutter build apk --release

# Build iOS
flutter build ios --release

# Build Windows
flutter build windows --release

# Clean build
flutter clean
flutter pub get
flutter run

# Check flutter info
flutter doctor

# Generate code
flutter pub run build_runner build

# Test करो
flutter test
```

---

## 📊 File Structure:

```
flutter_app/
├── lib/
│   ├── main.dart                 # App entry point
│   ├── models/
│   │   ├── order_model.dart      # Data models
│   │   └── constants.dart        # Constants
│   ├── screens/
│   │   ├── login_screen.dart     # Login/Register
│   │   └── order_form_screen.dart # Main form
│   ├── services/
│   │   ├── supabase_service.dart # Database
│   │   ├── gemini_service.dart   # AI integration
│   │   └── google_sheets_service.dart # Google Sheets
│   └── widgets/
│       └── order_item_widget.dart # Item form
├── pubspec.yaml                   # Dependencies
└── .env                           # Environment config
```

---

## 🚀 Quick Start:

```bash
# 1. Setup करो
cd flutter_app
flutter pub get

# 2. Local test करो
flutter run -d chrome  # Web demo
# या
flutter run           # Android

# 3. APK build करो
flutter build apk --release

# 4. Install करो
adb install build/app/outputs/flutter-apk/app-release.apk
```

---

## 📝 Next Steps:

1. **Flutter install करो** (अगर पहले से नहीं है)
2. **flutter pub get करो**
3. **flutter run करो** development के लिए
4. **flutter build apk --release** करो production के लिए
5. Google Play Store पर upload करो

---

## ⚠️ Important Notes:

- Same logic और functionality as React version
- Mobile + Desktop दोनों पर चलेगा
- All integrations (Supabase, Gemini, Google Sheets) काम करेंगे
- Offline caching support included
- Responsive design (mobile, tablet, desktop)

---

## 🆘 Troubleshooting:

```bash
# अगर error आए:
flutter doctor          # Check setup
flutter clean           # Clean build
flutter pub get         # Reinstall deps
flutter run -v         # Verbose output

# Java path issue (Windows):
flutter doctor --android-licenses  # Accept licenses
```

---

**सब ready है! अब setup करो और build करो!** 🚀
