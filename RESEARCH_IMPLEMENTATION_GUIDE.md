# AGRITRACE Research Implementation Guide

**BSc. Software Engineering Research Project**  
**Student:** Renoir KAZE  
**Supervisor:** Neza David Tuyishimire  
**Institution:** African Leadership University  
**Research Period:** November 2025 - February 2026 (12 weeks)

---

## Research Overview

### Main Research Objective
To investigate the technical feasibility, user adoption patterns, and verification effectiveness of blockchain-based traceability systems for biofortified crop authentication in Rwanda's smallholder farming context.

### Research Questions

**RQ1 (Technical Performance):** How do different blockchain architectures affect system performance under varying connectivity conditions in rural Rwanda?

**RQ2 (User Adoption):** What factors predict adoption and sustained usage among smallholder farmers? How do patterns differ by gender, age, digital literacy?

**RQ3 (Verification Effectiveness):** What is the quantitative impact on fraud reduction and supply chain transparency?

**RQ4 (Trust & Perception):** How do stakeholders perceive blockchain-verified crops vs. conventionally certified products?

**RQ5 (Usability):** What UI/UX patterns optimize usability for agricultural populations with varying digital literacy?

---

## Research Setting

**Location:** Musanze District, Northern Province, Rwanda
- **Area:** 530 km²
- **Target Farmers:** 2,000 smallholder farmers
- **Cooperatives:** 15 agricultural cooperatives
- **Processing Facilities:** 5
- **Retail Locations:** 10

**Sample Size:** 200 participants
- Farmers: n=100
- Traders: n=20
- Processors/Retailers: n=25
- Consumers: n=50
- Seed Producers: n=5

**Qualitative Interviews:** 40 participants (maximum variation sampling)

---

## 12-Week Research Timeline

### **Week 1-2: Phase 1 - Baseline Assessment**
✅ **Deliverables:**
- IRB ethics approval obtained
- 200 participants recruited
- Supply chain audits at 15 cooperatives
- Baseline surveys administered
- Digital literacy assessments completed
- Fraud rate documentation (15-30% baseline)

**Technical Tasks:**
- [ ] Create baseline survey instruments (Kobo Toolbox)
- [ ] Digital literacy assessment system
- [ ] Supply chain audit templates
- [ ] Fraud documentation database

---

### **Week 3-7: Phase 2 - System Development & Testing**
✅ **Deliverables:**
- Blockchain platform deployed (Ethereum testnet)
- Progressive Web Application (PWA) functional
- 8 participatory design workshops conducted
- Usability testing with 25 participants
- System performance benchmarks established

**Technical Tasks:**
- [ ] Smart contract development (AgriTrace.sol)
- [ ] Django REST API with JWT authentication
- [ ] React PWA with offline-first architecture
- [ ] QR code generation & scanning
- [ ] PostgreSQL + Blockchain + IPFS integration
- [ ] Performance testing under 3 connectivity scenarios
- [ ] 2 device types (high-end vs budget Android)

---

### **Week 8-10: Phase 3 - Pilot Implementation**
✅ **Deliverables:**
- System deployed with all 200 participants
- 2-hour training sessions for all participants
- 20 seed lots tracked end-to-end
- 200 random product samples tested
- Automated transaction logging active

**Technical Tasks:**
- [ ] Deployment infrastructure
- [ ] Training materials in Kinyarwanda
- [ ] Help desk phone support system
- [ ] Automated transaction logging
- [ ] Supply chain tracking module
- [ ] Random authentication testing system

---

### **Week 11-12: Phase 4 - Data Analysis & Reporting**
✅ **Deliverables:**
- Post-implementation surveys completed
- 40 semi-structured interviews conducted
- Statistical analysis (t-tests, regression)
- Thematic analysis of qualitative data
- Research report submitted

**Technical Tasks:**
- [ ] Data export and analysis tools
- [ ] Statistical analysis scripts (SPSS/R)
- [ ] Qualitative coding (NVivo)
- [ ] Visualization dashboards
- [ ] Final research report

---

## Technical Architecture

### System Stack

**Frontend:**
- React 18.2.0 (PWA)
- Offline-first with Service Workers
- QR Code Scanner (react-qr-reader)
- Material-UI for accessible design
- Multi-language support (English, Kinyarwanda, French)

**Backend:**
- Django 4.2.x + Django REST Framework
- PostgreSQL (user data, metadata)
- JWT Authentication (Simple JWT)
- Role-based access control (6 user types)
- AES-256 encryption for PII

**Blockchain:**
- Ethereum Goerli/Sepolia Testnet
- Solidity 0.8.19 smart contracts
- Web3.py integration
- Infura node provider
- IPFS for document storage

**Mobile:**
- Flutter 3.x (Android/iOS)
- Same backend APIs
- Offline sync capabilities
- Camera integration for QR scanning

### Database Schema

**Core Models:**
```python
# users/models.py
class User(AbstractUser):
    user_type = CharField(choices=[farmer, trader, processor, consumer, seed_producer, admin])
    phone_number = CharField(encrypted)
    location = ForeignKey(Location)
    verified_status = BooleanField()
    digital_literacy_score = IntegerField()
    wallet_address = CharField()

class Location:
    district, sector, cell, village
    latitude, longitude, elevation
    climate_zone

# products/models.py
class Batch:
    batch_number (unique)
    seed_variety
    farmer = ForeignKey(User)
    planting_date, harvest_date
    location = ForeignKey(Location)
    blockchain_hash

class Product:
    qr_code (unique, auto-generated)
    batch = ForeignKey(Batch)
    product_name, variety
    iron_content_ppm
    biofortified = BooleanField()
    status = [registered, in_transit, processed, retail, sold]
    blockchain_hash, ipfs_hash

# transactions/models.py
class Transaction:
    from_user, to_user
    product, quantity, price_rwf
    transaction_type = [harvest, transfer, processing, sale]
    blockchain_hash
    gps_location, timestamp

class SupplyChain:
    product
    step_number
    actor, action, location
    temperature, humidity (optional)
    blockchain_verified
```

---

## Research Instrumentation

### Metrics to Track

**Technical Performance (RQ1):**
- Transaction completion rate (target: >90%)
- Response time (target: <3 seconds)
- Synchronization accuracy (target: >95%)
- Error frequency by type
- Performance by connectivity scenario
- Performance by device type

**User Adoption (RQ2):**
- Initial adoption rate
- Sustained usage (>1 transaction/week for 3 weeks)
- Usage by demographic (gender, age, literacy)
- Dropout reasons
- Time to proficiency

**Verification Effectiveness (RQ3):**
- Fraud detection rate (baseline: 15-30%)
- Traceability completeness (% of supply chain recorded)
- Authentication test pass rate
- Information symmetry score

**Trust & Perception (RQ4):**
- Trust in biofortified crops (5-point Likert)
- Perceived reliability of blockchain
- Willingness to pay premium
- Satisfaction with system

**Usability (RQ5):**
- Task completion rate
- Time-on-task
- Error frequency
- System Usability Scale (SUS) score (target: >68)
- User satisfaction ratings

---

## Key Features for Research

### 1. Digital Literacy Assessment Tool
```python
# Assessment includes 15 tasks:
- Operational: "Open camera", "Take photo", "Find app"
- Information: "Search for bean prices", "Read notification"
- Strategic: "Complete product registration", "Verify QR code"

# Scoring: 0 = failed, 1 = with assistance, 2 = independently
# Literacy levels: Low (0-10), Medium (11-20), High (21-30)
```

### 2. Automated Transaction Logging
```python
# Log every interaction for research analysis
class TransactionLog:
    user, timestamp
    action_type = [login, register_product, scan_qr, view_history, ...]
    success = Boolean
    response_time_ms
    device_info (model, OS, connectivity)
    error_message (if failed)
    session_id
```

### 3. Supply Chain Traceability Score
```python
def calculate_traceability_completeness(product):
    """
    Expected steps for biofortified beans:
    1. Seed distribution (seed producer → farmer)
    2. Planting (farmer records)
    3. Harvest (farmer records)
    4. Sale to trader (farmer → trader)
    5. Aggregation (trader records)
    6. Processing (trader → processor)
    7. Retail (processor → retailer)
    8. Consumer purchase (retailer → consumer)
    
    Score = (recorded_steps / total_expected_steps) * 100
    """
    return completeness_percentage
```

### 4. Fraud Detection System
```python
# Random authentication testing
def schedule_random_tests():
    """
    - 10 retail locations
    - Bi-weekly testing (weeks 8-10)
    - 4 rounds × 10 locations × 5 samples = 200 samples
    
    Test protocol:
    1. Purchase product labeled as biofortified
    2. Record QR code and blockchain hash
    3. Phenotypic marker verification (RAB protocol)
    4. Lab testing (sample subset)
    5. Compare blockchain record vs actual product
    """
```

### 5. Offline-First Architecture
```javascript
// Service Worker for offline functionality
self.addEventListener('fetch', (event) => {
  event.respondWith(
    caches.match(event.request).then((response) => {
      return response || fetch(event.request).then((fetchResponse) => {
        return caches.open('agritrace-v1').then((cache) => {
          cache.put(event.request, fetchResponse.clone());
          return fetchResponse;
        });
      });
    }).catch(() => {
      // Return offline page
      return caches.match('/offline.html');
    })
  );
});

// Background sync for transactions
self.addEventListener('sync', (event) => {
  if (event.tag === 'sync-transactions') {
    event.waitUntil(syncOfflineTransactions());
  }
});
```

---

## Ethical Compliance Features

### 1. Informed Consent Management
- Multi-language consent forms (Kinyarwanda, English, French)
- Audio consent recording for low-literacy participants
- Ongoing consent reaffirmation
- Clear withdrawal procedures

### 2. Data Privacy
- AES-256 encryption for PII
- Off-chain personal data (deletable)
- On-chain anonymized hashes only
- Multi-factor authentication
- Session timeout (30 minutes)

### 3. Digital Divide Mitigation
- Free platform access
- Mobile data vouchers (50MB/month)
- Comprehensive training (2-hour sessions)
- Help desk in Kinyarwanda
- Women's cooperative partnerships (50% women target)

---

## Success Criteria

### Research Success
- [ ] 200 participants recruited and consented
- [ ] >80% survey completion rate
- [ ] 40 in-depth interviews completed
- [ ] Technical performance benchmarks established
- [ ] Adoption factors identified
- [ ] Fraud reduction measured
- [ ] Design guidelines generated

### Technical Success
- [ ] System uptime >95%
- [ ] Transaction completion >90%
- [ ] Response time <3 seconds
- [ ] Data synchronization accuracy >95%
- [ ] SUS score >68
- [ ] Mobile data usage <50MB/month/user

### Impact Success
- [ ] Fraud reduction of >50% (from 15-30% baseline to <10%)
- [ ] Supply chain traceability completeness >80%
- [ ] Trust in biofortified crops increase >20%
- [ ] Sustained adoption rate >60% at week 10

---

## Next Steps for Development

### Immediate Priorities (This Week)

**1. Complete Security Infrastructure**
- [x] AES-256 encryption utility
- [x] Consent management models
- [ ] Multi-factor authentication
- [ ] Session management middleware
- [ ] Audit logging

**2. Research Instrumentation**
- [ ] Digital literacy assessment tool
- [ ] Automated transaction logger
- [ ] Performance monitoring dashboard
- [ ] Survey integration (Kobo Toolbox API)

**3. Blockchain Integration**
- [ ] Complete smart contract (AgriTrace.sol)
- [ ] Deploy to Goerli testnet
- [ ] Web3 integration testing
- [ ] IPFS document storage

**4. QR Code System**
- [ ] QR generation algorithm
- [ ] Product registration workflow
- [ ] Verification endpoint
- [ ] Supply chain tracking

**5. Multi-Stakeholder Dashboards**
- [ ] Farmer dashboard (register products, view sales)
- [ ] Trader dashboard (buy products, manage inventory)
- [ ] Processor dashboard (track batches, certifications)
- [ ] Consumer dashboard (verify products, view history)
- [ ] Admin dashboard (analytics, fraud monitoring)

---

## Research Outputs

### Academic Deliverables
1. **Research Report** (main deliverable)
2. **Journal Paper** (target: African Journal of Food, Agriculture, Nutrition and Development)
3. **Conference Presentation** (target: AfriCHI 2026)
4. **Policy Brief** for Rwanda Agriculture Board

### Technical Deliverables
1. **Open-source codebase** (GitHub)
2. **System documentation**
3. **API documentation** (Swagger/OpenAPI)
4. **Design guidelines** for blockchain in agriculture
5. **Training materials** in Kinyarwanda

---

## Contact & Support

**Principal Investigator:** Renoir KAZE (r.kaze@alustudent.com)  
**Supervisor:** Neza David Tuyishimire  
**Institution:** African Leadership University, Kigali Campus  
**Ethics Approval:** ALU IRB (pending)

**Project Repository:** github.com/renoirkaze/agritrace  
**Documentation:** docs.agritrace.rw  
**Help Desk:** +250-XXX-XXX-XXX (Kinyarwanda support)

---

**Last Updated:** October 20, 2025  
**Status:** Development Phase - Week 0 (Pre-baseline)
