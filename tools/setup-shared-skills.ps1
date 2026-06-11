# tools/setup-shared-skills.ps1
# Setup shared skills directory dynamically for any user on Windows

$ErrorActionPreference = "Stop"

# Use environmental variable to dynamically get current user profile path
$UserProfile = $env:USERPROFILE
$SharedDir = Join-Path -Path $UserProfile -ChildPath ".skills_shared"

$TargetPaths = @(
    Join-Path -Path $UserProfile -ChildPath ".codex\skills",
    Join-Path -Path $UserProfile -ChildPath ".claude\skills",
    Join-Path -Path $UserProfile -ChildPath ".gemini\antigravity\skills",
    Join-Path -Path $UserProfile -ChildPath ".gemini\config\skills"
)

Write-Host "========== Starting Shared Skills Setup ==========" -ForegroundColor Cyan

# 1. Ensure shared directory exists
if (-not (Test-Path -Path $SharedDir)) {
    Write-Host "Creating shared directory: $SharedDir" -ForegroundColor Green
    New-Item -ItemType Directory -Path $SharedDir | Out-Null
} else {
    Write-Host "Shared directory already exists: $SharedDir" -ForegroundColor Gray
}

# 2. Loop and link target skills paths
foreach ($Path in $TargetPaths) {
    Write-Host "`nProcessing path: $Path" -ForegroundColor Yellow

    $ParentDir = Split-Path -Path $Path -Parent
    if (-not (Test-Path -Path $ParentDir)) {
        Write-Host "Creating parent directory: $ParentDir" -ForegroundColor Green
        New-Item -ItemType Directory -Path $ParentDir | Out-Null
    }

    if (Test-Path -Path $Path) {
        $Item = Get-Item -Path $Path
        if ($Item.Attributes -match "ReparsePoint") {
            Write-Host "Path is already a symlink/junction. Skipping." -ForegroundColor Gray
            continue
        }

        # Backup & merge files if directory exists
        Write-Host "Moving existing files to shared directory..." -ForegroundColor Magenta
        $Files = Get-ChildItem -Path $Path -Force
        foreach ($File in $Files) {
            $DestPath = Join-Path -Path $SharedDir -ChildPath $File.Name
            if (-not (Test-Path -Path $DestPath)) {
                Copy-Item -Path $File.FullName -Destination $DestPath -Recurse -Force
            }
        }
        Remove-Item -Path $Path -Recurse -Force
        Write-Host "Original directory cleared and merged." -ForegroundColor Green
    }

    # Create link
    Write-Host "Creating Junction: $Path -> $SharedDir" -ForegroundColor Green
    New-Item -ItemType Junction -Path $Path -Value $SharedDir | Out-Null
}

Write-Host "`n========== Shared Skills Setup Completed! ==========" -ForegroundColor Cyan
