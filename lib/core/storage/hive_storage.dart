import 'package:hive_flutter/hive_flutter.dart';
import '../constants/app_constants.dart';

class HiveStorage {
  static late Box _authBox;
  static late Box _userBox;
  static late Box _settingsBox;
  static late Box _cacheBox;

  static Future<void> init() async {
    await Hive.initFlutter();

    // Open boxes
    _authBox = await Hive.openBox(AppConstants.authBoxName);
    _userBox = await Hive.openBox(AppConstants.userBoxName);
    _settingsBox = await Hive.openBox(AppConstants.settingsBoxName);
    _cacheBox = await Hive.openBox(AppConstants.cacheBoxName);
  }

  // Auth Storage
  static Future<void> setAccessToken(String token) async {
    await _authBox.put(AppConstants.accessTokenKey, token);
  }

  static String? getAccessToken() {
    return _authBox.get(AppConstants.accessTokenKey);
  }

  static Future<void> setRefreshToken(String token) async {
    await _authBox.put(AppConstants.refreshTokenKey, token);
  }

  static String? getRefreshToken() {
    return _authBox.get(AppConstants.refreshTokenKey);
  }

  static Future<void> clearAuth() async {
    await _authBox.clear();
  }

  // User Storage
  static Future<void> setUserData(Map<String, dynamic> userData) async {
    await _userBox.put(AppConstants.userDataKey, userData);
  }

  static Map<String, dynamic>? getUserData() {
    return _userBox.get(AppConstants.userDataKey)?.cast<String, dynamic>();
  }

  static Future<void> clearUserData() async {
    await _userBox.clear();
  }

  // Settings Storage
  static Future<void> setLanguage(String language) async {
    await _settingsBox.put(AppConstants.languageKey, language);
  }

  static String getLanguage() {
    return _settingsBox.get(AppConstants.languageKey, defaultValue: 'en');
  }

  static Future<void> setTheme(String theme) async {
    await _settingsBox.put(AppConstants.themeKey, theme);
  }

  static String getTheme() {
    return _settingsBox.get(AppConstants.themeKey, defaultValue: 'light');
  }

  static Future<void> setFirstTime(bool isFirstTime) async {
    await _settingsBox.put(AppConstants.isFirstTimeKey, isFirstTime);
  }

  static bool isFirstTime() {
    return _settingsBox.get(AppConstants.isFirstTimeKey, defaultValue: true);
  }

  // Cache Storage
  static Future<void> setCacheData(String key, dynamic data,
      {Duration? expiry}) async {
    final cacheItem = {
      'data': data,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
      'expiry': expiry?.inMilliseconds,
    };
    await _cacheBox.put(key, cacheItem);
  }

  static T? getCacheData<T>(String key) {
    final cacheItem = _cacheBox.get(key);
    if (cacheItem == null) return null;

    final timestamp = cacheItem['timestamp'] as int;
    final expiry = cacheItem['expiry'] as int?;

    if (expiry != null) {
      final now = DateTime.now().millisecondsSinceEpoch;
      if (now - timestamp > expiry) {
        _cacheBox.delete(key);
        return null;
      }
    }

    return cacheItem['data'] as T?;
  }

  static Future<void> clearCache() async {
    await _cacheBox.clear();
  }

  static Future<void> clearAll() async {
    await Future.wait([
      _authBox.clear(),
      _userBox.clear(),
      _settingsBox.clear(),
      _cacheBox.clear(),
    ]);
  }
}
