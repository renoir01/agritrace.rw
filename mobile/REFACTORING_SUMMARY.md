# 🔄 User Type Refactoring Summary

## Overview

Major refactoring to simplify user types from 7 to 5 by consolidating:
- **Cooperative → Farmer**
- **Institution → Consumer** (merged with existing Consumer type)

---

## ✅ Completed Changes

### 1. **Constants Updated** (`lib/utils/constants.dart`)
- ✅ Removed `cooperativesCollection`, added `farmersCollection`
- ✅ Removed `institutionsCollection` 
- ✅ Removed `cooperativeType` and `institutionType`
- ✅ Added consumer sub-types: `individualConsumerType`, `schoolConsumerType`, `hospitalConsumerType`, `restaurantConsumerType`

### 2. **Models Created/Updated**

#### ✅ `lib/models/farmer_model.dart` (NEW)
**Renamed from**: `cooperative_model.dart`

**Key Changes**:
- `CooperativeModel` → `FarmerModel`
- `cooperativeName` → `farmerName`
- Backwards compatibility: reads old `cooperativeName` field
- All supporting classes maintained: `AgroDealerPurchase`, `PlantingInfo`, `HarvestInfo`

#### ✅ `lib/models/consumer_model.dart` (ENHANCED)
**Merged**: Individual consumers + Institutional consumers (schools, hospitals)

**New Fields Added**:
- `consumerType` - 'individual', 'school', 'hospital', 'restaurant'
- `organizationName` - For institutional consumers
- `registrationNumber` - For institutions
- `numberOfBeneficiaries` - students/patients/customers
- `nutritionalRequirements` - Monthly requirements, iron needs
- `procurementInfo` - Budget cycles, procurement methods

**Backwards Compatibility**:
- Reads old `institutionType` → `consumerType`
- Reads old `institutionName` → `organizationName`
- Reads old `createdAt` → `registrationDate`

**Supporting Classes Added**:
- `NutritionalRequirements` - For institutional nutrition needs
- `ProcurementInfo` - For institutional procurement data

---

## 📋 Remaining Work (500+ References)

### Phase 1: Service Layer (HIGH PRIORITY)
**Files to Update**: 3 major service files

1. ✅ `lib/services/firestore_service.dart` (34 cooperative refs, 26 institution refs)
   - Replace all `getCooperative*` → `getFarmer*`
   - Replace all `cooperativesCollection` → `farmersCollection`
   - Replace all `getInstitution*` → `getConsumer*` (institutional)
   - Merge institution methods into consumer methods with type parameter

2. `lib/services/database_service.dart` (12 cooperative refs)
   - Update CRUD operations for farmers
   - Update queries

3. `lib/services/pdf_service.dart` (8 cooperative refs, 9 institution refs)
   - Update certificate generation
   - Update model references

4. `lib/services/sms_service.dart` (7 cooperative refs)
   - Update notification templates

5. `lib/services/notification_service.dart` (6 cooperative refs)
   - Update notification messages

### Phase 2: Screen Updates (MEDIUM PRIORITY)
**Files to Update**: 40+ screen files

#### Farmer Screens (was Cooperative)
- `lib/screens/farmer/harvest_management_screen.dart` (35 refs)
- `lib/screens/farmer/update_harvest_screen.dart` (27 refs)
- `lib/screens/farmer/register_planting_screen.dart` (18 refs)
- `lib/screens/farmer/batch_qr_screen.dart` (21 refs)
- `lib/screens/farmer/batch_tracking_screen.dart`
- `lib/screens/profile/cooperative_profile_screen.dart` → RENAME to `farmer_profile_screen.dart` (19 refs)
- `lib/screens/orders/farmer_orders_screen.dart` (7 refs)

#### Consumer Screens (merge individual + institutional)
- `lib/screens/consumer/consumer_dashboard_screen.dart` - Add institutional features
- `lib/screens/profile/institution_profile_screen.dart` → MERGE into consumer profile (28 refs)
- `lib/screens/institution_dashboard_screen.dart` → MERGE into consumer dashboard (5 refs)
- `lib/screens/orders/institution_orders_screen.dart` → Update for consumer (3 refs)
- `lib/screens/orders/place_institution_order_screen.dart` → Update for consumer (9 refs)
- `lib/screens/orders/browse_aggregators_screen.dart` (2 refs)

#### Order & Traceability Screens
- `lib/screens/orders/find_farmers_screen.dart` (25 refs) - Update search
- `lib/screens/orders/place_order_screen.dart` (16 refs)
- `lib/screens/orders/order_details_screen.dart` (3 refs)
- `lib/screens/traceability/traceability_chain_screen.dart` (14 cooperative, 15 institution refs)
- `lib/screens/traceability/verify_traceability_screen.dart`

#### Other Screens
- `lib/screens/agro_dealer/agro_dealer_sales_screen.dart` (39 refs)
- `lib/screens/trader/record_purchase_screen.dart` (3 refs)
- `lib/screens/trader/supplier_management_screen.dart`
- `lib/screens/admin/user_management_screen.dart` (6 cooperative, 7 institution refs)
- `lib/screens/admin/analytics_screen.dart` (3 refs)
- `lib/screens/admin/admin_dashboard_screen.dart` (2 refs each)
- `lib/screens/dashboard_screen.dart` (3 cooperative, 9 institution refs)
- `lib/screens/register_screen.dart` (4 cooperative, 8 institution refs)
- `lib/screens/user_type_selection_screen.dart` (2 each)
- `lib/screens/splash_screen.dart` (2 each, 6 institution refs)

### Phase 3: Localization (MEDIUM PRIORITY)
**Files to Update**: 4 localization files

1. `lib/l10n/app_en.arb` (3 cooperative, 4 institution refs)
   - Update English translations
   - `cooperative` → `farmer`
   - `institution` → `consumer` (institutional)

2. `lib/l10n/app_rw.arb` (2 cooperative, 2 institution refs)
   - Update Kinyarwanda translations
   - Maintain cultural appropriateness

3. `lib/utils/app_localizations.dart` (2 refs each)
   - Update localization keys

### Phase 4: Supporting Files (LOW PRIORITY)
**Files to Update**: Miscellaneous files

1. `lib/models/batch_model.dart` (7 refs)
   - `farmerId` field (already uses this!)
   - Update `cooperativeName` → `farmerName`

2. `lib/models/aggregator_model.dart` (18 refs)
   - Update supplier references

3. `lib/models/order_model.dart`
   - Update buyer/seller type references

4. `lib/models/agro_dealer_sale_model.dart` (2 refs)
5. `lib/models/seed_distribution_model.dart` (2 refs)
6. `lib/models/inventory_model.dart` (1 ref)
7. `lib/utils/pdf_generator.dart` (2 refs)

### Phase 5: Dashboard Screens
**Files to Rename/Update**:
- `lib/screens/institution_dashboard_screen.dart` → Merge into enhanced `consumer_dashboard_screen.dart`
- Add institutional features to consumer dashboard
- Show appropriate UI based on `consumerType`

---

## 🔍 Search & Replace Strategy

### Global Replacements Needed:

#### Variable Names:
```dart
// Cooperative → Farmer
cooperative → farmer
cooperativeId → farmerId
cooperativeName → farmerName
CooperativeModel → FarmerModel

// Institution → Consumer (institutional)
institution → consumer
institutionId → consumerId
institutionName → organizationName (or fullName)
InstitutionModel → ConsumerModel
institutionType → consumerType
```

#### Collection References:
```dart
AppConstants.cooperativesCollection → AppConstants.farmersCollection
AppConstants.institutionsCollection → AppConstants.consumersCollection
AppConstants.cooperativeType → AppConstants.farmerType
AppConstants.institutionType → AppConstants.consumerType
```

#### Method Names:
```dart
// Firestore Service
getCooperative → getFarmer
getCooperativeByUserId → getFarmerByUserId
getCooperatives → getFarmers
createCooperative → createFarmer
updateCooperative → updateFarmer

getInstitution → getConsumer (with type filter)
getInstitutionByUserId → getConsumerByUserId (with type filter)
getInstitutions → getConsumers (with type filter)
createInstitution → createConsumer
updateInstitution → updateConsumer
```

---

## ⚠️ Breaking Changes & Migration Notes

### Database Migration
**Firebase Collections to Update**:
```
OLD                    NEW                    ACTION
-------------------    -------------------    ------------------------
cooperatives/          farmers/               Rename collection OR keep both for backwards compatibility
institutions/          consumers/             Merge into consumers/ with consumerType field
```

**Migration Options**:

**Option A: Keep Old Collections (Backwards Compatible)**
- Keep `cooperatives` and `institutions` collections as-is
- App reads from both old and new collections
- Gradually migrate data in background

**Option B: One-time Migration**
- Run Firebase migration script
- Copy all `cooperatives/*` → `farmers/*`
- Copy all `institutions/*` → `consumers/*` (with consumerType field)
- Update all foreign key references

**Recommended**: **Option A** for production safety

### User Type Migration
```dart
// Old user types
'cooperative' → 'farmer'
'institution' → 'consumer' (with consumerType sub-type)

// Updated user type checking
if (userType == AppConstants.cooperativeType) // OLD
if (userType == AppConstants.farmerType) // NEW

if (userType == AppConstants.institutionType) // OLD
if (userType == AppConstants.consumerType && 
    consumer.consumerType != 'individual') // NEW
```

### UI/UX Changes
1. **Registration Flow**: 
   - Farmer registration (simplified from cooperative)
   - Consumer registration with type selector (individual/school/hospital/restaurant)

2. **Dashboards**:
   - Single consumer dashboard with conditional features based on `consumerType`
   - Show institutional features only for organizational consumers

3. **Order Flow**:
   - Aggregators search "farmers" (not cooperatives)
   - Consumers (all types) can place orders

---

## 📝 Testing Checklist

### Unit Tests
- [ ] FarmerModel serialization/deserialization
- [ ] ConsumerModel with all consumer types
- [ ] Backwards compatibility (old field names)
- [ ] FirestoreService CRUD operations

### Integration Tests
- [ ] Farmer registration → planting → harvest → sale flow
- [ ] Individual consumer: scan → verify → purchase
- [ ] Institutional consumer: post requirement → place order → receive
- [ ] Aggregator: find farmers → place order → receive beans
- [ ] Cross-type interactions (farmer → aggregator → consumer)

### User Acceptance Testing
- [ ] Test with existing farmer cooperatives
- [ ] Test with school/hospital buyers
- [ ] Test with individual consumers
- [ ] Verify all notifications work correctly
- [ ] Verify PDF certificates generate properly

---

## 🚀 Deployment Strategy

### Phase 1: Development (Current)
1. ✅ Update core models
2. ✅ Update constants
3. Update service layer
4. Update UI screens
5. Update localization

### Phase 2: Testing
1. Deploy to test environment
2. Run migration scripts on test data
3. Comprehensive testing
4. Fix bugs

### Phase 3: Production (Staged Rollout)
1. **Week 1**: Deploy with backwards compatibility
   - App works with both old and new user types
   - Gradual user migration

2. **Week 2-3**: Monitor and adjust
   - Check for issues
   - Support users
   - Fix edge cases

3. **Week 4**: Complete migration
   - All users migrated
   - Remove old code paths
   - Clean up deprecated collections (optional)

---

## 📊 Impact Summary

### Simplified User Types
**Before**: 7 types
- Seed Producer
- Agro-Dealer  
- **Cooperative** ❌
- Aggregator
- **Institution** ❌
- Consumer
- Admin

**After**: 5 types
- Seed Producer
- Agro-Dealer
- **Farmer** ✅ (was Cooperative)
- Aggregator
- **Consumer** ✅ (includes individuals + institutions)
- Admin

### Benefits
✅ **Simpler UX**: Fewer user types to understand  
✅ **Clearer Terminology**: "Farmer" is more intuitive than "Cooperative"  
✅ **Unified Consumer Experience**: All buyers use same app features  
✅ **Easier Marketing**: "Farmers & Consumers" vs "Cooperatives & Institutions"  
✅ **Better Scalability**: Consumer model handles all buyer types  

### Risks
⚠️ **Data Migration**: Need careful handling of existing data  
⚠️ **User Re-education**: Existing users need to understand changes  
⚠️ **Testing Effort**: 500+ references to update and test  

---

## 👤 Next Steps

### Immediate (Today)
1. Update `firestore_service.dart` with new method names
2. Update batch_model.dart cooperative references
3. Test farmer and consumer models

### Short-term (This Week)
1. Update all farmer-related screens
2. Merge institution screens into consumer screens
3. Update localization files
4. Create migration scripts for Firebase

### Medium-term (Next Week)
1. Comprehensive testing
2. Update documentation
3. Prepare deployment plan
4. User communication strategy

---

**Status**: Core models complete ✅  
**Progress**: 15% complete (3/20 major tasks)  
**Estimated Completion**: 2-3 days for code, 1 week for testing

---

**Last Updated**: November 6, 2025  
**Refactoring Lead**: Development Team  
**Review Required**: Yes - before Phase 3 deployment
