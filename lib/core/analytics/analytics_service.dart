import 'package:firebase_analytics/firebase_analytics.dart';
import '../env/env_config.dart';
import '../../shared/services/logger_service.dart';

class AnalyticsService {
  static FirebaseAnalytics? _analytics;
  static FirebaseAnalyticsObserver? _observer;

  static FirebaseAnalytics get instance {
    _analytics ??= FirebaseAnalytics.instance;
    return _analytics!;
  }

  static FirebaseAnalyticsObserver get observer {
    _observer ??= FirebaseAnalyticsObserver(analytics: instance);
    return _observer!;
  }

  // Initialize analytics
  static Future<void> init() async {
    try {
      await instance.setAnalyticsCollectionEnabled(!EnvConfig.isDev);
      LoggerService.i('Analytics initialized');
    } catch (e) {
      LoggerService.e('Failed to initialize analytics', e);
    }
  }

  // Set user properties
  static Future<void> setUserId(String userId) async {
    try {
      await instance.setUserId(id: userId);
      LoggerService.d('User ID set: $userId');
    } catch (e) {
      LoggerService.e('Failed to set user ID', e);
    }
  }

  static Future<void> setUserProperty(String name, String value) async {
    try {
      await instance.setUserProperty(name: name, value: value);
      LoggerService.d('User property set: $name = $value');
    } catch (e) {
      LoggerService.e('Failed to set user property', e);
    }
  }

  // Track events
  static Future<void> logEvent(String name,
      [Map<String, Object>? parameters]) async {
    try {
      await instance.logEvent(name: name, parameters: parameters);
      LoggerService.d('Event logged: $name', parameters);
    } catch (e) {
      LoggerService.e('Failed to log event', e);
    }
  }

  // Predefined events
  static Future<void> logLogin(String method) async {
    await logEvent('login', {'login_method': method});
  }

  static Future<void> logSignUp(String method) async {
    await logEvent('sign_up', {'sign_up_method': method});
  }

  static Future<void> logLogout() async {
    await logEvent('logout');
  }

  static Future<void> logScreenView(
      String screenName, String screenClass) async {
    await logEvent('screen_view', {
      'screen_name': screenName,
      'screen_class': screenClass,
    });
  }

  static Future<void> logButtonClick(String buttonName, String location) async {
    await logEvent('button_click', {
      'button_name': buttonName,
      'location': location,
    });
  }

  static Future<void> logApiCall(
      String endpoint, String method, int statusCode) async {
    await logEvent('api_call', {
      'endpoint': endpoint,
      'method': method,
      'status_code': statusCode,
    });
  }

  static Future<void> logError(String error, String location) async {
    await logEvent('app_error', {
      'error': error,
      'location': location,
    });
  }

  // E-commerce events (if needed)
  static Future<void> logPurchase({
    required String transactionId,
    required double value,
    required String currency,
    List<Map<String, Object>>? items,
  }) async {
    await logEvent('purchase', {
      'transaction_id': transactionId,
      'value': value,
      'currency': currency,
      if (items != null) 'items': items,
    });
  }

  // Custom business events
  static Future<void> logFeatureUsage(String featureName) async {
    await logEvent('feature_usage', {'feature_name': featureName});
  }

  static Future<void> logSearchQuery(String query, int resultCount) async {
    await logEvent('search', {
      'search_query': query,
      'result_count': resultCount,
    });
  }

  static Future<void> logContentShare(
      String contentType, String contentId) async {
    await logEvent('share', {
      'content_type': contentType,
      'content_id': contentId,
    });
  }
}
