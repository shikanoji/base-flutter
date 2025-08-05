# 🛠️ Development Guide

This guide contains detailed information for developers working on this Flutter project.

## 📋 Prerequisites

- **Flutter SDK**: 3.0+ 
- **Dart SDK**: 3.0+
- **IDE**: VS Code or Android Studio
- **Git**: Latest version

## 🚀 Getting Started

### 1. Clone & Setup
```bash
git clone <repository-url>
cd flutter_base_project_full
flutter pub get
```

### 2. Environment Configuration
```bash
# Copy environment template
cp .env.example .env.dev
cp .env.example .env.prod

# Edit with your actual values
code .env.dev
```

### 3. Code Generation
```bash
# Generate all code
flutter packages pub run build_runner build --delete-conflicting-outputs

# Watch mode during development
flutter packages pub run build_runner watch
```

### 4. Running the App

#### Mobile/Desktop
```bash
# List available devices
flutter devices

# Run on specific device
flutter run -d <device-id>

# Run on Android emulator
flutter run -d emulator-5554

# Run on iOS simulator
flutter run -d "iPhone 15 Pro"
```

#### Web Browser
```bash
# Enable web support (one-time setup)
flutter config --enable-web

# Run on Chrome
flutter run -d chrome

# Run on Chrome with specific port
flutter run -d chrome --web-port=8080

# Run on Edge
flutter run -d edge

# Build for web deployment
flutter build web --release
```

#### Development Tips
```bash
# Hot reload: Press 'r' in terminal
# Hot restart: Press 'R' in terminal
# Open DevTools: Press 'd' in terminal
# Quit: Press 'q' in terminal

# Run with verbose logging
flutter run -d chrome -v

# Run in profile mode
flutter run -d chrome --profile

# Run with specific renderer
flutter run -d chrome --web-renderer canvaskit
```

## 🏗️ Architecture Overview

This project follows **Clean Architecture** principles with clear separation of concerns:

### 🏛️ Domain Layer
- **Entities**: Business objects with no dependencies
- **Use Cases**: Business logic operations
- **Repositories**: Abstract contracts for data operations

### 📊 Data Layer
- **Models**: Data transfer objects with JSON serialization
- **Data Sources**: Remote (API) and Local (Storage) data access
- **Repository Implementations**: Concrete implementations of domain contracts

### 📱 Presentation Layer
- **BLoC**: State management with business logic components
- **Pages**: Full screen UI components
- **Widgets**: Reusable UI components

## 🔧 Development Workflow

### Adding New Features

1. **Create Feature Structure**
```bash
mkdir -p lib/features/new_feature/{data,domain,presentation}
mkdir -p lib/features/new_feature/data/{datasource,models,repository}
mkdir -p lib/features/new_feature/domain/{entities,repository,usecases}
mkdir -p lib/features/new_feature/presentation/{bloc,pages,widgets}
```

2. **Define Domain Layer**
```dart
// Entity
class UserEntity extends Equatable {
  final String id;
  final String name;
  final String email;
  
  const UserEntity({required this.id, required this.name, required this.email});
  
  @override
  List<Object> get props => [id, name, email];
}

// Repository Contract
abstract class UserRepository {
  Future<Either<Failure, UserEntity>> getUser(String id);
  Future<Either<Failure, List<UserEntity>>> getUsers();
}

// Use Case
class GetUserUseCase {
  final UserRepository repository;
  
  GetUserUseCase(this.repository);
  
  Future<Either<Failure, UserEntity>> call(String id) {
    return repository.getUser(id);
  }
}
```

3. **Implement Data Layer**
```dart
// Model with JSON serialization
@JsonSerializable()
class UserModel extends UserEntity {
  const UserModel({required super.id, required super.name, required super.email});
  
  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}

// Data Source
abstract class UserRemoteDataSource {
  Future<UserModel> getUser(String id);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final ApiClient apiClient;
  
  UserRemoteDataSourceImpl(this.apiClient);
  
  @override
  Future<UserModel> getUser(String id) async {
    final response = await apiClient.get('/users/$id');
    return UserModel.fromJson(response.data);
  }
}

// Repository Implementation
class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;
  final UserLocalDataSource localDataSource;
  
  UserRepositoryImpl({required this.remoteDataSource, required this.localDataSource});
  
  @override
  Future<Either<Failure, UserEntity>> getUser(String id) async {
    try {
      final user = await remoteDataSource.getUser(id);
      await localDataSource.cacheUser(user);
      return Right(user);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
```

4. **Create Presentation Layer**
```dart
// BLoC Events
abstract class UserEvent extends Equatable {}

class LoadUser extends UserEvent {
  final String userId;
  LoadUser(this.userId);
  
  @override
  List<Object> get props => [userId];
}

// BLoC States
abstract class UserState extends Equatable {}

class UserInitial extends UserState {
  @override
  List<Object> get props => [];
}

class UserLoading extends UserState {
  @override
  List<Object> get props => [];
}

class UserLoaded extends UserState {
  final UserEntity user;
  UserLoaded(this.user);
  
  @override
  List<Object> get props => [user];
}

class UserError extends UserState {
  final String message;
  UserError(this.message);
  
  @override
  List<Object> get props => [message];
}

// BLoC
class UserBloc extends Bloc<UserEvent, UserState> {
  final GetUserUseCase getUserUseCase;
  
  UserBloc({required this.getUserUseCase}) : super(UserInitial()) {
    on<LoadUser>(_onLoadUser);
  }
  
  Future<void> _onLoadUser(LoadUser event, Emitter<UserState> emit) async {
    emit(UserLoading());
    
    final result = await getUserUseCase(event.userId);
    
    result.fold(
      (failure) => emit(UserError(failure.message)),
      (user) => emit(UserLoaded(user)),
    );
  }
}
```

5. **Register Dependencies**
```dart
// In injection.dart
void _registerUserFeature() {
  // Data sources
  sl.registerLazySingleton<UserRemoteDataSource>(
    () => UserRemoteDataSourceImpl(sl<ApiClient>()),
  );
  
  // Repositories
  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(
      remoteDataSource: sl<UserRemoteDataSource>(),
      localDataSource: sl<UserLocalDataSource>(),
    ),
  );
  
  // Use cases
  sl.registerLazySingleton(() => GetUserUseCase(sl<UserRepository>()));
  
  // BLoCs
  sl.registerFactory(() => UserBloc(getUserUseCase: sl<GetUserUseCase>()));
}
```

## 🧪 Testing Strategy

### Unit Tests
```dart
// Test use cases
group('GetUserUseCase', () {
  late GetUserUseCase useCase;
  late MockUserRepository mockRepository;
  
  setUp(() {
    mockRepository = MockUserRepository();
    useCase = GetUserUseCase(mockRepository);
  });
  
  test('should return user when repository call is successful', () async {
    // Arrange
    const user = UserEntity(id: '1', name: 'John', email: 'john@example.com');
    when(() => mockRepository.getUser('1')).thenAnswer((_) async => const Right(user));
    
    // Act
    final result = await useCase('1');
    
    // Assert
    expect(result, const Right(user));
    verify(() => mockRepository.getUser('1')).called(1);
  });
});
```

### Widget Tests
```dart
// Test widgets
testWidgets('UserPage should display user data', (tester) async {
  // Arrange
  const user = UserEntity(id: '1', name: 'John', email: 'john@example.com');
  
  await tester.pumpWidget(
    MaterialApp(
      home: BlocProvider<UserBloc>(
        create: (_) => MockUserBloc()..add(LoadUser('1')),
        child: const UserPage(),
      ),
    ),
  );
  
  // Act
  await tester.pump();
  
  // Assert
  expect(find.text('John'), findsOneWidget);
  expect(find.text('john@example.com'), findsOneWidget);
});
```

### Integration Tests
```bash
# Run all tests
flutter test

# Run with coverage
flutter test --coverage
genhtml coverage/lcov.info -o coverage/html
```

## 📚 Useful Resources

- [Flutter Documentation](https://docs.flutter.dev/)
- [Dart Language Tour](https://dart.dev/guides/language/language-tour)
- [Clean Architecture Guide](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- [BLoC Pattern Documentation](https://bloclibrary.dev/)
- [GoRouter Documentation](https://pub.dev/documentation/go_router/latest/)

---

**Happy Coding! 🚀**
