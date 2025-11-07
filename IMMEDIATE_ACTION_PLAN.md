# AGRITRACE - Immediate Action Plan
**For Week 8 Deployment Readiness**

---

## 🎯 Goal: Complete MVP to 100% in 10-15 Hours

Current Status: **85%** → Target: **100%**

---

## 📋 Critical Path (Must Complete)

### Task 1: Deploy Smart Contract to Testnet (4 hours) 🔴 BLOCKING

**Why Critical**: Your research requires blockchain verification (RQ3)

**Steps**:

1. **Get Infura Account** (15 min)
   ```bash
   # Go to https://infura.io
   # Create free account
   # Create new project: "AGRITRACE-Research"
   # Copy Project ID and Secret
   ```

2. **Configure Backend** (30 min)
   ```bash
   # Edit backend/.env
   ETHEREUM_NODE_URL=https://sepolia.infura.io/v3/YOUR_PROJECT_ID
   ETHEREUM_PRIVATE_KEY=YOUR_WALLET_PRIVATE_KEY
   ```

   Get test ETH from Sepolia faucet:
   - https://sepoliafaucet.com/
   - https://faucet.sepolia.dev/

3. **Deploy Contract** (1 hour)
   ```bash
   cd blockchain
   npm install
   truffle compile
   truffle migrate --network sepolia
   
   # Save deployed contract address
   ```

4. **Update Configuration** (30 min)
   ```python
   # backend/.env
   CONTRACT_ADDRESS=0x... # from deployment
   ```

5. **Test Blockchain Integration** (1.5 hours)
   ```bash
   # Test product registration
   python manage.py shell
   >>> from blockchain.web3_client import register_product
   >>> register_product(product_id=1, ...)
   ```

6. **Flutter Integration** (30 min)
   ```dart
   // Add to pubspec.yaml
   web3dart: ^2.7.1
   
   // Update lib/config/app_config.dart
   static const contractAddress = 'YOUR_CONTRACT_ADDRESS';
   ```

**Deliverable**: Smart contract live on Sepolia, backend can record transactions

---

### Task 2: Post-Implementation Survey Screen (2 hours) 🟡 IMPORTANT

**Why Critical**: RQ4 (Trust), RQ5 (Usability) need post-survey data

**Steps**:

1. **Copy Baseline Survey** (15 min)
   ```bash
   cp lib/screens/research/baseline_survey_screen.dart \
      lib/screens/research/post_implementation_survey_screen.dart
   ```

2. **Add SUS Questions** (45 min)
   ```dart
   // Already in PostImplementationSurvey model!
   // Just need UI for 10 SUS questions
   
   sus_q1_use_frequently
   sus_q2_unnecessarily_complex
   ... (10 questions total)
   ```

3. **Add Satisfaction Questions** (30 min)
   ```dart
   - Overall satisfaction (1-5)
   - Would recommend (yes/no)
   - Willing to pay (yes/no)
   - What liked most (text)
   - What liked least (text)
   - Suggestions (text)
   ```

4. **Test Survey Flow** (30 min)
   - Navigate from dashboard
   - Complete all questions
   - Submit to backend
   - Verify data saved

**Deliverable**: Complete post-survey ready for Week 11-12

---

### Task 3: Admin Analytics Dashboard (4 hours) 🟡 IMPORTANT

**Why Critical**: Monitor research progress, generate thesis data

**Steps**:

1. **Create Backend Endpoint** (1 hour)
   ```python
   # backend/analytics/views.py
   
   class ResearchDashboardView(APIView):
       permission_classes = [IsAdminUser]
       
       def get(self, request, week_number=None):
           dashboard = ResearchDashboard.generate_weekly_dashboard(week_number)
           return Response(ResearchDashboardSerializer(dashboard).data)
   ```

2. **Create Flutter Screen** (2 hours)
   ```bash
   # Create new file
   lib/screens/admin/research_dashboard_screen.dart
   ```

   **Display**:
   - Total participants (200 target)
   - Active users this week
   - Transaction completion rate
   - Fraud detection rate
   - Supply chain traceability score
   - Average SUS score
   - Charts/graphs

3. **Add Export Functionality** (1 hour)
   ```dart
   // Export data as CSV for thesis
   ElevatedButton(
     onPressed: _exportData,
     child: Text('Export Week 8 Data'),
   )
   ```

**Deliverable**: Real-time research monitoring dashboard

---

## 🔄 Should Complete (Improves Quality)

### Task 4: Image Upload to Backend (2 hours) 🟢 NICE-TO-HAVE

**Current**: Frontend captures photos, backend doesn't receive

**Fix**:

1. **Backend** (1 hour)
   ```python
   # products/views.py
   from rest_framework.parsers import MultiPartParser, FormParser
   
   class ProductViewSet(viewsets.ModelViewSet):
       parser_classes = (MultiPartParser, FormParser)
       
       def create(self, request):
           # Handle file upload
           image = request.FILES.get('image')
           ...
   ```

2. **Flutter** (1 hour)
   ```dart
   // Use Dio for multipart
   FormData formData = FormData.fromMap({
     'product_name': productName,
     'image': await MultipartFile.fromFile(imagePath),
   });
   await dio.post('/products/', data: formData);
   ```

**Deliverable**: Photos sync to backend

---

### Task 5: Training Materials (3 hours) 🟢 NICE-TO-HAVE

**Create**:

1. **Video Tutorials** (2 hours)
   - Record screen: "How to register product"
   - Record screen: "How to scan QR code"
   - Record screen: "How to use offline mode"
   - Narrate in Kinyarwanda
   - Upload to YouTube (unlisted)

2. **Quick Reference PDF** (1 hour)
   ```
   One-page guide with screenshots:
   - Login
   - Register product (with icons)
   - Scan QR code
   - View history
   
   In Kinyarwanda and English side-by-side
   ```

**Deliverable**: Training package for 200 participants

---

### Task 6: Batch Merging Logic (3 hours) 🟢 OPTIONAL

**For traders combining multiple farmer batches**

1. **Backend Model** (1 hour)
   ```python
   class BatchMerge(models.Model):
       merged_batch = ForeignKey(Batch)
       source_batches = ManyToManyField(Batch)
       created_by = ForeignKey(User)
   ```

2. **UI Flow** (2 hours)
   ```dart
   // In inventory_screen.dart
   - Select multiple products
   - Tap "Merge Batches"
   - Create new combined batch
   - Link to original batches
   ```

**Deliverable**: Full traceability through aggregation

---

## ⏰ Time Estimates & Priority

| Task | Hours | Priority | Deadline |
|------|-------|----------|----------|
| 1. Smart Contract Deploy | 4h | 🔴 Critical | Day 1-2 |
| 2. Post-Survey UI | 2h | 🟡 Important | Day 3 |
| 3. Admin Dashboard | 4h | 🟡 Important | Day 4 |
| **SUBTOTAL MVP** | **10h** | **Must Do** | **Week 1** |
| 4. Image Upload | 2h | 🟢 Nice | Week 2 |
| 5. Training Materials | 3h | 🟢 Nice | Week 2 |
| 6. Batch Merging | 3h | 🟢 Optional | If time |

---

## 📅 5-Day Sprint Plan

### Monday: Smart Contract
- [ ] Morning: Set up Infura, get test ETH
- [ ] Afternoon: Deploy contract to Sepolia
- [ ] Evening: Test blockchain transactions

### Tuesday: Smart Contract Testing
- [ ] Morning: Backend integration testing
- [ ] Afternoon: Flutter Web3 integration
- [ ] Evening: End-to-end blockchain test

### Wednesday: Surveys
- [ ] Morning: Create post-survey UI
- [ ] Afternoon: Test survey flow
- [ ] Evening: Backend survey endpoint testing

### Thursday: Analytics Dashboard
- [ ] Morning: Backend dashboard endpoint
- [ ] Afternoon: Flutter dashboard UI
- [ ] Evening: Data visualization and export

### Friday: Testing & Polish
- [ ] Morning: End-to-end system testing
- [ ] Afternoon: Fix any bugs found
- [ ] Evening: Prepare for Week 8 deployment

---

## ✅ Completion Checklist

### Before Declaring "100% Complete"

**Smart Contract**:
- [ ] Contract deployed to Sepolia testnet
- [ ] Contract address in configuration
- [ ] Backend can create transactions
- [ ] Transaction hash returned and stored
- [ ] Can verify transaction on Etherscan

**Surveys**:
- [ ] Baseline survey works (already done ✅)
- [ ] Post-implementation survey UI complete
- [ ] All SUS questions implemented
- [ ] Survey data saves to backend
- [ ] Can view survey results in admin

**Analytics**:
- [ ] Backend endpoint returns research metrics
- [ ] Flutter screen displays all metrics
- [ ] Charts/graphs show data visually
- [ ] Export functionality works
- [ ] Can generate weekly reports

**Testing**:
- [ ] All 5 user roles tested
- [ ] Offline mode tested (disconnect → queue → sync)
- [ ] QR scanning tested
- [ ] Product registration end-to-end tested
- [ ] Supply chain visualization tested
- [ ] Research logging verified (check backend logs)

---

## 🚀 Week 8 Deployment Checklist

### Pre-Deployment (Day 0)
- [ ] All code committed to Git
- [ ] Backend deployed to production server
- [ ] Database migrations run
- [ ] Static files collected
- [ ] SSL certificate configured
- [ ] Domain name configured

### Deployment (Day 1)
- [ ] Create 20 test user accounts (all roles)
- [ ] Test login from multiple devices
- [ ] Test QR scanning in field conditions
- [ ] Test offline mode with poor connectivity
- [ ] Create sample products for each farmer

### Training (Day 2-3)
- [ ] Conduct first training session (10 farmers)
- [ ] Conduct second training session (10 farmers)
- [ ] Distribute quick reference guides
- [ ] Set up support WhatsApp group
- [ ] Test help desk phone line

### Monitoring (Day 4-7)
- [ ] Daily check of ResearchDashboard
- [ ] Monitor error logs
- [ ] Respond to support requests < 2 hours
- [ ] Daily check sync queue (offline actions)
- [ ] Weekly check transaction logs

---

## 📊 Success Metrics (By End of Week 8)

**Adoption**:
- ✅ 100 farmers registered
- ✅ 20 traders registered
- ✅ 50 consumers registered
- ✅ 80%+ login success rate

**Usage**:
- ✅ 50+ products registered
- ✅ 100+ QR scans performed
- ✅ 30+ transactions recorded
- ✅ <5% error rate

**Research Data**:
- ✅ 100+ baseline surveys completed
- ✅ 1000+ action logs captured
- ✅ Performance data for 3 connectivity scenarios
- ✅ Zero data loss incidents

---

## 🆘 Emergency Contacts

**If Something Breaks During Pilot**:

1. **Check Logs First**:
   ```bash
   # Backend logs
   tail -f /var/log/agritrace/django.log
   
   # Check error frequency
   python manage.py shell
   >>> from users.models_research import TransactionLog
   >>> TransactionLog.objects.filter(success=False).count()
   ```

2. **Common Issues**:
   - **"Can't connect"** → Check backend server status
   - **"Offline queue not syncing"** → Check internet, restart app
   - **"QR scan fails"** → Check camera permissions
   - **"Login fails"** → Verify user credentials in Django admin

3. **Rollback Plan**:
   ```bash
   # If major issue, rollback to previous version
   git checkout <previous-working-commit>
   flutter build apk
   # Redistribute APK
   ```

---

## 📈 Post-Week 8 Activities

### Weeks 9-10: Monitoring Phase
- Check ResearchDashboard daily
- Respond to user feedback
- Fix critical bugs within 24h
- Collect qualitative feedback via interviews
- Adjust system based on user behavior

### Week 11: Post-Survey Collection
- Deploy post-implementation survey
- Send notifications to all users
- Follow up with non-respondents
- Target: 80%+ survey completion rate

### Week 12: Analysis & Writing
- Export all research data
- Run statistical analyses (t-tests, regression)
- Calculate success metrics
- Write Chapter 4 (Results)
- Prepare visualizations for thesis

---

## ✅ Final Checklist Before Week 8

**Run through this the evening before deployment**:

- [ ] Smart contract deployed and tested
- [ ] All backend endpoints working
- [ ] Flutter app builds successfully
- [ ] APK tested on 3+ devices
- [ ] Offline mode tested thoroughly
- [ ] Research logging verified
- [ ] Admin dashboard accessible
- [ ] Training materials ready
- [ ] Support systems in place
- [ ] Backup plan documented

---

## 🎯 Success Definition

**Your MVP is 100% complete when**:
1. ✅ Smart contract records transactions on Sepolia
2. ✅ 200 participants can use all core features
3. ✅ Offline mode works for 7+ days
4. ✅ All research data auto-logs to backend
5. ✅ Admin can monitor progress in real-time
6. ✅ System runs for 3 weeks with <5% errors
7. ✅ All 4 research questions (RQ1-RQ4) addressable with collected data

---

**You're 85% there. 10-15 focused hours to 100%. Let's finish strong!** 💪🚀

**Next**: Start with Task 1 (Smart Contract) Monday morning.
