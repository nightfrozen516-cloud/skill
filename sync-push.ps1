# sync-push.ps1
# 自动将本台电脑上更新的技能推送到远程 Git 仓库中

$ErrorActionPreference = "Stop"
$SharedDir = "C:\Users\12788\.skills_shared"

Write-Host "========== 开始同步并推送技能至 Git ==========" -ForegroundColor Cyan
Set-Location -Path $SharedDir

# 1. 检查是否初始化了 Git 仓库
if (-not (Test-Path -Path (Join-Path $SharedDir ".git"))) {
    Write-Host "正在初始化 Git 仓库..." -ForegroundColor Green
    git init
    git branch -M main
}

# 2. 添加并提交文件
Write-Host "正在收集技能文件更改..." -ForegroundColor Gray
git add .

# 检查是否有需要提交的更改
$Status = git status --porcelain
if ([string]::IsNullOrWhiteSpace($Status)) {
    Write-Host "所有技能已是最新，无需同步。" -ForegroundColor Green
    exit 0
}

$CommitMessage = "Sync skills: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
git commit -m $CommitMessage
Write-Host "本地提交成功: $CommitMessage" -ForegroundColor Green

# 3. 推送至远程仓库
# 检查是否关联了 remote origin
$Remote = git remote
if ($Remote -notcontains "origin") {
    Write-Host "`n[提示]：您尚未关联远程 Git 仓库（如 GitHub/Gitee 私有仓库）。" -ForegroundColor Yellow
    Write-Host "请在当前目录下执行命令关联仓库：" -ForegroundColor Yellow
    Write-Host "  git remote add origin <您的私有仓库URL>" -ForegroundColor Yellow
    Write-Host "关联后再次运行此脚本即可自动推送同步。" -ForegroundColor Yellow
} else {
    Write-Host "正在推送到远程仓库..." -ForegroundColor Gray
    git push -u origin main
    Write-Host "技能云端推送完成！" -ForegroundColor Green
}
