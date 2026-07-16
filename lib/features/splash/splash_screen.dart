import 'package:flutter/material.dart';
import '../../core/di/injection.dart';
import '../../core/router/app_router.dart';
import '../../core/services/secure_storage_service.dart';
import '../../core/tokens/app_colors.dart';
import '../../core/tokens/app_spacing.dart';
import '../../shared/painters/compass_painter.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _opacity;

  @override
  void initState() {
    super.initState();

    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _opacity = CurvedAnimation(parent: _ctrl, curve: Curves.easeIn);

    // Animation démarre
    _ctrl.forward();
    _loadAndNavigate();
  }

  Future<void> _loadAndNavigate() async {
    // Check first launch state
    final isFirst = await getIt<SecureStorageService>().isFirstLaunch();
    
    // Add artificial delay so splash is actually visible
    await Future.delayed(const Duration(milliseconds: 800));
    
    if (mounted) {
      if (isFirst) {
        Navigator.of(context).pushReplacementNamed(AppRoutes.onboarding);
      } else {
        Navigator.of(context).pushReplacementNamed(AppRoutes.today);
      }
    }
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // The exact layout the user prefers
    const compassSize = 160.0;
    const titleSize = 32.0;
    const taglineSize = 13.0;

    return Scaffold(
      backgroundColor: context.cSurface,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: compassSize,
                height: compassSize,
                child: CustomPaint(
                  painter: CompassPainter(
                    isDark: Theme.of(context).brightness == Brightness.dark,
                    showGlow: false,
                    showLabels: false,
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              FadeTransition(
                opacity: _opacity,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Priorise',
                      style: TextStyle(
                        fontFamily: 'serif',
                        fontSize: titleSize,
                        fontWeight: FontWeight.w600,
                        color: context.cTextPrimary,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.s),
                    Text(
                      "L'ESSENTIEL D'ABORD",
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: taglineSize,
                        color: context.cTextTertiary,
                        letterSpacing: 2.0,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
