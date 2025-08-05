import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../storage/hive_storage.dart';

enum AppThemeMode { light, dark, system }

class ThemeState extends Equatable {
  final ThemeMode themeMode;
  final AppThemeMode appThemeMode;

  const ThemeState({
    required this.themeMode,
    required this.appThemeMode,
  });

  @override
  List<Object> get props => [themeMode, appThemeMode];
}

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit()
      : super(const ThemeState(
          themeMode: ThemeMode.light,
          appThemeMode: AppThemeMode.light,
        )) {
    _loadTheme();
  }

  void _loadTheme() {
    final savedTheme = HiveStorage.getTheme();
    final appThemeMode = _getAppThemeModeFromString(savedTheme);
    final themeMode = _getThemeModeFromAppThemeMode(appThemeMode);

    emit(ThemeState(
      themeMode: themeMode,
      appThemeMode: appThemeMode,
    ));
  }

  void changeTheme(AppThemeMode newThemeMode) {
    final themeMode = _getThemeModeFromAppThemeMode(newThemeMode);

    emit(ThemeState(
      themeMode: themeMode,
      appThemeMode: newThemeMode,
    ));

    HiveStorage.setTheme(_getStringFromAppThemeMode(newThemeMode));
  }

  ThemeMode _getThemeModeFromAppThemeMode(AppThemeMode appThemeMode) {
    switch (appThemeMode) {
      case AppThemeMode.light:
        return ThemeMode.light;
      case AppThemeMode.dark:
        return ThemeMode.dark;
      case AppThemeMode.system:
        return ThemeMode.system;
    }
  }

  AppThemeMode _getAppThemeModeFromString(String themeString) {
    switch (themeString) {
      case 'light':
        return AppThemeMode.light;
      case 'dark':
        return AppThemeMode.dark;
      case 'system':
        return AppThemeMode.system;
      default:
        return AppThemeMode.light;
    }
  }

  String _getStringFromAppThemeMode(AppThemeMode appThemeMode) {
    switch (appThemeMode) {
      case AppThemeMode.light:
        return 'light';
      case AppThemeMode.dark:
        return 'dark';
      case AppThemeMode.system:
        return 'system';
    }
  }
}
