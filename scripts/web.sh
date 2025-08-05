#!/bin/bash

# Flutter Web Development Scripts
# Usage: ./scripts/web.sh [command]

case "$1" in
  "dev")
    echo "🚀 Starting Flutter web development server..."
    flutter run -d chrome --web-port=8080
    ;;
  "build")
    echo "🏗️ Building Flutter web app for production..."
    flutter build web --release
    ;;
  "serve")
    echo "📡 Serving built web app..."
    cd build/web && python -m http.server 8000
    ;;
  "analyze")
    echo "🔍 Analyzing Flutter web compatibility..."
    flutter analyze --web
    ;;
  "test")
    echo "🧪 Running web-specific tests..."
    flutter test --platform chrome
    ;;
  *)
    echo "Flutter Web Development Commands:"
    echo "  dev     - Start development server on Chrome"
    echo "  build   - Build for production"
    echo "  serve   - Serve built app locally"
    echo "  analyze - Check web compatibility"
    echo "  test    - Run tests on Chrome"
    echo ""
    echo "Usage: ./scripts/web.sh [command]"
    ;;
esac
