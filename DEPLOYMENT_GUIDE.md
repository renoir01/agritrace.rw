# AGRITRACE - Complete Deployment Guide

**For Week 8 Research Pilot (200 Participants in Musanze District)**

---

## 🎯 Deployment Overview

You need to deploy **3 components**:

1. **Backend API** (Django) → Cloud server or local server
2. **Mobile App** (Flutter) → APK to participant devices
3. **Smart Contract** (Ethereum) → Sepolia testnet

**Timeline**: 1-2 days for complete deployment

---

## 📱 Part 1: Mobile App Deployment (Flutter APK)

### Step 1: Build Android APK (30 minutes)

**Option A: Release APK (Recommended for Research)**
```bash
cd e:\agritracerw\mobile

# Build release APK
flutter build apk --release

# APK location:
# build/app/outputs/flutter-apk/app-release.apk
```

**Option B: Debug APK (For Testing)**
```bash
flutter build apk --debug
```

**Option C: App Bundle (For Google Play - Not Needed)**
```bash
flutter build appbundle --release
```

### Step 2: Configure App for Production (15 minutes)

**Edit `lib/config/app_config.dart`:**
```dart
class AppConfig {
  // CHANGE THIS to your production server IP
  static const String baseUrl = 'http://YOUR_SERVER_IP:8000/api/v1';
  
  // Or if you have a domain
  static const String baseUrl = 'https://agritrace.yourdomain.com/api/v1';
  
  // Other settings stay the same
  static const connectionTimeout = Duration(seconds: 30);
}
```

**Then rebuild:**
```bash
flutter clean
flutter pub get
flutter build apk --release
```

### Step 3: Test APK Locally (10 minutes)

```bash
# Install on connected device
flutter install

# Or manually:
# 1. Copy build/app/outputs/flutter-apk/app-release.apk to your phone
# 2. Enable "Install from Unknown Sources" in phone settings
# 3. Tap the APK file to install
```

**Test checklist:**
- [ ] App launches
- [ ] Can login
- [ ] Can register product
- [ ] QR scanner works
- [ ] Offline mode works (disconnect WiFi, try action, reconnect)

### Step 4: Distribute to 200 Participants (Multiple Options)

#### **Option A: Direct Installation (Recommended for Research)**

**For Musanze District Field Study:**

1. **Prepare Installation Package:**
   ```bash
   # Create a shareable folder
   mkdir agritrace-installation
   cp build/app/outputs/flutter-apk/app-release.apk agritrace-installation/
   
   # Add instructions PDF
   # Add training video links
   ```

2. **Distribution Methods:**

   **a) USB/SD Card (Most Reliable)**
   - Copy APK to USB drives
   - Visit cooperatives with laptops
   - Transfer to phones via USB
   - Install on-site with guidance

   **b) WhatsApp/Telegram Groups**
   - Create WhatsApp group for each cooperative
   - Send APK file (25-50MB typical size)
   - Send installation video
   - Participants download and install

   **c) Local WiFi Hotspot**
   - Set up laptop as WiFi hotspot
   - Host APK on local web server
   - Participants download via browser
   ```bash
   # Simple HTTP server
   cd agritrace-installation
   python -m http.server 8080
   # Participants visit: http://YOUR_LAPTOP_IP:8080/app-release.apk
   ```

#### **Option B: Google Play Internal Testing (Optional)**

**If you want easier updates:**

1. **Create Google Play Console Account** ($25 one-time fee)
2. **Create Internal Testing Track:**
   - Upload app-release.aab (not APK)
   - Add 200 participant emails
   - Share installation link
3. **Advantages:**
   - Easy updates (participants auto-update)
   - No APK file sharing needed
4. **Disadvantages:**
   - Costs $25
   - Takes 1-2 days for approval
   - Participants need Google account

#### **Option C: Firebase App Distribution (Free)**

**Google's free alternative:**

1. **Set up Firebase:**
   ```bash
   npm install -g firebase-tools
   firebase login
   firebase init hosting
   ```

2. **Upload APK:**
   ```bash
   firebase appdistribution:distribute \
     build/app/outputs/flutter-apk/app-release.apk \
     --app YOUR_FIREBASE_APP_ID \
     --groups testers
   ```

3. **Invite Participants:**
   - Send invitation emails
   - Participants install via Firebase App Distribution app

### Step 5: Version Control & Updates

**Track versions in pubspec.yaml:**
```yaml
version: 1.0.0+1  # version+buildNumber

# For updates:
version: 1.0.1+2  # Increment for bug fixes
version: 1.1.0+3  # Increment for new features
```

**Distribute updates:**
```bash
# Rebuild with new version
flutter build apk --release

# Redistribute APK
# Participants can install over existing app (data preserved)
```

---

## 🖥️ Part 2: Backend API Deployment (Django)

You have **3 deployment options**:

### Option A: Cloud Server (Recommended) ☁️

#### **Using DigitalOcean/AWS/Azure (Example: DigitalOcean)**

**1. Create Droplet/Server (20 minutes)**
```bash
# DigitalOcean: Create Ubuntu 22.04 Droplet
# Minimum: 2GB RAM, 2 CPUs ($12/month)
# Recommended: 4GB RAM, 2 CPUs ($24/month) for 200 users

# SSH into server
ssh root@YOUR_SERVER_IP
```

**2. Install Dependencies (15 minutes)**
```bash
# Update system
apt update && apt upgrade -y

# Install Python
apt install python3 python3-pip python3-venv -y

# Install PostgreSQL
apt install postgresql postgresql-contrib -y

# Install Nginx
apt install nginx -y

# Install Git
apt install git -y

# Install Redis (for offline queue)
apt install redis-server -y
```

**3. Set Up Application (30 minutes)**
```bash
# Clone repository
cd /var/www
git clone YOUR_REPO_URL agritrace
cd agritrace/backend

# Create virtual environment
python3 -m venv venv
source venv/bin/activate

# Install requirements
pip install -r requirements.txt

# Install production server
pip install gunicorn
```

**4. Configure PostgreSQL (15 minutes)**
```bash
# Create database
sudo -u postgres psql
postgres=# CREATE DATABASE agritrace_db;
postgres=# CREATE USER agritrace_user WITH PASSWORD 'STRONG_PASSWORD';
postgres=# ALTER ROLE agritrace_user SET client_encoding TO 'utf8';
postgres=# ALTER ROLE agritrace_user SET default_transaction_isolation TO 'read committed';
postgres=# ALTER ROLE agritrace_user SET timezone TO 'Africa/Kigali';
postgres=# GRANT ALL PRIVILEGES ON DATABASE agritrace_db TO agritrace_user;
postgres=# \q
```

**5. Configure Django (20 minutes)**

**Create `.env` file:**
```bash
nano /var/www/agritrace/backend/.env
```

```env
# Django Settings
SECRET_KEY=your-super-secret-key-generate-with-django
DEBUG=False
ALLOWED_HOSTS=YOUR_SERVER_IP,your-domain.com

# Database
DATABASE_URL=postgresql://agritrace_user:STRONG_PASSWORD@localhost:5432/agritrace_db

# Blockchain (from Part 3)
ETHEREUM_NODE_URL=https://sepolia.infura.io/v3/YOUR_INFURA_PROJECT_ID
ETHEREUM_PRIVATE_KEY=YOUR_WALLET_PRIVATE_KEY
CONTRACT_ADDRESS=YOUR_DEPLOYED_CONTRACT_ADDRESS

# IPFS (optional)
IPFS_API_URL=http://localhost:5001

# Africa's Talking (optional)
AFRICAS_TALKING_USERNAME=sandbox
AFRICAS_TALKING_API_KEY=your-key

# Encryption (for research data)
ENCRYPTION_KEY=generate-32-byte-base64-key
```

**Generate SECRET_KEY:**
```python
python manage.py shell
>>> from django.core.management.utils import get_random_secret_key
>>> print(get_random_secret_key())
```

**6. Run Migrations (10 minutes)**
```bash
cd /var/www/agritrace/backend
source venv/bin/activate

python manage.py migrate
python manage.py collectstatic --noinput

# Create admin user
python manage.py createsuperuser
```

**7. Configure Gunicorn (15 minutes)**

**Create systemd service:**
```bash
nano /etc/systemd/system/agritrace.service
```

```ini
[Unit]
Description=AGRITRACE Django Application
After=network.target

[Service]
Type=notify
User=root
WorkingDirectory=/var/www/agritrace/backend
Environment="PATH=/var/www/agritrace/backend/venv/bin"
ExecStart=/var/www/agritrace/backend/venv/bin/gunicorn \
    --workers 3 \
    --bind 0.0.0.0:8000 \
    --timeout 120 \
    --access-logfile /var/log/agritrace/access.log \
    --error-logfile /var/log/agritrace/error.log \
    agritrace.wsgi:application

[Install]
WantedBy=multi-user.target
```

**Create log directory:**
```bash
mkdir -p /var/log/agritrace
```

**Start service:**
```bash
systemctl daemon-reload
systemctl start agritrace
systemctl enable agritrace
systemctl status agritrace
```

**8. Configure Nginx (20 minutes)**

```bash
nano /etc/nginx/sites-available/agritrace
```

```nginx
server {
    listen 80;
    server_name YOUR_SERVER_IP your-domain.com;
    
    client_max_body_size 50M;
    
    location / {
        proxy_pass http://127.0.0.1:8000;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_connect_timeout 120s;
        proxy_send_timeout 120s;
        proxy_read_timeout 120s;
    }
    
    location /static/ {
        alias /var/www/agritrace/backend/staticfiles/;
    }
    
    location /media/ {
        alias /var/www/agritrace/backend/media/;
    }
}
```

**Enable site:**
```bash
ln -s /etc/nginx/sites-available/agritrace /etc/nginx/sites-enabled/
nginx -t
systemctl restart nginx
```

**9. Optional: Set Up SSL (15 minutes)**

```bash
# Install Certbot
apt install certbot python3-certbot-nginx -y

# Get certificate (requires domain name)
certbot --nginx -d your-domain.com

# Auto-renewal
certbot renew --dry-run
```

**10. Test Deployment**

```bash
# Check backend is running
curl http://YOUR_SERVER_IP/api/v1/users/login/

# Should return: {"detail":"Method \"GET\" not allowed."}
# (This is good - means endpoint exists)
```

---

### Option B: Local Server (For Testing/Small Scale) 💻

**If you have a computer that can stay on 24/7:**

**1. Same setup as Option A, but on your local machine**

**2. Configure Port Forwarding:**
```
Router Settings → Port Forwarding
External Port: 8000
Internal IP: YOUR_COMPUTER_IP
Internal Port: 8000
```

**3. Find Public IP:**
```bash
curl ifconfig.me
```

**4. Use in Flutter app:**
```dart
static const String baseUrl = 'http://YOUR_PUBLIC_IP:8000/api/v1';
```

**Disadvantages:**
- Computer must stay on 24/7
- Home internet must be stable
- Security risks (open port)
- Dynamic IP might change

---

### Option C: Heroku (Quick but Limited) 🚀

**Free tier for testing, paid for production:**

**1. Install Heroku CLI**
```bash
# Download from heroku.com/cli
```

**2. Deploy:**
```bash
cd backend
heroku login
heroku create agritrace-research

# Add PostgreSQL
heroku addons:create heroku-postgresql:mini

# Set environment variables
heroku config:set SECRET_KEY=your-secret-key
heroku config:set DEBUG=False

# Deploy
git push heroku main

# Run migrations
heroku run python manage.py migrate
heroku run python manage.py createsuperuser
```

**3. Use in Flutter:**
```dart
static const String baseUrl = 'https://agritrace-research.herokuapp.com/api/v1';
```

---

## ⛓️ Part 3: Smart Contract Deployment (Ethereum Testnet)

### Step 1: Set Up Infura (10 minutes)

1. **Go to** https://infura.io
2. **Create free account**
3. **Create new project**: "AGRITRACE-Research"
4. **Select** Sepolia testnet
5. **Copy Project ID** and **Project Secret**

### Step 2: Get Test ETH (15 minutes)

**You need a wallet with Sepolia ETH:**

1. **Install MetaMask** browser extension
2. **Create wallet** (save seed phrase securely!)
3. **Switch to Sepolia testnet** in MetaMask
4. **Get free test ETH** from faucets:
   - https://sepoliafaucet.com/
   - https://faucet.sepolia.dev/
   - https://sepolia-faucet.pk910.de/
   
   **You need**: ~0.1 Sepolia ETH (free)

### Step 3: Configure Truffle (15 minutes)

**Edit `blockchain/truffle-config.js`:**
```javascript
require('dotenv').config();
const HDWalletProvider = require('@truffle/hdwallet-provider');

module.exports = {
  networks: {
    sepolia: {
      provider: () => new HDWalletProvider(
        process.env.MNEMONIC, // Your MetaMask seed phrase
        `https://sepolia.infura.io/v3/${process.env.INFURA_PROJECT_ID}`
      ),
      network_id: 11155111,
      gas: 4000000,
      gasPrice: 10000000000
    }
  },
  compilers: {
    solc: {
      version: "0.8.19"
    }
  }
};
```

**Create `.env` in `blockchain/` folder:**
```env
MNEMONIC=your twelve word seed phrase from metamask
INFURA_PROJECT_ID=your_infura_project_id
```

### Step 4: Deploy Contract (20 minutes)

```bash
cd blockchain

# Install dependencies
npm install

# Compile
truffle compile

# Deploy to Sepolia
truffle migrate --network sepolia

# Output will show:
# AgriTrace deployed at: 0x1234567890abcdef...
# SAVE THIS ADDRESS!
```

### Step 5: Verify Deployment

1. **Go to** https://sepolia.etherscan.io/
2. **Search** your contract address
3. **You should see** your deployed contract

### Step 6: Configure Backend

**Add to `backend/.env`:**
```env
CONTRACT_ADDRESS=0x1234567890abcdef...  # Your deployed address
ETHEREUM_NODE_URL=https://sepolia.infura.io/v3/YOUR_PROJECT_ID
ETHEREUM_PRIVATE_KEY=your_metamask_private_key
```

**Get private key from MetaMask:**
- Account Details → Export Private Key
- ⚠️ **Never share this!**

---

## 🧪 Part 4: Post-Deployment Testing (30 minutes)

### Test Backend API

```bash
# Health check
curl http://YOUR_SERVER_IP:8000/api/v1/

# Register user
curl -X POST http://YOUR_SERVER_IP:8000/api/v1/users/register/ \
  -H "Content-Type: application/json" \
  -d '{"username":"testfarmer","password":"test123","user_type":"farmer"}'

# Login
curl -X POST http://YOUR_SERVER_IP:8000/api/v1/users/login/ \
  -H "Content-Type: application/json" \
  -d '{"username":"testfarmer","password":"test123"}'
```

### Test Mobile App

1. **Install APK** on test device
2. **Login** with test account
3. **Register product** (takes photo, GPS, submit)
4. **Check backend** - product should appear in Django admin
5. **Test offline**:
   - Disconnect WiFi
   - Register another product
   - Should see "Queued for sync"
   - Reconnect WiFi
   - Product should auto-sync

### Test Smart Contract

```bash
# In Django shell
python manage.py shell

>>> from blockchain.web3_client import BlockchainService
>>> service = BlockchainService()
>>> service.add_product_block({
...     'product_id': 1,
...     'product_name': 'Test Beans',
...     'owner': 'farmer1'
... })
# Should return transaction hash
```

---

## 👥 Part 5: User Onboarding (200 Participants)

### Preparation (Before Week 8)

**1. Create Test Accounts (1 hour)**
```python
# In Django shell or create script
from users.models import User

# Create 100 farmer accounts
for i in range(1, 101):
    User.objects.create_user(
        username=f'farmer{i}',
        password='agritrace2025',  # Simple password for research
        user_type='farmer',
        first_name=f'Farmer{i}',
        email=f'farmer{i}@agritrace.rw'
    )

# Create 20 traders
# Create 25 processors
# Create 50 consumers
# Create 5 seed producers
```

**2. Prepare Installation Materials**
- ✅ APK file on USB drives
- ✅ Printed quick reference guide (1 page, Kinyarwanda)
- ✅ Training video (5 min, Kinyarwanda, uploaded to YouTube)
- ✅ Username/password list for each cooperative

**3. Set Up Support System**
- ✅ WhatsApp group for technical support
- ✅ Phone line for emergencies
- ✅ Field assistants with basic troubleshooting training

### Week 8 Training Sessions

**Day 1-2: Cooperative Leaders (15 people)**
- Deep training (2 hours)
- Make them "champions" who can help others
- Give them advance access

**Day 3-5: Farmers (100 people)**
- 4 sessions of 25 farmers each
- 1 hour training per session
- Hands-on practice with test devices

**Day 6-7: Traders & Processors (45 people)**
- 2 sessions
- Focus on purchasing and inventory features

**Week 9: Consumers (50 people)**
- Rolling onboarding at cooperatives
- Quick 15-minute training on QR scanning

### Training Agenda (1 hour session)

```
0:00-0:10: Welcome & Project Overview
0:10-0:20: App Installation (guided)
0:20-0:30: Login & Profile Setup
0:30-0:40: Core Feature Demo (register product)
0:40-0:50: Hands-on Practice
0:50-1:00: Q&A & Support Info
```

---

## 📊 Part 6: Monitoring & Maintenance

### Daily Checks (Weeks 8-10)

```bash
# SSH into server
ssh root@YOUR_SERVER_IP

# Check backend logs
tail -f /var/log/agritrace/error.log

# Check Django admin
# Go to: http://YOUR_SERVER_IP/admin

# Check research dashboard
# Verify transaction logs coming in
# Check error rates
# Monitor offline queue size
```

### Weekly Tasks

**1. Database Backup**
```bash
# Automated backup script
pg_dump agritrace_db > backup_week8.sql

# Upload to Google Drive or Dropbox
```

**2. Check Metrics**
```python
# Django shell
from analytics.models import ResearchDashboard
dashboard = ResearchDashboard.generate_weekly_dashboard(8)
print(f"Active users: {dashboard.active_participants}")
print(f"Transaction completion rate: {dashboard.avg_transaction_completion_rate}%")
print(f"Fraud rate: {dashboard.fraud_rate_pct}%")
```

**3. Respond to Support Requests**
- Check WhatsApp group daily
- Respond within 2 hours during business hours
- Document common issues

### Troubleshooting Common Issues

**"App won't connect"**
```bash
# Check backend is running
systemctl status agritrace

# Check logs
tail -f /var/log/agritrace/error.log

# Restart if needed
systemctl restart agritrace
```

**"QR scanner not working"**
- Check camera permission granted
- Try different lighting
- Clean camera lens

**"Offline sync not working"**
- Check internet connection
- Restart app
- Check backend logs for sync errors

---

## 💰 Cost Estimate (3-Month Research Period)

### Cloud Server (DigitalOcean/AWS)
- **Server**: $24/month × 3 = $72
- **Domain**: $12/year = $12
- **SSL**: Free (Let's Encrypt)
- **Total**: ~$84

### Smart Contract
- **Deployment**: 0.01 ETH (~free on testnet)
- **Gas fees**: 0.05 ETH (~free on testnet)
- **Total**: $0 (using testnet)

### Mobile Distribution
- **Google Play** (optional): $25 one-time
- **USB drives**: $30 for 10 drives
- **Total**: $25-55

### **Grand Total**: $109-$139 for 3 months

---

## ✅ Deployment Checklist

**Before Week 8:**
- [ ] Backend deployed to cloud server
- [ ] Database migrated and tested
- [ ] Smart contract deployed to Sepolia
- [ ] Flutter APK built with production config
- [ ] APK tested on 3+ devices
- [ ] Admin account created
- [ ] 200 user accounts created
- [ ] Training materials prepared
- [ ] Support systems in place

**Week 8 Day 1:**
- [ ] Train cooperative leaders
- [ ] Distribute APK to leaders
- [ ] Test with 5 early adopters

**Week 8 Days 2-7:**
- [ ] Conduct 6 training sessions
- [ ] 100 farmers onboarded
- [ ] 45 traders/processors onboarded
- [ ] Monitor system daily

**Week 9:**
- [ ] Onboard consumers
- [ ] Monitor usage patterns
- [ ] Fix any critical bugs
- [ ] Daily dashboard checks

---

## 🆘 Emergency Procedures

**If Backend Goes Down:**
```bash
# Quick restart
systemctl restart agritrace nginx

# If that doesn't work, check logs and redeploy
```

**If Major Bug Found:**
```bash
# Fix locally
cd e:\agritracerw\mobile
# Fix bug
flutter build apk --release

# Redistribute via WhatsApp
# Users can install over existing app
```

**If Database Corrupted:**
```bash
# Restore from latest backup
psql agritrace_db < backup_week8.sql
```

---

## 📞 Support Resources

**During Research Period:**
- **Technical Issues**: WhatsApp support group
- **Critical Bugs**: Your email/phone
- **User Questions**: Field assistants
- **Backend Issues**: Check logs first, then SSH

**After Hours:**
- Most issues can wait until morning
- Critical: Backend down → restart systemd service
- Critical: Data loss → restore from backup

---

## 🎓 Post-Research Considerations

**After 12 Weeks:**

**Option 1: Keep Running**
- Continue server subscription
- Maintain for participants who want to keep using
- Cost: $24/month ongoing

**Option 2: Archive & Shut Down**
- Export all research data
- Back up database
- Shut down server
- Keep code on GitHub

**Option 3: Hand Off to Organization**
- Train RAB or cooperative staff
- Transfer server ownership
- Provide documentation

---

## 🚀 Quick Start: Minimal Deployment (1 Day)

**If you need to deploy FAST:**

```bash
# Morning: Backend
1. Rent DigitalOcean droplet ($12)
2. Run deploy script (automated)
3. Create user accounts
4. Test API

# Afternoon: Mobile
1. Update app_config.dart with server IP
2. Build APK
3. Test on 2 devices
4. Copy to USB drives

# Evening: Smart Contract (Optional - can do later)
1. Deploy to Sepolia
2. Test one transaction

# Next Day: Start Training
```

---

**You're ready to deploy!** Start with backend, then mobile, then blockchain. Test each step thoroughly.

**Which deployment option works best for you?**
1. Cloud server (DigitalOcean/AWS)
2. Local server
3. Heroku

Let me know and I can guide you through step-by-step! 🚀
