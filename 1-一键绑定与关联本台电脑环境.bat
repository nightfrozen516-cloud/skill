@echo off
:: 使用 PowerShell 脚本以 Bypass 策略运行环境配置与技能平铺
echo ====================================================
echo 正在绑定本地各 AI 客户端技能目录，并关联所有技能...
echo ====================================================
powershell -ExecutionPolicy Bypass -File "%~dp0tools\setup-shared-skills.ps1"
powershell -ExecutionPolicy Bypass -File "%~dp0tools\expose-skills.ps1"
echo.
echo 环境配置完成！任意 AI 客户端（Claude, Codex, Antigravity）已可直接通用调用。
pause
