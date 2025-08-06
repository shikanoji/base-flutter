// ignore_for_file: avoid_classes_with_only_static_members

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/pages/login_page.dart';
import '../analytics/analytics_service.dart';
import '../../shared/services/logger_service.dart';
import '../../features/auth/presentation/pages/splash_page.dart';
import '../../features/auth/presentation/pages/home_page.dart';
import '../../features/auth/presentation/pages/error_page.dart';

/// Centralized router configuration following clean architecture
class AppRouter {
  // Route paths
  static const String loginRoute = '/login';
  static const String homeRoute = '/home';
  static const String splashRoute = '/';

  // Route names
  static const String loginRouteName = 'login';
  static const String homeRouteName = 'home';
  static const String splashRouteName = 'splash';

  static final GoRouter _router = GoRouter(
    initialLocation: splashRoute,
    debugLogDiagnostics: false, // Set to true for debugging
    observers: [
      _RouterObserver(),
    ],
    routes: [
      GoRoute(
        path: splashRoute,
        name: splashRouteName,
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: loginRoute,
        name: loginRouteName,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: homeRoute,
        name: homeRouteName,
        builder: (context, state) => const HomePage(),
      ),
    ],
    errorBuilder: (context, state) => ErrorPage(error: state.error),
    redirect: (context, state) {
      return _handleRedirect(context, state);
    },
  );

  static GoRouter get router => _router;

  /// Handle navigation redirects based on app state
  static String? _handleRedirect(BuildContext context, GoRouterState state) {
    final currentPath = state.matchedLocation;

    // Add authentication logic here when implemented
    // final isLoggedIn = context.read<AuthBloc>().state is AuthAuthenticated;

    LoggerService.d('Navigation redirect check: $currentPath');

    // For now, allow all navigation
    return null;
  }
}

/// Router observer for analytics and logging
class _RouterObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    _logNavigation(route.settings.name, previousRoute?.settings.name);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    _logNavigation(previousRoute?.settings.name, route.settings.name);
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    _logNavigation(newRoute?.settings.name, oldRoute?.settings.name);
  }

  void _logNavigation(String? to, String? from) {
    if (to != null) {
      LoggerService.logNavigation(from ?? 'unknown', to);
      AnalyticsService.logScreenView(to, to);
    }
  }
}

// ...existing code...
