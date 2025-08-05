import '../env/env_config.dart';

class EnvironmentHelper {
  /// Initialize environment based on flavor or build mode
  static Future<void> initialize({String? flavor}) async {
    Environment env;

    // Determine environment based on flavor or default to dev
    switch (flavor?.toLowerCase()) {
      case 'prod':
      case 'production':
        env = Environment.prod;
        break;
      case 'dev':
      case 'development':
      default:
        env = Environment.dev;
        break;
    }

    await EnvConfig.loadEnv(env: env);
  }

  /// Get current environment name for display
  static String get environmentName {
    return EnvConfig.isDev ? 'Development' : 'Production';
  }

  /// Check if debug features should be enabled
  static bool get enableDebugFeatures {
    return EnvConfig.isDev;
  }
}
