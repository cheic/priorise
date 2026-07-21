import 'package:flutter/material.dart';
import '../../features/onboarding/presentation/onboarding_screen.dart';
import '../../features/shell/presentation/app_shell_screen.dart';

abstract final class AppRoutes {
  static const onboarding = '/onboarding';
  static const today = '/today';
}

Route<dynamic> generateRoute(RouteSettings settings) {
  final name = settings.name ?? '';
  
  return switch (name) {
    AppRoutes.onboarding => MaterialPageRoute(
        builder: (_) => const OnboardingScreen(),
        settings: settings,
      ),
    AppRoutes.today => MaterialPageRoute(
        builder: (_) => const AppShellScreen(),
        settings: settings,
      ),
    _ => MaterialPageRoute(
        builder: (_) => const AppShellScreen(),
        settings: settings,
      ),
  };
}
