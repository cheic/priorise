// Navigateur centralisé.
// Routes nommées, remplace go_router pour garder zéro dépendance supplémentaire.
import 'package:flutter/material.dart';
import '../../features/splash/splash_screen.dart';
import '../../features/onboarding/presentation/onboarding_screen.dart';
import '../../features/shell/presentation/app_shell_screen.dart';

abstract final class AppRoutes {
  static const splash = '/';
  static const onboarding = '/onboarding';
  static const today = '/today';
}

Route<dynamic> generateRoute(RouteSettings settings) {
  return switch (settings.name) {
    AppRoutes.splash => MaterialPageRoute(
        builder: (_) => const SplashScreen(),
        settings: settings,
      ),
    AppRoutes.onboarding => MaterialPageRoute(
        builder: (_) => const OnboardingScreen(),
        settings: settings,
      ),
    AppRoutes.today => MaterialPageRoute(
        builder: (_) => const AppShellScreen(),
        settings: settings,
      ),
    _ => MaterialPageRoute(
        builder: (_) => const SplashScreen(),
        settings: settings,
      ),
  };
}
