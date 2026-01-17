# Render Deployment Guide

## Quick Deploy Steps

### 1. Push Changes to Git
```bash
git add .
git commit -m "Fix: Add Render deployment configuration"
git push origin main
```

### 2. Configure Render Service

#### Option A: Using render.yaml (Recommended)
1. Go to [Render Dashboard](https://dashboard.render.com/)
2. Click "New +" → "Blueprint"
3. Connect your GitHub repository
4. Render will automatically detect `render.yaml`
5. Set the following environment variables in Render Dashboard:
   - `AWS_ACCESS_KEY_ID` - Your AWS access key
   - `AWS_SECRET_ACCESS_KEY` - Your AWS secret key
   - `PATTERN_API_URL` - Your pattern API URL (optional)

#### Option B: Manual Setup
1. Go to [Render Dashboard](https://dashboard.render.com/)
2. Click "New +" → "Web Service"
3. Connect your GitHub repository
4. Configure:
   - **Name**: `extension-selenium-api`
   - **Region**: Oregon (or your preferred region)
   - **Branch**: `main`
   - **Runtime**: Python 3
   - **Build Command**: `pip install --upgrade pip && pip install -r requirements.txt`
   - **Start Command**: `uvicorn app:app --host 0.0.0.0 --port $PORT`
   - **Plan**: Free

5. Add Environment Variables:
   - `AWS_ACCESS_KEY_ID` - Your AWS access key
   - `AWS_SECRET_ACCESS_KEY` - Your AWS secret key
   - `AWS_REGION` - `us-east-1` (or your preferred region)
   - `PATTERN_API_URL` - Your pattern API URL (optional)
   - `PYTHON_VERSION` - `3.11.0`

6. Click "Create Web Service"

### 3. Verify Deployment

Once deployed, test your API:
```bash
curl https://your-app-name.onrender.com/health
```

Expected response:
```json
{"status": "ok", "service": "ai-service"}
```

## What Was Fixed

### 1. **Pydantic Version Issue**
- **Problem**: Pydantic 2.5.3 requires Rust/Cargo compilation
- **Solution**: Upgraded to Pydantic 2.6.0 with pre-built wheels
- **Added**: Explicit `pydantic-core` and `annotated-types` versions

### 2. **Python Runtime**
- **Added**: `runtime.txt` specifying Python 3.11.0
- **Benefit**: Ensures consistent Python version across deployments

### 3. **Process Configuration**
- **Added**: `Procfile` with proper uvicorn startup command
- **Benefit**: Tells Render how to start the application

### 4. **Deployment Configuration**
- **Added**: `render.yaml` for automated deployments
- **Benefit**: Infrastructure as code, consistent deployments

## Troubleshooting

### If deployment still fails:

1. **Check Render Logs**
   - Go to your service in Render Dashboard
   - Click "Logs" tab
   - Look for specific error messages

2. **Verify Environment Variables**
   - Ensure all required env vars are set
   - Check for typos in variable names

3. **Test Locally First**
   ```bash
   pip install -r requirements.txt
   uvicorn app:app --host 0.0.0.0 --port 8000
   ```

4. **Check Python Version**
   - Render should use Python 3.11.0 as specified in `runtime.txt`

## Important Notes

- **Free Tier**: Render free tier spins down after 15 minutes of inactivity
- **Cold Starts**: First request after spin-down may take 30-60 seconds
- **Environment Variables**: Never commit sensitive credentials to git
- **Region**: Oregon region is recommended for free tier

## API Endpoints

- `GET /health` - Health check endpoint
- `POST /predict` - AI prediction endpoint

## Support

If you encounter issues:
1. Check Render service logs
2. Verify all environment variables are set correctly
3. Ensure your AWS credentials have proper permissions for Bedrock
