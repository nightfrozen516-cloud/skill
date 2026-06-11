@echo off
echo ====================================================
echo 正在从 GitHub 云端拉取最新更新的技能并关联...
echo ====================================================
powershell -ExecutionPolicy Bypass -File "%~dp0tools\sync-pull.ps1"
powershell -ExecutionPolicy Bypass -File "%~dp0tools\expose-skills.ps1"
echo.
echo 拉取并应用技能完成！
pause
