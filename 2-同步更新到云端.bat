@echo off
echo ====================================================
echo 正在将本地修改与新增的技能同步上传至 GitHub 云端...
echo ====================================================
powershell -ExecutionPolicy Bypass -File "%~dp0tools\sync-push.ps1"
echo.
echo 同步推送完成。
pause
