# tools/sync-pull.ps1
# Automatically pull latest skills from GitHub dynamically

$ErrorActionPreference = "Stop"
$UserProfile = $env:USERPROFILE
$SharedDir = Join-Path -Path $UserProfile -ChildPath ".skills_shared"

Write-Host "========== Starting Git Pull ==========" -ForegroundColor Cyan
Set-Location -Path $SharedDir

if (-not (Test-Path -Path (Join-Path $SharedDir ".git"))) {
    Write-Warning "Not a Git repository. Please clone or init first."
    exit 1
}

$Remote = git remote
if ($Remote -notcontains "origin") {
    Write-Warning "No remote origin configured! Please run: git remote add origin <URL>"
    exit 1
}

Write-Host "Pulling changes from GitHub..." -ForegroundColor Gray
git pull origin main
Write-Host "Pull completed successfully!" -ForegroundColor Green
