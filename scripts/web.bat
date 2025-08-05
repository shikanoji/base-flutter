@echo off
REM Flutter Web Development Scripts for Windows
REM Usage: scripts\web.bat [command]

if "%1"=="dev" (
    echo 🚀 Starting Flutter web development server...
    flutter run -d chrome --web-port=8080
) else if "%1"=="build" (
    echo 🏗️ Building Flutter web app for production...
    flutter build web --release
) else if "%1"=="serve" (
    echo 📡 Serving built web app...
    cd build\web && python -m http.server 8000
) else if "%1"=="analyze" (
    echo 🔍 Analyzing Flutter web compatibility...
    flutter analyze
) else if "%1"=="test" (
    echo 🧪 Running web-specific tests...
    flutter test --platform chrome
) else (
    echo Flutter Web Development Commands:
    echo   dev     - Start development server on Chrome
    echo   build   - Build for production  
    echo   serve   - Serve built app locally
    echo   analyze - Check web compatibility
    echo   test    - Run tests on Chrome
    echo.
    echo Usage: scripts\web.bat [command]
)
