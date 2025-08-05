# Flutter Base Project Boilerplate

> A complete Flutter boilerplate with Clean Architecture, featuring all essential modules for production-ready applications.

## 🚀 Features

- **Clean Architecture** with feature-first organization
- **GoRouter** for type-safe navigation
- **BLoC** state management
- **Multi-language** support (EN/VI)
- **Dark/Light** theme with responsive design
- **Local Storage** (Hive + SQLite + SharedPreferences)
- **Network Layer** with Dio + error handling
- **Authentication** with JWT support
- **Logging & Analytics** integration
- **Testing** setup (Unit + Widget + Integration)
- **Environment** configuration (dev/prod)

## 📱 Quick Start

```bash
# Install dependencies
flutter pub get

# Generate code
flutter gen-l10n
flutter packages pub run build_runner build

# Run the app
flutter run
```

## 📖 Documentation

See [README.md](README.md) for detailed documentation.

## 🏗️ Project Structure

```
lib/
├── core/           # Core functionality
├── features/       # Feature modules
└── shared/         # Shared components
```

## 🤝 Contributing

1. Fork the project
2. Create your feature branch
3. Commit your changes
4. Push to the branch
5. Open a Pull Request

## 📄 License

MIT License - see LICENSE file for details.

---

Built with ❤️ using Flutter
