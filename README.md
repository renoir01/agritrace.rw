# AGRITRACE: Mobile Traceability Platform for Biofortified Crops

**BSc. in Software Engineering Project**  
**Author:** Renoir KAZE  
**Supervisor:** Neza David Tuyishimire  
**Date:** November 2025

## Overview

AGRITRACE is a mobile-first digital traceability platform designed to address authentication and supply chain transparency gaps for biofortified crops in Rwanda. The Flutter mobile application enables stakeholders to verify crop authenticity from seed to consumer while improving trust, reducing fraud, and maximizing the nutritional impact of biofortification programs.

## Problem Statement

Despite significant investments in biofortification programs, Rwanda faces critical challenges in ensuring the integrity and traceability of biofortified crops throughout the supply chain. AGRITRACE addresses the absence of a comprehensive mobile-based traceability system specifically designed for biofortified crops in smallholder farming contexts.

## Key Features

- **📱 Native Mobile App**: Flutter-based cross-platform application (Android/iOS)
- **🔒 Blockchain Integration**: Ethereum-based smart contracts for immutable record-keeping
- **📷 QR Code Verification**: Quick authentication of biofortified products with camera scanning
- **📡 Offline Functionality**: Works in areas with limited connectivity with automatic sync
- **🌍 Multi-Language Support**: English, Kinyarwanda, and French
- **🗺️ GPS Tracking**: Location-based supply chain tracking from seed to consumer
- **📊 Analytics Dashboard**: Comprehensive reporting and monitoring
- **🔐 Secure Authentication**: JWT-based authentication with Firebase integration
- **💳 Mobile Payments**: Integrated payment processing for transactions

## Technology Stack

### Mobile Application
- **Framework**: Flutter 3.x (Dart)
- **Architecture**: Clean Architecture with BLoC pattern
- **State Management**: Provider & BLoC
- **Database**: SQLite (local) with offline-first architecture
- **Backend Integration**: REST API with automatic retry & sync
- **Authentication**: Firebase Auth + JWT tokens
- **Payments**: Mobile Money integration (MTN, Airtel)
- **Maps**: Google Maps integration for GPS tracking
- **QR Code**: QR code scanner and generator
- **Notifications**: Firebase Cloud Messaging (FCM)

### Blockchain
- **Platform**: Ethereum (Sepolia Testnet)
- **Smart Contracts**: Solidity 0.8.x
- **Web3 Integration**: Web3dart library

## Project Structure

```
agritracerw/
├── mobile/                    # Flutter Mobile Application
│   ├── lib/
│   │   ├── main.dart         # App entry point
│   │   ├── config/           # App configuration
│   │   ├── core/             # Core utilities and constants
│   │   ├── models/           # Data models
│   │   ├── services/         # Business logic services
│   │   ├── screens/          # UI screens
│   │   ├── widgets/          # Reusable widgets
│   │   └── providers/        # State management
│   ├── android/              # Android-specific code
│   ├── ios/                  # iOS-specific code
│   └── test/                 # Unit and widget tests
├── blockchain/               # Smart contracts
│   ├── contracts/            # Solidity contracts
│   ├── migrations/           # Deployment scripts
│   └── test/                 # Contract tests
└── screenshots/              # App screenshots for documentation

```

## Target Users

1. **Farmers** (100 users): Register and track biofortified crop production
2. **Traders/Aggregators** (20 users): Verify authenticity and manage inventory
3. **Processors/Retailers** (25 users): Track supply chain and generate certificates
4. **Consumers** (50 users): Verify product authenticity via QR codes
5. **Administrators** (5 users): Monitor system and generate analytics

## Geographic Scope

**Pilot Region:** Musanze District, Northern Province, Rwanda
- Area: 530 km²
- Target: 2,000 smallholder farmers
- Cooperatives: 15
- Processing facilities: 5

## Development Timeline

| Phase | Activities | Duration |
|-------|-----------|----------|
| Phase 1 | Literature Review & Requirements | Week 1-2 |
| Phase 2 | System Design & Development | Week 3-7 |
| Phase 3 | Testing, Validation & Documentation | Week 8-12 |

## Installation & Setup

### Prerequisites

- **Flutter SDK**: 3.0.0 or higher
- **Dart SDK**: 2.17.0 or higher (included with Flutter)
- **Android Studio** or **Xcode** (for iOS)
- **Git**
- **Visual Studio Code** (recommended) with Flutter extensions

### Mobile App Setup

```bash
# Clone the repository
git clone https://github.com/yourusername/agritracerw.git
cd agritracerw/mobile

# Install Flutter dependencies
flutter pub get

# Check for any issues
flutter doctor

# Run on connected device or emulator
flutter run

# Or build APK for Android
flutter build apk --release

# Or build for iOS
flutter build ios --release
```

**APK Location:** `build/app/outputs/flutter-apk/app-release.apk`

### Configuration

Edit `lib/config/app_config.dart` to configure the backend API:

```dart
class AppConfig {
  static const String baseUrl = 'YOUR_BACKEND_URL/api/v1';
  static const String blockchainNetwork = 'sepolia';
  static const connectionTimeout = Duration(seconds: 30);
}
```

### Firebase Setup (Optional)

1. Create a Firebase project at [console.firebase.google.com](https://console.firebase.google.com)
2. Download `google-services.json` (Android) and place in `android/app/`
3. Download `GoogleService-Info.plist` (iOS) and place in `ios/Runner/`
4. Enable Firebase Authentication and Cloud Messaging

### Blockchain Setup

```bash
cd blockchain

# Install dependencies
npm install

# Compile smart contracts
truffle compile

# Deploy to Sepolia testnet
truffle migrate --network sepolia
```

## Testing

### Mobile App Tests

```bash
cd mobile

# Run unit tests
flutter test

# Run integration tests
flutter test integration_test/

# Run with coverage
flutter test --coverage
```

### Blockchain Tests

```bash
cd blockchain
truffle test
```

## Ethical Considerations

AGRITRACE implements comprehensive ethical safeguards:

- **Data Privacy**: AES-256 encryption, off-chain personal data storage
- **Informed Consent**: Multilingual consent forms (Kinyarwanda, English, French)
- **Digital Equity**: USSD support for feature phones, subsidized data costs
- **Gender Inclusion**: Partnerships with women's cooperatives
- **Fair Value Distribution**: Transparent pricing mechanisms

## Success Metrics

- **Fraud Reduction**: Target 75% reduction in counterfeit biofortified products
- **Supply Chain Transparency**: 90% traceability from farm to fork
- **Stakeholder Trust**: Measured through pre/post-implementation surveys
- **Platform Adoption**: 200 stakeholders across 5 user categories

## Contributing

This is an academic research project. For inquiries, please contact:
- **Author:** Renoir KAZE
- **Supervisor:** Neza David Tuyishimire

## License

This project is developed as part of a BSc. in Software Engineering program.

## References

See the full research proposal document for comprehensive references and literature review.

## Acknowledgments

- Rwanda Agriculture and Animal Resources Development Board (RAB)
- National Institute of Statistics of Rwanda (NISR)
- Smallholder farmers in Musanze District
- African Leadership University

---

**Version:** 2.0.0 (Mobile-Only)  
**Last Updated:** November 2025
