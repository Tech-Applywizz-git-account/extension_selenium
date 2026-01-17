# 🚀 Render Deployment Checklist

## ✅ Pre-Deployment (Completed)

- [x] Fixed pydantic compilation issues
- [x] Updated requirements.txt with pre-built wheels
- [x] Created runtime.txt (Python 3.11.0)
- [x] Created Procfile for uvicorn
- [x] Created render.yaml for automated deployment
- [x] Enhanced .gitignore
- [x] Created deployment documentation
- [x] Created verification script

## 📦 Git Commit & Push (Action Required)

### Option 1: Use Automated Script (Recommended)
```powershell
.\deploy.ps1
```

### Option 2: Manual Commands
```bash
# 1. Stage all changes
git add .

# 2. Commit with descriptive message
git commit -m "Fix: Add Render deployment configuration and resolve pydantic compilation issues"

# 3. Push to remote
git push origin main
```

**Status:** ⏳ PENDING - Run one of the above options

## 🌐 Render Deployment (Action Required)

### Step 1: Access Render Dashboard
- [ ] Go to https://dashboard.render.com/
- [ ] Sign in to your account

### Step 2: Create New Service

#### Option A: Blueprint (Recommended)
- [ ] Click "New +" → "Blueprint"
- [ ] Connect your GitHub repository
- [ ] Select the repository: `extension_selenium`
- [ ] Render will auto-detect `render.yaml`
- [ ] Review the configuration

#### Option B: Manual Web Service
- [ ] Click "New +" → "Web Service"
- [ ] Connect your GitHub repository
- [ ] Configure:
  - Name: `extension-selenium-api`
  - Region: Oregon (or preferred)
  - Branch: `main`
  - Runtime: Python 3
  - Build Command: `pip install --upgrade pip && pip install -r requirements.txt`
  - Start Command: `uvicorn app:app --host 0.0.0.0 --port $PORT`

### Step 3: Configure Environment Variables
- [ ] Add `AWS_ACCESS_KEY_ID` (your AWS access key)
- [ ] Add `AWS_SECRET_ACCESS_KEY` (your AWS secret key)
- [ ] Add `AWS_REGION` (e.g., `us-east-1`)
- [ ] Add `PATTERN_API_URL` (optional - your pattern API URL)
- [ ] Add `PYTHON_VERSION` = `3.11.0`

### Step 4: Deploy
- [ ] Click "Create Web Service" or "Apply"
- [ ] Wait for build to complete (2-3 minutes)
- [ ] Check build logs for any errors

### Step 5: Verify Deployment
- [ ] Note your service URL: `https://your-app-name.onrender.com`
- [ ] Test health endpoint:
  ```bash
  curl https://your-app-name.onrender.com/health
  ```
- [ ] Expected response: `{"status": "ok", "service": "ai-service"}`

## 🧪 Testing (Post-Deployment)

### Health Check
```bash
curl https://your-app-name.onrender.com/health
```
**Expected:** `{"status": "ok", "service": "ai-service"}`

### Predict Endpoint
```bash
curl -X POST https://your-app-name.onrender.com/predict \
  -H "Content-Type: application/json" \
  -d '{
    "question": "What is your name?",
    "userProfile": {"firstName": "John", "lastName": "Doe"},
    "options": []
  }'
```

**Expected:** JSON response with answer, confidence, and reasoning

## 📊 Deployment Status

| Step | Status | Notes |
|------|--------|-------|
| Fix Dependencies | ✅ Complete | Pydantic 2.6.0 with pre-built wheels |
| Create Config Files | ✅ Complete | runtime.txt, Procfile, render.yaml |
| Update .gitignore | ✅ Complete | Python patterns added |
| Git Commit | ⏳ Pending | Run deploy.ps1 or manual commands |
| Git Push | ⏳ Pending | Push to origin main |
| Render Setup | ⏳ Pending | Create service on Render |
| Environment Vars | ⏳ Pending | Add AWS credentials |
| Deploy | ⏳ Pending | Click deploy button |
| Verify | ⏳ Pending | Test health endpoint |

## 🆘 Troubleshooting

### Build Fails
1. Check Render build logs
2. Verify Python version is 3.11.0
3. Ensure requirements.txt is correct
4. Check for typos in render.yaml

### App Won't Start
1. Check Render logs for startup errors
2. Verify Procfile command is correct
3. Ensure PORT environment variable is used
4. Check uvicorn is installed

### Health Endpoint Returns 404
1. Verify app is running (check Render logs)
2. Check URL is correct
3. Wait for cold start (15-30 seconds on free tier)

### AWS Bedrock Errors
1. Verify AWS credentials are set correctly
2. Check AWS region is correct
3. Ensure IAM user has Bedrock permissions
4. Test credentials locally first

## 📚 Documentation References

- **Deployment Guide:** `RENDER_DEPLOY.md`
- **Fix Summary:** `DEPLOYMENT_FIX_SUMMARY.md`
- **Verification Script:** `verify_deploy.py`

## 🎯 Success Criteria

✅ Build completes in 2-3 minutes
✅ No compilation errors
✅ Health endpoint returns 200 OK
✅ Predict endpoint accepts requests
✅ No read-only filesystem errors

## 📝 Notes

- **Free Tier:** Service spins down after 15 minutes of inactivity
- **Cold Starts:** First request after spin-down takes 30-60 seconds
- **Logs:** Available in Render Dashboard under "Logs" tab
- **Redeployment:** Push to main branch triggers automatic redeployment

---

**Last Updated:** 2026-01-17
**Status:** Ready for deployment
