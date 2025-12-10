@echo off
echo ===========================================
echo   Slovor Project Setup
echo ===========================================
echo.
echo Pulling latest changes from GitHub...
git pull origin main
if errorlevel 1 (
    echo [WARNING] Git pull failed, continuing anyway...
)

echo.
echo Installing dependencies in Lando...
lando ssh -c "cd slovor && rm -rf node_modules package-lock.json && npm install --no-optional --legacy-peer-deps"
if errorlevel 1 (
    echo [ERROR] Installation failed!
    exit /b 1
)

echo.
echo Running quality checks...
call check.bat
if errorlevel 1 (
    echo [WARNING] Some checks failed!
)

echo.
echo ===========================================
echo   Setup complete! Ready to develop.
echo ===========================================
echo.
echo Run 'dev.bat' to start development server
echo.
