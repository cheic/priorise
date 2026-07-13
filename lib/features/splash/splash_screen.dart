// splash_screen.dart — Premier écran visible au lancement.
//
// TOKENS UTILISÉS :
//   ink #121D27 (FIXE, indépendant du thème système)
//   text-primary #ECE5D4 — nom "Priorise" Fraunces 650
//   text-tertiary #77828F — tagline JetBrains Mono small-caps
//   brass #B8935B — point du repère CompassPainter + dots loader
//   brassGlow — halo du repère
//
// COMPORTEMENT RESPONSIVE :
//   compact   : repère 120×120, titre 28sp, tagline 12sp
//   medium    : repère 160×160, titre 32sp, tagline 13sp
//   expanded  : repère 200×200, titre 36sp, tagline 14sp
//   SafeArea sur toutes les zones ; jamais de débordement à 320dp.
//
// DURÉE : temps réel du chargement SecureStorage (isFirstLaunch).
//   Pas de Future.delayed artificiel > 100ms.
//   L'animation (600ms) court en parallèle du chargement.
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/di/injection.dart';
import '../../core/router/app_router.dart';
import '../../core/services/secure_storage_service.dart';
import '../../core/tokens/app_colors.dart';
import '../../core/tokens/app_spacing.dart';
import '../../core/tokens/app_typography.dart';
import '../../shared/painters/compass_painter.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _scale;
  late final Animation<double> _opacity;

  late final AnimationController _dotsCtrl;

  @override
  void initState() {
    super.initState();



    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _scale = Tween<double>(begin: 0.82, end: 1.0).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeOutBack),
    );
    _opacity = CurvedAnimation(parent: _ctrl, curve: Curves.easeOut);

    // Dots loader — repeats over 1.2s matching CSS animation.
    _dotsCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();

    // Animation démarre immédiatement ; chargement tourne en parallèle.
    _ctrl.forward();
    _loadAndNavigate();
  }

  Future<void> _loadAndNavigate() async {
    // Chargement réel — la durée est celle du disque, pas un délai artificiel.
    final storage = getIt<SecureStorageService>();
    final isFirst = await storage.isFirstLaunch();

    // Attendre la fin de l'animation si elle n'est pas encore terminée.
    if (!_ctrl.isCompleted) {
      await _ctrl.forward();
    }

    if (!mounted) return;

    Navigator.pushReplacementNamed(
      context,
      isFirst ? AppRoutes.onboarding : AppRoutes.today,
    );
  }

  /// Compute dot opacity matching the CSS keyframes:
  ///   0%,100% { opacity: 0.25 }  40% { opacity: 1 }
  /// Each dot has a staggered offset: 0s, 0.15s, 0.3s over 1.2s period.
  double _dotOpacity(int index) {
    const offsets = [0.0, 0.15 / 1.2, 0.3 / 1.2]; // 0, 0.125, 0.25
    final t = (_dotsCtrl.value + (1.0 - offsets[index])) % 1.0;
    // Ramp up from 0→0.4 (0.25→1.0), then down from 0.4→1.0 (1.0→0.25)
    if (t < 0.4) {
      // 0.25 → 1.0
      return 0.25 + 0.75 * (t / 0.4);
    } else {
      // 1.0 → 0.25
      return 1.0 - 0.75 * ((t - 0.4) / 0.6);
    }
  }

  @override
  void dispose() {
    _dotsCtrl.dispose();
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: isDark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: context.cSurface,
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final sc = AppSpacing.screenClass(context);

              final compassSize = switch (sc) {
                ScreenClass.compact => 120.0,
                ScreenClass.medium => 160.0,
                ScreenClass.expanded => 200.0,
              };

              final titleSize = switch (sc) {
                ScreenClass.compact => 28.0,
                ScreenClass.medium => 32.0,
                ScreenClass.expanded => 36.0,
              };

              final taglineSize = switch (sc) {
                ScreenClass.compact => 12.0,
                ScreenClass.medium => 13.0,
                ScreenClass.expanded => 14.0,
              };

              return Center(
                child: ScaleTransition(
                  scale: _scale,
                  child: FadeTransition(
                    opacity: _opacity,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // ── Repère de marque ──────────────────────────
                        SizedBox(
                          width: compassSize,
                          height: compassSize,
                          child: CustomPaint(
                            painter: CompassPainter(isDark: isDark, showGlow: true),
                          ),
                        ),
                        const SizedBox(height: AppSpacing.xl),
                        // ── Nom de l'application ──────────────────────
                        Text(
                          'Priorise',
                          style: AppTypography.fraunces(
                            size: titleSize,
                            weight: 650,
                            color: context.cTextPrimary,
                            letterSpacing: -0.5,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.s),
                        // ── Tagline ───────────────────────────────────
                        Text(
                          "L'ESSENTIEL D'ABORD",
                          style: AppTypography.mono(
                            size: taglineSize,
                            color: context.cTextTertiary,
                            smallCaps: true,
                            letterSpacing: 2.0,
                          ),
                        ),
                        // ── Loading dots ──────────────────────────────
                        const SizedBox(height: 40),
                        AnimatedBuilder(
                          animation: _dotsCtrl,
                          builder: (context, _) {
                            return Row(
                              mainAxisSize: MainAxisSize.min,
                              children: List.generate(3, (i) {
                                return Padding(
                                  padding: EdgeInsets.only(
                                    left: i == 0 ? 0 : 6,
                                  ),
                                  child: Opacity(
                                    opacity: _dotOpacity(i),
                                    child: Container(
                                      width: 5,
                                      height: 5,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: context.cBrass,
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
