@echo off
REM ============================================================
REM  USDQuest one-click redeploy
REM  Double-click to push your latest changes to GitHub Pages.
REM  Optional: run from a terminal with a message, e.g.
REM     redeploy.bat added new questions
REM ============================================================
cd /d "%~dp0"
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0redeploy.ps1" %*
echo.
pause
