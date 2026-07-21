import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:priorise/core/tokens/app_colors.dart';
import 'package:priorise/core/tokens/app_spacing.dart';
import 'package:priorise/shared/painters/compass_painter.dart';

class DummySplashScreen extends StatelessWidget {
  const DummySplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Hardcode sizes for compact screen (iPhone 13 mini) or medium
    const compassSize = 160.0;
    const titleSize = 32.0;
    const taglineSize = 13.0;

    return Scaffold(
      backgroundColor: AppColorsDark.surface,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: compassSize,
                height: compassSize,
                child: CustomPaint(
                  painter: const CompassPainter(
                    isDark: true,
                    showGlow: false,
                    showLabels: false,
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              Text(
                'Priorise',
                style: const TextStyle(
                  fontFamily: 'serif',
                  fontSize: titleSize,
                  fontWeight: FontWeight.w600,
                  color: AppColorsDark.textPrimary,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: AppSpacing.s),
              Text(
                "L'ESSENTIEL D'ABORD",
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: taglineSize,
                  color: AppColorsDark.textTertiary,
                  letterSpacing: 2.0,
                ),
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(3, (i) {
                  return Padding(
                    padding: EdgeInsets.only(left: i == 0 ? 0 : 6),
                    child: Container(
                      width: 5,
                      height: 5,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColorsDark.brass,
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  setUpAll(() {
    GoogleFonts.config.allowRuntimeFetching = false;
  });

  testWidgets('Generate splash screen PNG', (WidgetTester tester) async {
    // Set the exact screen size of a standard phone (e.g. iPhone 13)
    await tester.binding.setSurfaceSize(const Size(390, 844));

    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: AppColorsDark.surface,
        ),
        home: const DummySplashScreen(),
      ),
    );

    // Match golden file - this saves the PNG to disk
    await expectLater(
      find.byType(DummySplashScreen),
      matchesGoldenFile('../assets/splash_dark.png'),
    );
  });
}
