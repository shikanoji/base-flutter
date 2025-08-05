import 'package:flutter_dotenv/flutter_dotenv.dart';

enum Environment { dev, prod }

class EnvConfig {
  static Environment _environment = Environment.dev;

  static Environment get environment => _environment;

  static Future<void> loadEnv({Environment env = Environment.dev}) async {
    _environment = env;

    String envFile;
    switch (env) {
      case Environment.dev:
        envFile = '.env.dev';
        break;
      case Environment.prod:
        envFile = '.env.prod';
        break;
    }

    await dotenv.load(fileName: envFile);
  }

  // API Configuration
  static String get apiBaseUrl => dotenv.env['API_BASE_URL'] ?? '';
  static int get apiTimeout =>
      int.tryParse(dotenv.env['API_TIMEOUT'] ?? '30000') ?? 30000;

  // App Configuration
  static String get appName => dotenv.env['APP_NAME'] ?? 'Flutter App';
  static String get logLevel => dotenv.env['LOG_LEVEL'] ?? 'INFO';

  // Helper methods
  static bool get isDev => _environment == Environment.dev;
  static bool get isProd => _environment == Environment.prod;

  static String getValue(String key, {String defaultValue = ''}) {
    return dotenv.env[key] ?? defaultValue;
  }
}
