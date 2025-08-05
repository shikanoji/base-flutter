class AppConstants {
  // App Info
  static const String appName = 'Flutter Base Project';
  static const String appVersion = '1.0.0';

  // API Constants
  static const int apiTimeoutDuration = 30000; // 30 seconds
  static const int connectTimeoutDuration = 15000; // 15 seconds
  static const int receiveTimeoutDuration = 30000; // 30 seconds

  // Storage Keys
  static const String accessTokenKey = 'access_token';
  static const String refreshTokenKey = 'refresh_token';
  static const String userDataKey = 'user_data';
  static const String languageKey = 'language';
  static const String themeKey = 'theme';
  static const String isFirstTimeKey = 'is_first_time';

  // Hive Box Names
  static const String authBoxName = 'auth_box';
  static const String userBoxName = 'user_box';
  static const String settingsBoxName = 'settings_box';
  static const String cacheBoxName = 'cache_box';

  // Pagination
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;

  // Animation Durations
  static const Duration shortAnimationDuration = Duration(milliseconds: 200);
  static const Duration mediumAnimationDuration = Duration(milliseconds: 400);
  static const Duration longAnimationDuration = Duration(milliseconds: 600);

  // Image Sizes
  static const double thumbnailSize = 50.0;
  static const double smallImageSize = 100.0;
  static const double mediumImageSize = 200.0;
  static const double largeImageSize = 400.0;

  // Spacing
  static const double smallSpacing = 8.0;
  static const double mediumSpacing = 16.0;
  static const double largeSpacing = 24.0;
  static const double extraLargeSpacing = 32.0;

  // Border Radius
  static const double smallRadius = 4.0;
  static const double mediumRadius = 8.0;
  static const double largeRadius = 16.0;
  static const double circularRadius = 50.0;

  // Regular Expressions
  static const String emailRegex = r'^[^@]+@[^@]+\.[^@]+';
  static const String phoneRegex = r'^\+?[1-9]\d{1,14}$';
  static const String passwordRegex =
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d@$!%*?&]{8,}$';
}
