@echo off
setlocal enabledelayedexpansion

:: Get the project root directory (one level up from scripts folder)
set "ROOT_DIR=%~dp0.."
cd /d "%ROOT_DIR%"

echo ===================================================
echo      Starting Frontend and Backend Services
echo ===================================================

:: 1. Backend Setup & Start
echo [Backend] Checking backend configuration...
cd /d "%ROOT_DIR%\backend"

:: Look for virtual environment
set "VENV_PATH="
if exist ".venv\Scripts\activate.bat" (
    set "VENV_PATH=.venv\Scripts\activate.bat"
) else if exist "venv\Scripts\activate.bat" (
    set "VENV_PATH=venv\Scripts\activate.bat"
) else if exist "env\Scripts\activate.bat" (
    set "VENV_PATH=env\Scripts\activate.bat"
)

if not "%VENV_PATH%"=="" (
    echo [Backend] Virtual environment found: %VENV_PATH%
) else (
    echo [Backend] No virtual environment found. Using system python...
)

:: Start Backend in a separate window
echo [Backend] Starting server in a new window...
if not "%VENV_PATH%"=="" (
    start "Backend Server (FastAPI)" cmd /k "call %VENV_PATH% && python src/main.py"
) else (
    start "Backend Server (FastAPI)" cmd /k "python src/main.py"
)

:: 2. Frontend Setup & Start
echo [Frontend] Checking frontend dependencies...
cd /d "%ROOT_DIR%\frontend"

:: Check if we should use bun or npm
set "RUNNER=npm"
where bun >nul 2>nul
if %errorlevel% equ 0 (
    set "RUNNER=bun"
)

echo [Frontend] Detected runner: !RUNNER!

:: Install dependencies if node_modules is missing
if not exist "node_modules\" (
    echo [Frontend] node_modules not found. Installing dependencies using !RUNNER!...
    if "!RUNNER!"=="bun" (
        call bun install
    ) else (
        call npm install
    )
)

:: Start Frontend in a separate window
echo [Frontend] Starting dev server in a new window...
if "!RUNNER!"=="bun" (
    start "Frontend Dev (Vite)" cmd /k "bun run dev"
) else (
    start "Frontend Dev (Vite)" cmd /k "npm run dev"
)

echo ===================================================
echo Both services have been started in separate windows.
echo Close those windows to stop the servers.
echo ===================================================
pause
