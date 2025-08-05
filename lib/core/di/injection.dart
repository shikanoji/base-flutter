import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

// Core services
import '../network/api_client.dart';
import '../storage/hive_storage.dart';
import '../storage/database_manager.dart';
import '../../shared/services/logger_service.dart';

final GetIt sl = GetIt.instance;

/// Configure core dependencies following SOLID principles
Future<void> initDependencies() async {
  // External dependencies
  _registerExternalDependencies();

  // Core services
  await _registerCoreServices();

  LoggerService.i('Dependencies configured successfully');
}

void _registerExternalDependencies() {
  // Dio HTTP client - for future use with dependency injection
  sl.registerLazySingleton<Dio>(() {
    final dio = Dio();
    dio.options.connectTimeout = const Duration(seconds: 30);
    dio.options.receiveTimeout = const Duration(seconds: 30);
    return dio;
  });
}

Future<void> _registerCoreServices() async {
  // Network
  sl.registerLazySingleton<ApiClient>(() => ApiClient());

  // Storage
  sl.registerLazySingleton<HiveStorage>(() => HiveStorage());
  sl.registerLazySingleton<DatabaseManager>(() => DatabaseManager());

  // Initialize storage services
  try {
    await HiveStorage.init();
  } catch (e) {
    LoggerService.w('Failed to initialize Hive storage: $e');
  }

  try {
    // Initialize database if needed
    // await sl<DatabaseManager>().init();
  } catch (e) {
    LoggerService.w('Failed to initialize database: $e');
  }
}

/// Register feature-specific dependencies
/// Call this method when features are added
Future<void> registerFeatureDependencies() async {
  // This will be expanded when features are fully implemented
  LoggerService.i('Feature dependencies will be registered here');
}
