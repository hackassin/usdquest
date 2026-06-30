@echo off
REM ============================================================
REM  USDQuest launcher
REM  Double-click this file to start the app and open it in your
REM  browser. Keep this window open while you use the app.
REM  Close the window (or press Ctrl+C) to stop the server.
REM ============================================================

cd /d "%~dp0"

set PORT=4173

REM --- Pick an available Python launcher (py, then python) ---
set PY=
where py >nul 2>nul && set PY=py
if "%PY%"=="" (
  where python >nul 2>nul && set PY=python
)

if "%PY%"=="" (
  echo.
  echo  Python was not found on your PATH.
  echo  Install Python from https://www.python.org/downloads/
  echo  ^(tick "Add Python to PATH" during setup^), then run this again.
  echo.
  pause
  exit /b 1
)

echo.
echo  Starting USDQuest at http://localhost:%PORT%
echo  Keep this window open. Close it to stop the app.
echo.

REM --- Open the browser shortly after the server starts ---
start "" "http://localhost:%PORT%"

REM --- Serve this folder (index.html) ---
%PY% -m http.server %PORT%
