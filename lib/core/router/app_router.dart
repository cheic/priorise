import 'package:flutter/material.dart';
import '../../features/onboarding/presentation/onboarding_screen.dart';
import '../../features/shell/presentation/app_shell_screen.dart';

abstract final class AppRoutes {
  static const onboarding = '/onboarding';
  static const today = '/today';
  static const roles = '/roles';
  static const matrix = '/matrix';
  static const review = '/review';
}

Route<dynamic> generateRoute(RouteSettings settings) {
  final name = settings.name ?? '';
  
  return switch (name) {
    AppRoutes.onboarding => MaterialPageRoute(
        builder: (_) => const OnboardingScreen(),
        settings: settings,
      ),
    AppRoutes.today => MaterialPageRoute(
        builder: (_) => const AppShellScreen(initialIndex: 0),
        settings: settings,
      ),
    AppRoutes.roles => MaterialPageRoute(
        builder: (_) => const AppShellScreen(initialIndex: 1),
        settings: settings,
      ),
    AppRoutes.matrix => MaterialPageRoute(
        builder: (_) => const AppShellScreen(initialIndex: 2),
        settings: settings,
      ),
    AppRoutes.review => MaterialPageRoute(
        builder: (_) => const AppShellScreen(initialIndex: 3),
        settings: settings,
      ),
    _ => MaterialPageRoute(
        builder: (_) => const AppShellScreen(),
        settings: settings,
      ),
  };
}
