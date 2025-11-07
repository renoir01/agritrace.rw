import 'package:cloud_firestore/cloud_firestore.dart';
import 'location_model.dart';

class ConsumerModel {
  final String id;
  final String userId;
  final String consumerType; // 'individual', 'school', 'hospital', 'restaurant'
  final String? fullName; // For individual consumers
  final String? organizationName; // For institutional consumers
  final String? phoneNumber;
  final String? email;
  final LocationModel? location;
  final List<String> scannedProducts; // Batch IDs
  final List<String> trustedSellers; // Seller IDs
  final int totalScans;
  final double? ironIntakeGoal; // mg per day (for individuals)
  final bool notificationsEnabled;
  final String preferredLanguage; // 'en' or 'rw'
  final DateTime registrationDate;
  final DateTime? lastScanDate;
  // Institutional fields
  final String? registrationNumber;
  final int? numberOfBeneficiaries; // students/patients/customers
  final NutritionalRequirements? nutritionalRequirements;
  final ProcurementInfo? procurementInfo;

  ConsumerModel({
    required this.id,
    required this.userId,
    this.consumerType = 'individual',
    this.fullName,
    this.organizationName,
    this.phoneNumber,
    this.email,
    this.location,
    this.scannedProducts = const [],
    this.trustedSellers = const [],
    this.totalScans = 0,
    this.ironIntakeGoal,
    this.notificationsEnabled = true,
    this.preferredLanguage = 'en',
    required this.registrationDate,
    this.lastScanDate,
    this.registrationNumber,
    this.numberOfBeneficiaries,
    this.nutritionalRequirements,
    this.procurementInfo,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'consumerType': consumerType,
      if (fullName != null) 'fullName': fullName,
      if (organizationName != null) 'organizationName': organizationName,
      'phoneNumber': phoneNumber,
      'email': email,
      if (location != null) 'location': location!.toMap(),
      'scannedProducts': scannedProducts,
      'trustedSellers': trustedSellers,
      'totalScans': totalScans,
      if (ironIntakeGoal != null) 'ironIntakeGoal': ironIntakeGoal,
      'notificationsEnabled': notificationsEnabled,
      'preferredLanguage': preferredLanguage,
      'registrationDate': Timestamp.fromDate(registrationDate),
      if (lastScanDate != null) 'lastScanDate': Timestamp.fromDate(lastScanDate!),
      if (registrationNumber != null) 'registrationNumber': registrationNumber,
      if (numberOfBeneficiaries != null) 'numberOfBeneficiaries': numberOfBeneficiaries,
      if (nutritionalRequirements != null) 'nutritionalRequirements': nutritionalRequirements!.toMap(),
      if (procurementInfo != null) 'procurementInfo': procurementInfo!.toMap(),
    };
  }

  factory ConsumerModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ConsumerModel(
      id: doc.id,
      userId: data['userId'] ?? '',
      consumerType: data['consumerType'] ?? data['institutionType'] ?? 'individual', // backwards compatibility
      fullName: data['fullName'],
      organizationName: data['organizationName'] ?? data['institutionName'], // backwards compatibility
      phoneNumber: data['phoneNumber'],
      email: data['email'],
      location: data['location'] != null ? LocationModel.fromMap(data['location']) : null,
      scannedProducts: List<String>.from(data['scannedProducts'] ?? []),
      trustedSellers: List<String>.from(data['trustedSellers'] ?? []),
      totalScans: data['totalScans'] ?? 0,
      ironIntakeGoal: data['ironIntakeGoal']?.toDouble(),
      notificationsEnabled: data['notificationsEnabled'] ?? true,
      preferredLanguage: data['preferredLanguage'] ?? 'en',
      registrationDate: (data['registrationDate'] as Timestamp?)?.toDate() ?? (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      lastScanDate: data['lastScanDate'] != null
          ? (data['lastScanDate'] as Timestamp).toDate()
          : null,
      registrationNumber: data['registrationNumber'],
      numberOfBeneficiaries: data['numberOfBeneficiaries'],
      nutritionalRequirements: data['nutritionalRequirements'] != null
          ? NutritionalRequirements.fromMap(data['nutritionalRequirements'])
          : null,
      procurementInfo: data['procurementInfo'] != null
          ? ProcurementInfo.fromMap(data['procurementInfo'])
          : null,
    );
  }

  ConsumerModel copyWith({
    String? id,
    String? userId,
    String? consumerType,
    String? fullName,
    String? organizationName,
    String? phoneNumber,
    String? email,
    LocationModel? location,
    List<String>? scannedProducts,
    List<String>? trustedSellers,
    int? totalScans,
    double? ironIntakeGoal,
    bool? notificationsEnabled,
    String? preferredLanguage,
    DateTime? registrationDate,
    DateTime? lastScanDate,
    String? registrationNumber,
    int? numberOfBeneficiaries,
    NutritionalRequirements? nutritionalRequirements,
    ProcurementInfo? procurementInfo,
  }) {
    return ConsumerModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      consumerType: consumerType ?? this.consumerType,
      fullName: fullName ?? this.fullName,
      organizationName: organizationName ?? this.organizationName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      location: location ?? this.location,
      scannedProducts: scannedProducts ?? this.scannedProducts,
      trustedSellers: trustedSellers ?? this.trustedSellers,
      totalScans: totalScans ?? this.totalScans,
      ironIntakeGoal: ironIntakeGoal ?? this.ironIntakeGoal,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      preferredLanguage: preferredLanguage ?? this.preferredLanguage,
      registrationDate: registrationDate ?? this.registrationDate,
      lastScanDate: lastScanDate ?? this.lastScanDate,
      registrationNumber: registrationNumber ?? this.registrationNumber,
      numberOfBeneficiaries: numberOfBeneficiaries ?? this.numberOfBeneficiaries,
      nutritionalRequirements: nutritionalRequirements ?? this.nutritionalRequirements,
      procurementInfo: procurementInfo ?? this.procurementInfo,
    );
  }
}

// Supporting classes for institutional consumers
class NutritionalRequirements {
  final double monthlyBeanRequirement; // kg per month
  final bool requiresIronFortified;
  final String? specificVarietyPreference;
  final String? dietaryNotes;

  NutritionalRequirements({
    required this.monthlyBeanRequirement,
    required this.requiresIronFortified,
    this.specificVarietyPreference,
    this.dietaryNotes,
  });

  Map<String, dynamic> toMap() {
    return {
      'monthlyBeanRequirement': monthlyBeanRequirement,
      'requiresIronFortified': requiresIronFortified,
      if (specificVarietyPreference != null)
        'specificVarietyPreference': specificVarietyPreference,
      if (dietaryNotes != null) 'dietaryNotes': dietaryNotes,
    };
  }

  factory NutritionalRequirements.fromMap(Map<String, dynamic> map) {
    return NutritionalRequirements(
      monthlyBeanRequirement: map['monthlyBeanRequirement']?.toDouble() ?? 0.0,
      requiresIronFortified: map['requiresIronFortified'] ?? true,
      specificVarietyPreference: map['specificVarietyPreference'],
      dietaryNotes: map['dietaryNotes'],
    );
  }
}

class ProcurementInfo {
  final String budgetCycle; // quarterly, annually, etc.
  final double? budgetAmount;
  final String procurementMethod; // tender, direct purchase, etc.
  final String? preferredPaymentTerms;

  ProcurementInfo({
    required this.budgetCycle,
    this.budgetAmount,
    required this.procurementMethod,
    this.preferredPaymentTerms,
  });

  Map<String, dynamic> toMap() {
    return {
      'budgetCycle': budgetCycle,
      if (budgetAmount != null) 'budgetAmount': budgetAmount,
      'procurementMethod': procurementMethod,
      if (preferredPaymentTerms != null)
        'preferredPaymentTerms': preferredPaymentTerms,
    };
  }

  factory ProcurementInfo.fromMap(Map<String, dynamic> map) {
    return ProcurementInfo(
      budgetCycle: map['budgetCycle'] ?? '',
      budgetAmount: map['budgetAmount']?.toDouble(),
      procurementMethod: map['procurementMethod'] ?? '',
      preferredPaymentTerms: map['preferredPaymentTerms'],
    );
  }
}
