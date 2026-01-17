# Render Deployment - Quick Start Script
# Run this script to commit and push all deployment fixes

Write-Host "🚀 Render Deployment - Quick Start" -ForegroundColor Cyan
Write-Host "="*60 -ForegroundColor Cyan

# Step 1: Show current status
Write-Host "`n📋 Step 1: Checking Git Status..." -ForegroundColor Yellow
git status --short

# Step 2: Add all changes
Write-Host "`n📦 Step 2: Adding all changes..." -ForegroundColor Yellow
git add .

# Step 3: Show what will be committed
Write-Host "`n📝 Step 3: Files to be committed:" -ForegroundColor Yellow
git status --short

# Step 4: Commit
Write-Host "`n💾 Step 4: Committing changes..." -ForegroundColor Yellow
git commit -m "Fix: Remove explicit pydantic-core for auto binary wheel selection

CRITICAL CHANGE:
- Removed pydantic-core==2.10.1 from requirements.txt
- Let pydantic 2.4.2 auto-install compatible binary wheel
- This prevents forced source compilation

IMPORTANT: You MUST configure Render manually:
- Python Version: 3.11.9
- Build Command: pip install --upgrade pip && pip install --only-binary=:all: -r requirements.txt
- Start Command: python3.11 -m uvicorn app:app --host 0.0.0.0 --port \$PORT

See RENDER_MANUAL_CONFIG.md for exact copy-paste commands."

# Step 5: Push to remote
Write-Host "`n🚀 Step 5: Pushing to remote..." -ForegroundColor Yellow
Write-Host "This will push to 'origin main'. Continue? (Y/N)" -ForegroundColor Yellow
$confirmation = Read-Host
if ($confirmation -eq 'Y' -or $confirmation -eq 'y') {
    git push origin main
    
    Write-Host "`n✅ SUCCESS! Changes pushed to GitHub" -ForegroundColor Green
    Write-Host "`n⚠️  CRITICAL NEXT STEP:" -ForegroundColor Red
    Write-Host "Render is NOT using your config files!" -ForegroundColor Red
    Write-Host "`n📋 You MUST manually configure Render:" -ForegroundColor Yellow
    Write-Host "1. Go to Render Dashboard → Your Service → Settings" -ForegroundColor White
    Write-Host "2. Set Python Version: 3.11.9" -ForegroundColor White
    Write-Host "3. Copy Build Command from RENDER_MANUAL_CONFIG.md" -ForegroundColor White
    Write-Host "4. Copy Start Command from RENDER_MANUAL_CONFIG.md" -ForegroundColor White
    Write-Host "5. Add AWS environment variables" -ForegroundColor White
    Write-Host "6. Save Changes → Manual Deploy" -ForegroundColor White
    Write-Host "`n📖 OPEN THIS FILE NOW: RENDER_MANUAL_CONFIG.md" -ForegroundColor Cyan
    Write-Host "It has exact copy-paste commands!" -ForegroundColor Cyan
}
else {
    Write-Host "`n⚠️ Push cancelled. Run 'git push origin main' when ready." -ForegroundColor Yellow
}

Write-Host "`n"
