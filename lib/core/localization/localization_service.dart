import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// import 'generated/l10n.dart'; // Will be generated later

class LocalizationService {
  static const List<Locale> supportedLocales = [
    Locale('en', 'US'),
    Locale('vi', 'VN'),
  ];

  static const Locale defaultLocale = Locale('en', 'US');

  static Locale? localeResolutionCallback(
    Locale? locale,
    Iterable<Locale> supportedLocales,
  ) {
    if (locale == null) return defaultLocale;

    // Check if the device locale is supported
    for (final supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return supportedLocale;
      }
    }

    return defaultLocale;
  }

  static String getCurrentLanguage(BuildContext context) {
    return Localizations.localeOf(context).languageCode;
  }

  static bool isVietnamese(BuildContext context) {
    return getCurrentLanguage(context) == 'vi';
  }

  static bool isEnglish(BuildContext context) {
    return getCurrentLanguage(context) == 'en';
  }

  // Format date/time based on locale
  static String formatDate(DateTime date, BuildContext context) {
    final locale = Localizations.localeOf(context);
    return DateFormat.yMd(locale.toString()).format(date);
  }

  static String formatDateTime(DateTime dateTime, BuildContext context) {
    final locale = Localizations.localeOf(context);
    return DateFormat.yMd(locale.toString()).add_jm().format(dateTime);
  }

  static String formatTime(DateTime time, BuildContext context) {
    final locale = Localizations.localeOf(context);
    return DateFormat.jm(locale.toString()).format(time);
  }

  // Format numbers based on locale
  static String formatNumber(num number, BuildContext context) {
    final locale = Localizations.localeOf(context);
    return NumberFormat.decimalPattern(locale.toString()).format(number);
  }

  static String formatCurrency(double amount, BuildContext context,
      {String? symbol}) {
    final locale = Localizations.localeOf(context);
    final formatter = NumberFormat.currency(
      locale: locale.toString(),
      symbol: symbol ?? (isVietnamese(context) ? '₫' : '\$'),
    );
    return formatter.format(amount);
  }

  // Get translations shorthand
  // static S of(BuildContext context) => S.of(context); // Will be enabled after generation
}
