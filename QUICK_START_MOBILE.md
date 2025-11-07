# AGRITRACE Mobile App - Quick Start Guide

**Version:** 2.0.0 (Mobile-Only)  
**Last Updated:** November 7, 2025

## Overview

This is now a **mobile-only** project. The backend and frontend have been removed. All functionality is contained within the Flutter mobile application.

## Project Structure

```
agritracerw/
├── mobile/          # Flutter Mobile App (MAIN APPLICATION)
├── blockchain/      # Smart Contracts
├── screenshots/     # Documentation screenshots
└── *.md            # Documentation files
```

## Quick Setup

### 1. Prerequisites
- Flutter SDK 3.0+
- Android Studio or Xcode
- Git

### 2. Install & Run

```bash
cd mobile
flutter pub get
flutter run
```

### 3. Build APK

```bash
flutter build apk --release
```

APK will be at: `mobile/build/app/outputs/flutter-apk/app-release.apk`

## Key Documentation

| File | Description |
|------|-------------|
| `README.md` | Main project overview |
| `FLUTTER_MOBILE_GUIDE.md` | Comprehensive mobile app guide |
| `FLUTTER_INSTALLATION_GUIDE.md` | Detailed setup instructions |
| `DEPLOYMENT_GUIDE.md` | Deployment procedures |
| `MIGRATION_NOTES.md` | Details about backend/frontend removal |

## What Changed?

- ❌ Removed `/backend/` directory (Django REST API)
- ❌ Removed `/frontend/` directory (React PWA)
- ✅ Mobile app now uses **offline-first architecture**
- ✅ Local SQLite database for data storage
- ✅ Firebase integration for authentication & cloud storage
- ✅ Direct blockchain integration via Web3dart

## Mobile App Features

- 📱 Cross-platform (Android/iOS)
- 🔒 Blockchain integration for traceability
- 📷 QR code scanning
- 📡 Offline-first with auto-sync
- 🌍 Multi-language (English, Kinyarwanda, French)
- 🗺️ GPS tracking
- 💳 Mobile payments (MTN, Airtel)
- 🔐 Firebase authentication

## For Submission

This mobile-only architecture is ideal for:
- **APK deployment** to test users
- **Research demonstrations** (5-min video requirement)
- **Installation simplicity** (no backend setup needed)
- **Offline research environments** (works without server)

## Need Help?

1. Check `FLUTTER_MOBILE_GUIDE.md` for detailed documentation
2. Review `mobile/README.md` for app-specific details
3. See `MIGRATION_NOTES.md` for architecture changes

---

**Ready to build!** 🚀
```bash
cd mobile && flutter build apk --release
```
