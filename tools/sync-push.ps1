# tools/sync-push.ps1
# Automatically push skills to GitHub dynamically

$ErrorActionPreference = "Stop"
$UserProfile = $env:USERPROFILE
$SharedDir = Join-Path -Path $UserProfile -ChildPath ".skills_shared"

Write-Host "========== Starting Git Sync & Push ==========" -ForegroundColor Cyan
Set-Location -Path $SharedDir

if (-not (Test-Path -Path (Join-Path $SharedDir ".git"))) {
    Write-Host "Initializing Git repository..." -ForegroundColor Green
    git init
    git branch -M main
}

Write-Host "Collecting changes..." -ForegroundColor Gray
git add .

$Status = git status --porcelain
if ([string]::IsNullOrWhiteSpace($Status)) {
    Write-Host "All skills are up to date. No commit needed." -ForegroundColor Green
    exit 0
}

$CommitMessage = "Sync skills: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
git commit -m $CommitMessage
Write-Host "Local commit created: $CommitMessage" -ForegroundColor Green

$Remote = git remote
if ($Remote -notcontains "origin") {
    Write-Warning "No remote origin configured! Please run:"
    Write-Warning "  git remote add origin <your-repo-url>"
} else {
    Write-Host "Pushing to remote GitHub repository..." -ForegroundColor Gray
    git push -u origin main
    Write-Host "Successfully pushed to GitHub!" -ForegroundColor Green
}
