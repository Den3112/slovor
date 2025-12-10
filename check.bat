@echo off
echo ===========================================
echo   Slovor Quality Check
echo ===========================================
echo.
echo Running TypeScript check...
lando ssh -c "cd slovor && npm run typecheck"
if errorlevel 1 (
    echo [ERROR] TypeScript check failed!
    exit /b 1
)

echo.
echo Running ESLint...
lando ssh -c "cd slovor && npm run lint"
if errorlevel 1 (
    echo [ERROR] ESLint check failed!
    exit /b 1
)

echo.
echo Building for production...
lando ssh -c "cd slovor && npm run build"
if errorlevel 1 (
    echo [ERROR] Build failed!
    exit /b 1
)

echo.
echo ===========================================
echo   All checks passed! Project is ready.
echo ===========================================
