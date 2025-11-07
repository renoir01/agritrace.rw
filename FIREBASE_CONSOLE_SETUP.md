# Firebase Console Setup Guide

**Issue:** Firebase project needs to be properly configured in Firebase Console

**Firebase Console:** https://console.firebase.google.com/

---

## 🎯 Quick Firebase Console Checklist

### ☐ Step 1: Create/Verify Firebase Project (5 min)

1. Go to https://console.firebase.google.com/
2. Sign in with Google account
3. **Option A: Create New Project**
   - Click "+ Add project"
   - Name: `agritrace-rw` (or your preferred name)
   - Enable/Disable Google Analytics (your choice)
   - Click "Create project"

   **Option B: Use Existing Project**
   - Click on your existing project
   - Note the Project ID (you'll need this)

---

### ☐ Step 2: Register Android App (10 min)

1. In your Firebase project, click ⚙️ (Project Settings)
2. Scroll to "Your apps" section
3. Click **Android icon** (or "Add app" if you already have apps)
4. **Critical:** Android package name: `rw.agritrace.app`
5. App nickname: `AgriTrace Mobile` (optional)
6. Click "Register app"
7. **Download `google-services.json`**
8. Replace your file: `mobile/android/app/google-services.json`
9. Click "Next" → "Next" → "Continue to console"

---

### ☐ Step 3: Enable Authentication (5 min)

1. **Left sidebar** → Click "🔐 Authentication"
2. Click "Get started" (if first time)
3. Go to "Sign-in method" tab
4. **Enable these methods:**

   **Email/Password:**
   - Click on "Email/Password"
   - Toggle "Enable" → ON
   - Click "Save"

   **Phone (Optional):**
   - Click on "Phone"
   - Toggle "Enable" → ON
   - Click "Save"

   **Google Sign-In (Optional):**
   - Click on "Google"
   - Toggle "Enable" → ON
   - Enter support email
   - Click "Save"

---

### ☐ Step 4: Create Firestore Database (10 min)

1. **Left sidebar** → Click "🔥 Firestore Database"
2. Click "Create database"
3. **Select mode:**
   - Start in **production mode** (we'll add rules next)
   - Click "Next"
4. **Select location:**
   - Choose: `europe-west1` (closest to Rwanda)
   - Or: `us-central1` (default)
   - Click "Enable"
5. **Wait for database creation** (~1 minute)

#### Add Security Rules:
1. Click "Rules" tab at the top
2. Replace ALL content with this:

```
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Users collection
    match /users/{userId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
      allow read: if request.auth != null;
    }
    
    // Products collection
    match /products/{productId} {
      allow read: if request.auth != null;
      allow create: if request.auth != null;
      allow update, delete: if request.auth != null;
    }
    
    // Transactions collection
    match /transactions/{transactionId} {
      allow read, write: if request.auth != null;
    }
    
    // Admins collection
    match /admins/{adminId} {
      allow read: if request.auth != null;
    }
    
    // Batches collection
    match /batches/{batchId} {
      allow read, write: if request.auth != null;
    }
  }
}
```

3. Click "Publish"

---

### ☐ Step 5: Create Admin Document (IMPORTANT - 5 min)

Your app needs an admin user to log in!

1. Stay in **Firestore Database**
2. Click "Data" tab
3. Click "+ Start collection"
4. **Collection ID:** `admins`
5. Click "Next"
6. **Document ID:** `admin` (or any ID)
7. **Add fields:**

   | Field | Type | Value |
   |-------|------|-------|
   | email | string | `admin@agritrace.rw` |
   | password | string | `admin123` |
   | role | string | `admin` |
   | name | string | `System Admin` |
   | isActive | boolean | `true` |
   | createdAt | timestamp | (click "timestamp" then use current time) |

8. Click "Save"

**Note:** Change this password after first login!

---

### ☐ Step 6: Enable Storage (5 min)

1. **Left sidebar** → Click "💾 Storage"
2. Click "Get started"
3. **Security rules:** Start in **production mode**
4. Click "Next"
5. **Location:** Same as Firestore (e.g., `europe-west1`)
6. Click "Done"

#### Add Storage Rules:
1. Click "Rules" tab
2. Replace content with:

```
rules_version = '2';
service firebase.storage {
  match /b/{bucket}/o {
    match /{allPaths=**} {
      allow read: if request.auth != null;
      allow write: if request.auth != null;
    }
  }
}
```

3. Click "Publish"

---

### ☐ Step 7: Enable Cloud Messaging (Optional - 2 min)

1. **Left sidebar** → Click "☁️ Cloud Messaging"
2. Cloud Messaging is automatically enabled
3. No additional setup needed for basic push notifications

---

### ☐ Step 8: Get Your Configuration (CRITICAL)

#### Option A: Use FlutterFire CLI (Recommended)

```bash
# Install FlutterFire CLI
dart pub global activate flutterfire_cli

# Navigate to mobile directory
cd mobile

# Configure Firebase
flutterfire configure
```

This will:
- ✅ Auto-detect your Firebase projects
- ✅ Select platforms (Android/iOS)
- ✅ Generate `firebase_options.dart` with REAL credentials
- ✅ Update `google-services.json` automatically

#### Option B: Manual Update

If you don't want to use FlutterFire CLI:

1. Go to **Project Settings** (⚙️ icon)
2. Scroll to "Your apps" section
3. Find your Android app
4. Copy the configuration values
5. Update `mobile/lib/firebase_options.dart` with real values

---

## 🧪 Step 9: Test Firebase Connection (5 min)

After setup, test your configuration:

```bash
cd mobile

# Clean previous builds
flutter clean

# Get dependencies
flutter pub get

# Run the app
flutter run
```

**Check console output for:**
- ✅ `Firebase initialized successfully`
- ✅ `Total documents in admins collection: 1` (or more)
- ❌ Any Firebase errors

---

## 🔍 Troubleshooting

### Issue: "No documents found in admins collection"
**Solution:** Go back to Step 5 and create the admin document

### Issue: "Firebase initialization error"
**Solution:** 
- Re-download `google-services.json` from Firebase Console
- Replace `mobile/android/app/google-services.json`
- Run `flutter clean` and `flutter pub get`

### Issue: "Permission denied" errors
**Solution:** Check Firestore Security Rules in Step 4

### Issue: "google-services.json not found"
**Solution:**
- Download from Firebase Console → Project Settings → Your apps
- Place in exact location: `mobile/android/app/google-services.json`

---

## ✅ Verification Checklist

After completing all steps, verify:

- [ ] Firebase project created
- [ ] Android app registered with package name `rw.agritrace.app`
- [ ] `google-services.json` downloaded and replaced
- [ ] Authentication enabled (Email/Password at minimum)
- [ ] Firestore Database created
- [ ] Firestore Security Rules published
- [ ] Admin document created in `admins` collection
- [ ] Storage enabled
- [ ] App runs without Firebase errors

---

## 📱 Next Steps

Once Firebase is configured:

1. **Run the app:**
   ```bash
   cd mobile
   flutter run
   ```

2. **Login as admin:**
   - Email: `admin@agritrace.rw`
   - Password: `admin123`

3. **Change admin password** in app settings

4. **Start testing** app features!

---

**Need Help?** Check the console output when running `flutter run` - it will show Firebase initialization status and any errors.
