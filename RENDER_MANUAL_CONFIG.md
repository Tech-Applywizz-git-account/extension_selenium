# 🎯 RENDER MANUAL CONFIGURATION GUIDE

## Copy These Exact Settings into Render Dashboard

### 1. Go to Your Service Settings
https://dashboard.render.com/ → Select your service → Settings

### 2. Environment Section
```
Environment: Python
```

### 3. Build & Deploy Section

**Python Version:**
```
3.11.9
```

**Build Command:** (Copy exactly)
```bash
pip install --upgrade pip && pip install --only-binary=:all: -r requirements.txt
```

**Start Command:** (Copy exactly)
```bash
python3.11 -m uvicorn app:app --host 0.0.0.0 --port $PORT
```

### 4. Environment Variables

Click "Add Environment Variable" for each:

| Key | Value | Notes |
|-----|-------|-------|
| `AWS_ACCESS_KEY_ID` | `your-aws-key` | Your actual AWS access key |
| `AWS_SECRET_ACCESS_KEY` | `your-aws-secret` | Your actual AWS secret |
| `AWS_REGION` | `us-east-1` | Or your preferred region |
| `PATTERN_API_URL` | `your-api-url` | Optional - your pattern API |

### 5. Save Changes

Click **"Save Changes"** at the bottom

### 6. Manual Deploy

Go to "Manual Deploy" → Click **"Deploy latest commit"**

---

## 📋 Quick Copy-Paste

**Python Version:**
```
3.11.9
```

**Build Command:**
```
pip install --upgrade pip && pip install --only-binary=:all: -r requirements.txt
```

**Start Command:**
```
python3.11 -m uvicorn app:app --host 0.0.0.0 --port $PORT
```

---

## ✅ What to Look For in Logs

**GOOD:**
```
==> Installing Python version 3.11.9
==> Downloading pydantic-2.4.2-py3-none-any.whl
==> Downloading pydantic_core-2.10.1-cp311-cp311-manylinux
```

**BAD (shouldn't see anymore):**
```
==> Installing Python version 3.13
==> Preparing metadata (pyproject.toml)
==> maturin failed
```

---

## 🚀 After Configuration

1. Save all settings
2. Trigger manual deploy
3. Watch build logs
4. Verify health endpoint: `https://your-app.onrender.com/health`

---

**This WILL work with Python 3.11.9!** 🎉
