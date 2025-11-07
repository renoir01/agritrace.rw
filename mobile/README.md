# AgriTrace Mobile App 🌱📱

**Iron-Biofortified Beans Traceability System for Rwanda - Mobile Component**

[![Flutter](https://img.shields.io/badge/Flutter-3.5.4-blue.svg)](https://flutter.dev/)
[![Firebase](https://img.shields.io/badge/Firebase-Enabled-orange.svg)](https://firebase.google.com/)
[![License](https://img.shields.io/badge/License-Private-red.svg)]()
[![Progress](https://img.shields.io/badge/Progress-91%25-brightgreen.svg)]()

> *Tracing Nutrition from Seed to Table*  
> *Gukurikirana Intungamubiri kuva ku mbuto kugeza ku meza*

---

## 📖 Overview

This is the **mobile application component** of the **AgriTraceRW** platform. AgriTrace is designed to create transparency and traceability in the iron-biofortified beans supply chain in Rwanda. The system connects all actors from seed producers to institutional buyers (schools and hospitals), enabling verification of product authenticity and facilitating direct market linkages.

**📦 Part of AgriTraceRW Platform:**
- **Backend:** Django REST API (`../backend/`)
- **Web Frontend:** React/Vue Dashboard (`../frontend/`)
- **Mobile App:** Flutter (this directory)
- **Blockchain:** Supply chain verification (`../blockchain/`)

### 🎯 Key Features

- ✅ **Full Supply Chain Traceability** - Track beans from seed to table with QR codes
- ✅ **7 User Types** - Farmers, Traders, Consumers, Seed Producers, Agro-Dealers, Institutions, Admins
- ✅ **Bilingual Support** - Complete English & Kinyarwanda interface
- ✅ **Real-time Orders** - Direct market connections with live notifications
- ✅ **SMS & Push Notifications** - Order alerts, payment confirmations, status updates
- ✅ **QR Code Verification** - Scan and verify product authenticity instantly
- ✅ **PDF Certificates** - Generate and download traceability certificates
- ✅ **Mobile Money Integration** - MTN & Airtel Money payment processing
- ✅ **Batch Tracking** - Complete harvest-to-sale tracking with earnings dashboard
- ✅ **Admin Dashboard** - User verification, analytics, and system management

---

## 🚀 Quick Start

### Prerequisites

- Flutter SDK 3.5.4+
- Android Studio / VS Code
- Firebase account
- Android device or emulator

### Installation

```bash
# 1. Clone the AgriTraceRW repository
git clone https://github.com/yourusername/agritracerw.git
cd agritracerw

# 2. Navigate to mobile directory
cd mobile

# 3. Install Flutter dependencies
flutter pub get

# 4. Configure Firebase (REQUIRED)
# Download google-services.json from Firebase Console
# Place it in: android/app/google-services.json

# 5. Set up environment variables
# Copy .env.example to .env and configure
cp .env.example .env

# 6. Run the app
flutter run
```

### ⚠️ Important: Firebase Setup Required

**Before running the app, you MUST:**
1. Download `google-services.json` from Firebase Console
2. Place it in `android/app/` directory
3. Enable Firebase services (Authentication, Firestore, Storage)

**See:** `FIREBASE_SETUP_NEXT_STEPS.md` for detailed instructions

---

## 📁 Project Structure

```
lib/
├── l10n/                    # Internationalization
│   ├── app_en.arb          # English translations
│   └── app_rw.arb          # Kinyarwanda translations
├── models/                  # Data models
├── providers/               # State management
├── screens/                 # UI screens
├── services/                # Backend services
├── utils/                   # Utilities & constants
└── main.dart               # App entry point
```

---

## 👥 User Types (7 Complete Dashboards)

1. **🌱 Seed Producers** - Research institutions, seed companies (85% complete)
2. **🏪 Agro-Dealers** - Input suppliers, seed retailers (85% complete)
3. **👨‍🌾 Farmer Cooperatives** - Bean growers (95% complete)
4. **🚚 Traders/Aggregators** - Bulk collectors and traders (95% complete)
5. **🏥 Institutions** - Schools and hospitals (80% complete)
6. **🛒 Consumers** - End buyers, households (85% complete)
7. **👤 Administrators** - System managers, verifiers (75% complete)

---

## 🛠️ Technology Stack

### Frontend
- Flutter 3.5.4
- Dart 3.5.4
- Material Design 3
- Provider (State Management)

### Backend
- Firebase Authentication
- Cloud Firestore
- Firebase Cloud Storage
- Firebase Cloud Messaging
- Firebase Analytics

### Integrations
- **Firebase** - Authentication, Firestore, Cloud Storage, Cloud Messaging
- **Africa's Talking** - SMS notifications (Active)
- **Mobile Money** - MTN Mobile Money, Airtel Money (Integrated)
- **Google Maps API** - Location services (Planned)
- **Django Backend** - REST API integration with ../backend/ (Optional)

---

## 📱 Features by User Type

### For Farmers
- Register plantings
- Update harvest information
- List beans for sale
- Receive and respond to orders
- Track sales history

### For Aggregators
- Search farmers by location
- View on map
- Place orders
- Manage inventory
- Respond to institutional buyers

### For Institutions
- Post requirements
- Review aggregator bids
- Place orders
- Verify traceability
- Download receipts

### For Agro-Dealers
- Manage seed inventory
- Record sales
- Confirm farmer purchases

### For Seed Producers
- Manage authorized dealers
- View distribution reports
- Track seed movement

---

## 🌍 Internationalization

The app supports:
- 🇬🇧 **English** - Full interface
- 🇷🇼 **Kinyarwanda** - Full interface

Users can switch languages at any time from the settings.

---

## 📊 Current Status

**Version:** 1.0.0  
**Phase:** 2B - Advanced Features  
**Progress:** 91% Complete ✅  
**Status:** Production-Ready (Pilot Testing)

### ✅ Completed Features (91%)
- [x] Complete authentication system with 7 user types
- [x] QR code generation & scanning
- [x] PDF certificate generation
- [x] Batch tracking & traceability
- [x] Order management (farmer-to-trader, trader-to-institution)
- [x] SMS integration (Africa's Talking)
- [x] Real-time notifications
- [x] Financial dashboards (earnings tracking)
- [x] Inventory management
- [x] Supply chain visualization
- [x] Profile management for all user types
- [x] Payment integration (MTN, Airtel Mobile Money)
- [x] Admin user management & verification
- [x] Bilingual support (English & Kinyarwanda)

### 🔄 In Progress (6%)
- [ ] Consumer registration flow
- [ ] Photo upload system
- [ ] Direct farmer-to-consumer sales
- [ ] Advanced admin analytics

### 📅 Remaining (3%)
- [ ] Offline support
- [ ] Advanced fraud detection
- [ ] Performance optimization
- [ ] Final polish & testing

---

## 🔗 Integration with AgriTraceRW

This mobile app is designed to work **independently** with Firebase as the backend, but can also integrate with the Django backend:

### Standalone Mode (Current - Firebase)
```bash
# Uses Firebase for all backend operations
- Authentication via Firebase Auth
- Data storage in Firestore
- File storage in Firebase Storage
- Real-time updates via Firestore listeners
```

### Hybrid Mode (Optional - Django + Firebase)
```bash
# Can connect to Django backend for:
- Advanced analytics
- Web dashboard synchronization
- Admin management
- Research data collection
# See ../backend/README.md for API documentation
```

---

## 📚 Documentation

### In This Directory:
- **README.md** - This file (mobile app overview)
- **README_SETUP.md** - Detailed setup and configuration guide
- **FIREBASE_SETUP_NEXT_STEPS.md** - Firebase configuration steps
- **PROJECT_STATUS.md** - Detailed project status and progress
- **REMAINING_WORK.md** - What's left to complete (9%)

### Parent Project Docs:
- **../README.md** - AgriTraceRW platform overview
- **../backend/README.md** - Django backend documentation
- **../frontend/README.md** - Web frontend documentation
- **../DEPLOYMENT_GUIDE.md** - Full platform deployment

---

## 🧪 Testing

```bash
# Run tests
flutter test

# Run with coverage
flutter test --coverage

# Analyze code
flutter analyze
```

---

## 🤝 Contributing

This is a private project for Rwanda's agricultural supply chain. For contributions:

1. Follow Flutter best practices
2. Write clear commit messages
3. Add tests for new features
4. Update documentation

---

## 📄 License

Private - All rights reserved

---

## 📞 Support

For technical issues or questions:
- Review documentation in the project
- Check Firebase configuration
- Refer to technical specification document

---

## 🙏 Acknowledgments

- Rwanda Agriculture Board (RAB)
- HarvestPlus Rwanda
- Local farmer cooperatives
- Firebase team
- Flutter team

---

**Built with ❤️ for Rwanda's nutritional security**

*Powered by Flutter & Firebase*
