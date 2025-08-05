import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'core/di/injection.dart';
import 'core/env/env_config.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'core/analytics/analytics_service.dart';
import 'shared/services/logger_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    // Initialize environment configuration
    await EnvConfig.loadEnv(env: Environment.dev);

    // Configure dependency injection
    await initDependencies();

    // Initialize core services
    await _initializeCoreServices();

    // Set system UI overlay style
    _setSystemUIOverlayStyle();

    // Initialize error tracking (only in production)
    if (EnvConfig.isProd) {
      await SentryFlutter.init(
        (options) {
          options.dsn = EnvConfig.getValue('SENTRY_DSN');
          options.tracesSampleRate = 1.0;
          options.environment = EnvConfig.environment.name;
        },
        appRunner: () => runApp(const MyApp()),
      );
    } else {
      runApp(const MyApp());
    }
  } catch (error, stackTrace) {
    LoggerService.e('Failed to initialize app', error, stackTrace);
    runApp(const ErrorApp());
  }
}

Future<void> _initializeCoreServices() async {
  // Initialize logger
  LoggerService.init();

  // Initialize analytics if available
  try {
    await AnalyticsService.init();
  } catch (e) {
    LoggerService.w('Analytics service not available: $e');
  }

  LoggerService.i('Core services initialized successfully');
}

void _setSystemUIOverlayStyle() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: EnvConfig.appName,

      // Theme
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,

      // Routing
      routerConfig: AppRouter.router,
    );
  }
}

class ErrorApp extends StatelessWidget {
  const ErrorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App Error',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      home: const Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 64,
                color: Colors.red,
              ),
              SizedBox(height: 16),
              Text(
                'Application Failed to Initialize',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Please restart the application',
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
