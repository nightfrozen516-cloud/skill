# install-skills.ps1
# Batch install requested and recommended skills

$SkillsToInstall = @(
    "eze-is/web-access@web-access",
    "op7418/humanizer-zh@humanizer-zh",
    "jimliu/baoyu-skills@baoyu-image-gen",
    "jimliu/baoyu-skills@baoyu-url-to-markdown",
    "jimliu/baoyu-skills@baoyu-translate",
    "jimliu/baoyu-skills@baoyu-markdown-to-html",
    "jimliu/baoyu-skills@baoyu-infographic",
    "bytedance/deer-flow@github-deep-research",
    "bytedance/deer-flow@ppt-generation",
    "bytedance/deer-flow@image-generation",
    "letta-ai/skills@letta-api-client",
    "google-labs-code/stitch-skills@enhance-prompt",
    "cloudflare/skills@wrangler"
)

Write-Host "========== Starting Batch Skill Installation ==========" -ForegroundColor Cyan
Write-Host "This might take a few minutes as packages are downloaded..." -ForegroundColor Gray

foreach ($Skill in $SkillsToInstall) {
    Write-Host "`n[+] Installing skill: $Skill ..." -ForegroundColor Yellow
    try {
        npx.cmd skills add $Skill
        Write-Host "Successfully installed $Skill!" -ForegroundColor Green
    } catch {
        Write-Warning "Failed to install $Skill. Skipping. Error: $_"
    }
}

Write-Host "`n========== Batch Skill Installation Completed! ==========" -ForegroundColor Cyan
