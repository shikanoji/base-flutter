# 🚀 Flutter Base Project - Production Ready Boilerplate

[![Flutter Version](https://img.shields.io/badge/Flutter-3.0+-blue.svg)](https://flutter.dev/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Maintenance](https://img.shields.io/badge/Maintained%3F-yes-green.svg)](https://github.com/your-repo/graphs/commit-activity)

A comprehensive Flutter boilerplate following **Clean Architecture** principles with production-ready features and modern development practices.

## ✨ Key Features

| Feature | Status | Description |
|---------|--------|-------------|
| 🏗️ **Clean Architecture** | ✅ | Domain, Data, Presentation layers |
| 🧭 **GoRouter Navigation** | ✅ | Type-safe routing with analytics |
| 🌍 **Environment Config** | ✅ | Multi-environment support |
| 📱 **State Management** | ✅ | BLoC pattern with Equatable |
| 💉 **Dependency Injection** | ✅ | GetIt with service locator |
| 💾 **Multi-Storage** | ✅ | Hive + SQLite + SharedPreferences |
| 🌐 **Network Layer** | ✅ | Dio with interceptors |
| 🔐 **Authentication** | ✅ | JWT ready implementation |
| 🎨 **Theming System** | ✅ | Light/Dark with Material 3 |
| 🌏 **Localization** | ✅ | i18n ready (EN/VI) |
| 📊 **Analytics & Logging** | ✅ | Firebase + Sentry + Logger |
| 🧪 **Testing Framework** | ✅ | Unit + Widget + Integration |
| 🎯 **Custom Components** | ✅ | Reusable UI library |

## 📁 Project Architecture

```
📦 lib/
├── 🏗️ core/                     # Core Infrastructure
│   ├── 📊 analytics/             # Analytics & tracking
│   ├── 🔧 constants/             # App-wide constants
│   ├── 💉 di/                    # Dependency injection setup
│   ├── 🌍 env/                   # Environment configuration
│   ├── ❌ error/                 # Error handling & exceptions
│   ├── 🌐 network/              # HTTP client & interceptors
│   ├── 🧭 router/               # Navigation configuration
│   ├── 💾 storage/              # Local storage abstractions
│   ├── 🎨 theme/                # Theming & styling system
│   └── 🛠️ utils/                # Utility functions
├── 🎯 features/                  # Feature Modules
│   ├── 🔐 auth/                 # Authentication
│   │   ├── 📊 data/             # Data sources & repositories
│   │   ├── 🏛️ domain/           # Business logic & entities
│   │   └── 📱 presentation/     # UI & state management
│   ├── 🏠 home/                 # Home feature
│   └── ⚙️ settings/             # App settings
└── 🔄 shared/                   # Shared Components
    ├── 🔧 extensions/           # Dart extensions
    ├── 🛠️ services/             # Global services
    └── 🎨 widgets/              # Reusable UI components
```

## 🚀 Quick Start

### 1. Cài đặt dependencies
```bash
flutter pub get
```

### 2. Generate code
```bash
# Generate localization files
flutter gen-l10n

# Generate injectable dependencies
flutter packages pub run build_runner build --delete-conflicting-outputs
```

### 3. Chạy ứng dụng
```bash
# Development
flutter run --dart-define=FLAVOR=dev

# Production
flutter run --dart-define=FLAVOR=prod --release
```

## 🔧 Cấu hình

### Environment Variables

Tạo các file environment trong root project:

**.env** (Default)
```env
API_BASE_URL=https://api.example.com
API_TIMEOUT=30000
APP_NAME=Flutter Base Project
LOG_LEVEL=INFO
```

**.env.dev** (Development)
```env
API_BASE_URL=https://dev-api.example.com
API_TIMEOUT=30000
APP_NAME=Flutter Base Project (DEV)
LOG_LEVEL=DEBUG
```

**.env.prod** (Production)
```env
API_BASE_URL=https://prod-api.example.com
API_TIMEOUT=30000
APP_NAME=Flutter Base Project
LOG_LEVEL=ERROR
```

### Firebase Configuration (Optional)

1. Tạo project trên Firebase Console
2. Download `google-services.json` (Android) và `GoogleService-Info.plist` (iOS)
3. Đặt vào thư mục tương ứng
4. Cấu hình Analytics và Crashlytics

## 📚 Hướng dẫn sử dụng

### State Management với BLoC
```dart
// 1. Tạo Events
abstract class HomeEvent extends Equatable {}

class LoadHomeData extends HomeEvent {
  @override
  List<Object> get props => [];
}

// 2. Tạo States  
abstract class HomeState extends Equatable {}

class HomeLoading extends HomeState {
  @override
  List<Object> get props => [];
}

// 3. Tạo BLoC
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetHomeDataUseCase getHomeDataUseCase;
  
  HomeBloc({required this.getHomeDataUseCase}) : super(HomeInitial()) {
    on<LoadHomeData>(_onLoadHomeData);
  }
}

// 4. Sử dụng trong UI
BlocBuilder<HomeBloc, HomeState>(
  builder: (context, state) {
    if (state is HomeLoading) {
      return const CircularProgressIndicator();
    }
    // Handle other states...
  },
)
```

### Navigation với GoRouter
```dart
// Định nghĩa routes
class AppRouter {
  static const String loginRoute = '/login';
  static const String homeRoute = '/home';
  
  static final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: loginRoute,
        builder: (context, state) => const LoginPage(),
      ),
    ],
  );
}

// Navigation
context.go(AppRouter.homeRoute);
context.goNamed('profile', pathParameters: {'id': userId});
```

### API Calls
```dart
// Repository implementation
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;
  
  @override
  Future<Either<Failure, UserEntity>> login(String email, String password) async {
    try {
      final result = await remoteDataSource.login(email, password);
      await localDataSource.cacheUser(result);
      return Right(result.toEntity());
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
```

### Local Storage
```dart
// Hive Storage
await HiveStorage.setAccessToken(token);
String? token = HiveStorage.getAccessToken();

// Cache với expiry
await HiveStorage.setCacheData('key', data, expiry: Duration(hours: 1));
final cachedData = HiveStorage.getCacheData<MyData>('key');

// SQLite
await DatabaseManager.insert('users', userData);
final users = await DatabaseManager.query('users');
```

### Localization
```dart
// Trong UI
Text(S.of(context).login);
Text(S.of(context).welcome(appName));

// Format theo locale
String formattedDate = LocalizationService.formatDate(DateTime.now(), context);
String formattedCurrency = LocalizationService.formatCurrency(1000, context);
```

### Custom Widgets
```dart
// Custom Button
CustomButton(
  text: 'Login',
  type: ButtonType.primary,
  isLoading: isLoading,
  onPressed: () => _handleLogin(),
)

// Custom Input
CustomInput(
  label: 'Email',
  type: InputType.email,
  controller: emailController,
  validator: (value) => value?.isEmpty == true ? 'Required' : null,
)
```

### Theme Management
```dart
// Switch theme
context.read<ThemeCubit>().changeTheme(AppThemeMode.dark);

// Responsive design với ScreenUtil
Container(
  width: 200.w,          // Responsive width
  height: 100.h,         // Responsive height
  padding: EdgeInsets.all(16.r), // Responsive padding
)
```

### Logging & Analytics
```dart
// Logging
LoggerService.i('Info message');
LoggerService.e('Error message', error, stackTrace);

// Analytics
AnalyticsService.logScreenView('Home', 'HomePage');
AnalyticsService.logButtonClick('login_btn', 'LoginPage');
AnalyticsService.logEvent('custom_event', {'key': 'value'});
```

## 🧪 Testing

### Unit Tests
```bash
flutter test
```

### Widget Tests
```bash
flutter test test/widget_test.dart
```

### Integration Tests
```bash
flutter test integration_test/
```

### Test Coverage
```bash
flutter test --coverage
genhtml coverage/lcov.info -o coverage/html
```

## 📦 Build & Deploy

### Android
```bash
# Debug APK
flutter build apk --debug

# Release APK
flutter build apk --release

# App Bundle
flutter build appbundle --release
```

### iOS
```bash
# Debug
flutter build ios --debug

# Release
flutter build ios --release
```

### Web
```bash
flutter build web --release
```

## 🛠️ Development Tools

### Code Generation
```bash
# Build runner (Injectable, Hive, etc.)
flutter packages pub run build_runner build

# Watch mode
flutter packages pub run build_runner watch
```

### Code Analysis
```bash
# Analyze code
flutter analyze

# Format code
dart format .

# Fix imports
dart fix --apply
```

## 📋 Checklist cho dự án mới

- [ ] Cập nhật `pubspec.yaml` với thông tin dự án
- [ ] Cấu hình environment variables
- [ ] Setup Firebase (nếu cần)
- [ ] Cấu hình Sentry (nếu cần)
- [ ] Thêm app icons và splash screen
- [ ] Cấu hình CI/CD
- [ ] Setup code signing (iOS/Android)
- [ ] Thêm unit tests cho business logic
- [ ] Cấu hình analytics events
- [ ] Review và update dependencies

## 🤝 Contributing

1. Fork project
2. Tạo feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to branch (`git push origin feature/AmazingFeature`)
5. Tạo Pull Request

## 📄 License

Distributed under the MIT License. See `LICENSE` for more information.

## 🆘 Support

Nếu gặp vấn đề hoặc có câu hỏi, vui lòng tạo issue trên GitHub repository.

---

**Happy Coding! 🚀**
