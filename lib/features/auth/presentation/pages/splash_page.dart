import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/analytics/analytics_service.dart';
import '../../../../shared/services/logger_service.dart';
import '../../../../core/router/app_router.dart';

/// Splash screen for app initialization
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _initializeAndNavigate();
  }

  Future<void> _initializeAndNavigate() async {
    try {
      // Simulate initialization time
      await Future.delayed(const Duration(seconds: 2));

      // Check authentication status and navigate accordingly
      if (mounted) {
        context.go(AppRouter.loginRoute);
      }
    } catch (e) {
      LoggerService.e('Splash initialization failed', e);
      if (mounted) {
        context.go(AppRouter.loginRoute);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlutterLogo(size: 100),
            SizedBox(height: 24),
            CircularProgressIndicator(color: Colors.white),
            SizedBox(height: 16),
            Text(
              'Loading...',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
