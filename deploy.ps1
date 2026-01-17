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
git commit -m "Fix: Force Python 3.11.9 and binary-only pip installation for Render

CRITICAL FIXES:
- Force Python 3.11.9 (prevent 3.13 which lacks wheels)
- Downgrade to pydantic 2.4.2 with guaranteed binary wheels
- Add pip.conf to force binary-only installation
- Add --only-binary=:all: flag to prevent ANY source compilation
- Update Procfile to use python3.11 explicitly

This eliminates ALL Rust/Cargo compilation requirements."

# Step 5: Push to remote
Write-Host "`n🚀 Step 5: Pushing to remote..." -ForegroundColor Yellow
Write-Host "This will push to 'origin main'. Continue? (Y/N)" -ForegroundColor Yellow
$confirmation = Read-Host
if ($confirmation -eq 'Y' -or $confirmation -eq 'y') {
    git push origin main
    
    Write-Host "`n✅ SUCCESS! Changes pushed to GitHub" -ForegroundColor Green
    Write-Host "`n📋 Next Steps:" -ForegroundColor Cyan
    Write-Host "1. Go to Render Dashboard: https://dashboard.render.com/" -ForegroundColor White
    Write-Host "2. Click 'New +' → 'Blueprint'" -ForegroundColor White
    Write-Host "3. Connect your GitHub repository" -ForegroundColor White
    Write-Host "4. Render will auto-detect render.yaml" -ForegroundColor White
    Write-Host "5. Add environment variables:" -ForegroundColor White
    Write-Host "   - AWS_ACCESS_KEY_ID" -ForegroundColor Gray
    Write-Host "   - AWS_SECRET_ACCESS_KEY" -ForegroundColor Gray
    Write-Host "   - PATTERN_API_URL (optional)" -ForegroundColor Gray
    Write-Host "6. Click 'Apply' to deploy" -ForegroundColor White
    Write-Host "`n📖 For detailed instructions, see RENDER_DEPLOY.md" -ForegroundColor Cyan
}
else {
    Write-Host "`n⚠️ Push cancelled. Run 'git push origin main' when ready." -ForegroundColor Yellow
}

Write-Host "`n"
