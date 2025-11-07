# Firebase Console - Quick Checklist

**Website:** https://console.firebase.google.com/

---

## ✅ Complete These in Order

### 1️⃣ CREATE PROJECT
- [ ] Go to Firebase Console
- [ ] Click "Add project"
- [ ] Name: `agritrace-rw`
- [ ] Create project

### 2️⃣ ADD ANDROID APP
- [ ] Click ⚙️ → Project Settings
- [ ] Click Android icon
- [ ] Package name: `rw.agritrace.app` ⚠️ MUST BE EXACT
- [ ] Register app
- [ ] Download `google-services.json`
- [ ] Replace file: `mobile/android/app/google-services.json`

### 3️⃣ ENABLE AUTHENTICATION
- [ ] Left menu → Authentication
- [ ] Click "Get started"
- [ ] Sign-in method tab
- [ ] Enable "Email/Password"
- [ ] Save

### 4️⃣ CREATE FIRESTORE DATABASE
- [ ] Left menu → Firestore Database
- [ ] Click "Create database"
- [ ] Production mode → Next
- [ ] Location: `europe-west1` → Enable
- [ ] Wait for creation

### 5️⃣ ADD FIRESTORE RULES
- [ ] Click "Rules" tab
- [ ] Copy rules from `FIREBASE_CONSOLE_SETUP.md`
- [ ] Paste and Publish

### 6️⃣ CREATE ADMIN USER (CRITICAL!)
- [ ] In Firestore → Data tab
- [ ] Click "+ Start collection"
- [ ] Collection ID: `admins`
- [ ] Document ID: `admin`
- [ ] Add these fields:
  ```
  email (string): admin@agritrace.rw
  password (string): admin123
  role (string): admin
  name (string): System Admin
  isActive (boolean): true
  createdAt (timestamp): now
  ```
- [ ] Save

### 7️⃣ ENABLE STORAGE
- [ ] Left menu → Storage
- [ ] Get started
- [ ] Production mode → Next
- [ ] Same location as Firestore → Done
- [ ] Rules tab → Add rules → Publish

### 8️⃣ TEST YOUR APP
```bash
cd mobile
flutter clean
flutter pub get
flutter run
```

**Look for:** ✅ `Firebase initialized successfully`

---

## 🚨 Common Issues

**"No admin documents found"**
→ Go back to Step 6, create admin document

**"Permission denied"**
→ Check Firestore rules in Step 5

**"google-services.json not found"**
→ Re-download from Firebase Console, replace file

---

## 📧 Default Admin Login

After setup, login with:
- **Email:** `admin@agritrace.rw`
- **Password:** `admin123`

**Change this password immediately after first login!**
