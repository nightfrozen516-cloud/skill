# tools/expose-skills.ps1
# Expose skills under .agents/skills/ dynamically to the root of the shared folder

$ErrorActionPreference = "Stop"
$UserProfile = $env:USERPROFILE
$SharedDir = Join-Path -Path $UserProfile -ChildPath ".skills_shared"
$AgentsSkillsDir = Join-Path -Path $SharedDir -ChildPath ".agents\skills"

if (-not (Test-Path -Path $AgentsSkillsDir)) {
    Write-Warning "Directory $AgentsSkillsDir does not exist. No skills to expose."
    exit 0
}

Write-Host "========== Exposing Skills to Shared Root ==========" -ForegroundColor Cyan

$Skills = Get-ChildItem -Path $AgentsSkillsDir -Directory
foreach ($Skill in $Skills) {
    $RootPath = Join-Path -Path $SharedDir -ChildPath $Skill.Name
    
    if (Test-Path -Path $RootPath) {
        $Item = Get-Item -Path $RootPath
        if ($Item.Attributes -match "ReparsePoint") {
            continue
        } else {
            Write-Host "Physical directory already exists for $($Skill.Name). Skipping." -ForegroundColor Yellow
            continue
        }
    }
    
    Write-Host "Linking: $RootPath -> $($Skill.FullName)" -ForegroundColor Green
    New-Item -ItemType Junction -Path $RootPath -Value $Skill.FullName | Out-Null
}

Write-Host "========== Expose Completed! ==========" -ForegroundColor Cyan
