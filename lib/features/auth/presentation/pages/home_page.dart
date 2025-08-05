import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../analytics/analytics_service.dart';
import '../app_router.dart';

/// Home page placeholder
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            onPressed: () {
              AnalyticsService.logButtonClick('logout', 'home_page');
              context.go(AppRouter.loginRoute);
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.home, size: 64),
            SizedBox(height: 16),
            Text(
              'Welcome to Home Page!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Clean Architecture Flutter Base Project',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
