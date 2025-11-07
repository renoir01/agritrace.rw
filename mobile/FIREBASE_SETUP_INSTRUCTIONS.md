# Firebase Setup for AgriTrace Mobile

## 🔥 Quick Setup Guide

### Step 1: Create Firebase Project

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Click **"Create a project"**
3. Project name: **`agritrace-rw`**
4. Enable Google Analytics (recommended)
5. Click **Create project**

---

### Step 2: Add Android App

1. Click **Android icon** to add an Android app
2. Fill in:
   - **Package name:** `rw.agritrace.app` ⚠️ MUST MATCH EXACTLY
   - **App nickname:** `AgriTrace Mobile`
   - **SHA-1:** Leave blank (can add later for release)
3. Click **Register app**

---

### Step 3: Download google-services.json

1. Download the `google-services.json` file
2. Place it at: `android/app/google-services.json`
3. **REPLACE** the existing file

---

### Step 4: Enable Firebase Services

#### Authentication
- Navigate to: **Build → Authentication**
- Click **Get started**
- Enable: **Email/Password** provider
- Save

#### Cloud Firestore
- Navigate to: **Build → Firestore Database**
- Click **Create database**
- Start mode: **Test mode** (for development)
- Location: **eur3 (europe-west)** or closest to Rwanda
- Click **Enable**

#### Cloud Storage
- Navigate to: **Build → Storage**
- Click **Get started**
- Start mode: **Test mode**
- Same location as Firestore
- Click **Done**

#### Cloud Messaging (FCM)
- Navigate to: **Build → Cloud Messaging**
- Should be auto-enabled
- No action needed

---

### Step 5: Update App Configuration

After downloading `google-services.json`, run:

```bash
cd E:\agritracerw\mobile

# Install FlutterFire CLI
dart pub global activate flutterfire_cli

# Configure Firebase (this will update firebase_options.dart)
flutterfire configure --project=agritrace-rw
```

**OR manually update `lib/firebase_options.dart` with values from Firebase Console:**
- Go to Project Settings → General
- Scroll to "Your apps" section
- Copy the configuration values

---

### Step 6: Set Up Firestore Security Rules

In Firebase Console → Firestore Database → Rules, use:

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // User profiles
    match /users/{userId} {
      allow read: if request.auth != null;
      allow write: if request.auth != null && request.auth.uid == userId;
    }
    
    // Cooperatives
    match /cooperatives/{docId} {
      allow read: if request.auth != null;
      allow write: if request.auth != null;
    }
    
    // Orders
    match /orders/{orderId} {
      allow read: if request.auth != null;
      allow write: if request.auth != null;
    }
    
    // Notifications
    match /notifications/{notifId} {
      allow read: if request.auth != null && resource.data.userId == request.auth.uid;
      allow write: if request.auth != null;
    }
    
    // Batches
    match /batches/{batchId} {
      allow read: if request.auth != null;
      allow write: if request.auth != null;
    }
    
    // Allow admin collection read/write for authenticated users
    match /admins/{adminId} {
      allow read: if request.auth != null;
      allow write: if false; // Only via Firebase Console
    }
  }
}
```

---

### Step 7: Set Up Storage Security Rules

In Firebase Console → Storage → Rules:

```javascript
rules_version = '2';
service firebase.storage {
  match /b/{bucket}/o {
    match /{allPaths=**} {
      allow read: if request.auth != null;
      allow write: if request.auth != null && request.resource.size < 5 * 1024 * 1024; // 5MB limit
    }
  }
}
```

---

### Step 8: Test the Setup

```bash
# Clean the project
flutter clean

# Get dependencies
flutter pub get

# Run the app
flutter run
```

---

## 🔧 Troubleshooting

### Issue: "google-services.json not found"
**Solution:** Make sure file is at `android/app/google-services.json`

### Issue: "Default Firebase app not initialized"
**Solution:** Run `flutterfire configure` to regenerate `firebase_options.dart`

### Issue: "Authentication failed"
**Solution:** Make sure Email/Password provider is enabled in Firebase Console

---

## 📊 Firebase Project Structure

Your Firestore collections:
- `users` - User profiles
- `cooperatives` - Farmer cooperatives
- `aggregators` - Trader/aggregator info
- `seed_producers` - Seed producer info
- `agro_dealers` - Agro-dealer info
- `institutions` - Schools/hospitals
- `consumers` - Consumer profiles
- `orders` - All orders
- `transactions` - Financial transactions
- `notifications` - Push notifications
- `batches` - Batch tracking
- `admins` - Admin users

---

## 🎯 Next Steps After Setup

1. Create admin user in Firestore Console
2. Test authentication flow
3. Test creating orders
4. Configure SMS (Africa's Talking)
5. Set up payment integrations (MTN/Airtel)

---

**Need help?** Check the main README.md or Firebase documentation.
