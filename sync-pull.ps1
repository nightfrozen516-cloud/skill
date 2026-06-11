# sync-pull.ps1
# 自动从远程 Git 仓库拉取最新的技能文件

$ErrorActionPreference = "Stop"
$SharedDir = "C:\Users\12788\.skills_shared"

Write-Host "========== 开始从 Git 同步拉取技能 ==========" -ForegroundColor Cyan
Set-Location -Path $SharedDir

# 1. 检查是否初始化了 Git 仓库
if (-not (Test-Path -Path (Join-Path $SharedDir ".git"))) {
    Write-Warning "未检测到 Git 仓库。请先在这台电脑上克隆或初始化您的技能仓库。"
    exit 1
}

# 2. 检查是否关联了 remote origin
$Remote = git remote
if ($Remote -notcontains "origin") {
    Write-Warning "未关联远程仓库，无法执行拉取。请先执行 git remote add origin <URL>"
    exit 1
}

# 3. 执行拉取
Write-Host "正在从远程仓库拉取更新..." -ForegroundColor Gray
git pull origin main
Write-Host "技能拉取并同步完成！" -ForegroundColor Green
