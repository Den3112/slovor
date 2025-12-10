@echo off
echo ===========================================
echo   Slovor Development Server
echo ===========================================
echo.
echo Starting development server...
echo Open http://slovor.lndo.site in your browser
echo.
echo Press Ctrl+C to stop the server
echo.
lando ssh -c "cd slovor && npm run dev"
