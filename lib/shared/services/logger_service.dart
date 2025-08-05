import 'package:logger/logger.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import '../../core/env/env_config.dart';

class LoggerService {
  static late Logger _logger;
  static bool _isInitialized = false;

  static Logger get instance {
    if (!_isInitialized) {
      init();
    }
    return _logger;
  }

  static void init() {
    _logger = Logger(
      filter: _CustomLogFilter(),
      printer: PrettyPrinter(
        methodCount: 2,
        errorMethodCount: 8,
        lineLength: 120,
        colors: true,
        printEmojis: true,
        printTime: true,
      ),
      output: _CustomLogOutput(),
    );
    _isInitialized = true;
  }

  // Convenience methods
  static void d(String message, [dynamic error, StackTrace? stackTrace]) {
    instance.d(message, error: error, stackTrace: stackTrace);
  }

  static void i(String message, [dynamic error, StackTrace? stackTrace]) {
    instance.i(message, error: error, stackTrace: stackTrace);
  }

  static void w(String message, [dynamic error, StackTrace? stackTrace]) {
    instance.w(message, error: error, stackTrace: stackTrace);
  }

  static void e(String message, [dynamic error, StackTrace? stackTrace]) {
    instance.e(message, error: error, stackTrace: stackTrace);

    // Send to Sentry in production
    if (EnvConfig.isProd && error != null) {
      Sentry.captureException(
        error,
        stackTrace: stackTrace,
        hint: Hint.withMap({
          'message': message,
        }),
      );
    }
  }

  static void wtf(String message, [dynamic error, StackTrace? stackTrace]) {
    instance.f(message, error: error, stackTrace: stackTrace);

    // Always send fatal errors to Sentry
    if (error != null) {
      Sentry.captureException(
        error,
        stackTrace: stackTrace,
        hint: Hint.withMap({
          'message': message,
          'level': 'fatal',
        }),
      );
    }
  }

  // Log API requests/responses
  static void logApiRequest(
      String method, String url, Map<String, dynamic>? data) {
    if (EnvConfig.isDev) {
      d('API Request: $method $url', data);
    }
  }

  static void logApiResponse(String url, int statusCode, dynamic data) {
    if (EnvConfig.isDev) {
      if (statusCode >= 200 && statusCode < 300) {
        d('API Response: $url ($statusCode)', data);
      } else {
        e('API Error: $url ($statusCode)', data);
      }
    }
  }

  // Log user actions
  static void logUserAction(String action, Map<String, dynamic>? parameters) {
    i('User Action: $action', parameters);
  }

  // Log navigation
  static void logNavigation(String from, String to) {
    d('Navigation: $from -> $to');
  }
}

class _CustomLogFilter extends LogFilter {
  @override
  bool shouldLog(LogEvent event) {
    // Only log in debug mode or if explicitly enabled
    if (EnvConfig.isDev) return true;

    // In production, only log warnings, errors, and fatal
    return event.level.value >= Level.warning.value;
  }
}

class _CustomLogOutput extends LogOutput {
  @override
  void output(OutputEvent event) {
    // Default console output
    for (final line in event.lines) {
      print(line);
    }

    // TODO: Implement file logging or remote logging here
    // _writeToFile(event.lines);
  }
}
