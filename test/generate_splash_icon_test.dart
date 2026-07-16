import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:priorise/core/tokens/app_colors.dart';
import 'package:priorise/core/tokens/app_spacing.dart';
import 'package:priorise/shared/painters/compass_painter.dart';

class SplashIconGenerator extends StatelessWidget {
  const SplashIconGenerator({super.key});

  @override
  Widget build(BuildContext context) {
    // Make the content tight and large for a 512x512 icon
    return Container(
      width: 512,
      height: 512,
      color: Colors.transparent, // transparent background for the icon!
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 260,
              height: 260,
              child: CustomPaint(
                painter: const CompassPainter(
                  isDark: true,
                  showGlow: false,
                  showLabels: false,
                ),
              ),
            ),
            const SizedBox(height: 32),
            const Text(
              'Priorise',
              style: TextStyle(
                fontFamily: 'serif',
                fontSize: 52,
                fontWeight: FontWeight.w600,
                color: AppColorsDark.textPrimary,
                letterSpacing: -1.0,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              "L'ESSENTIEL D'ABORD",
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 22,
                color: AppColorsDark.textTertiary,
                letterSpacing: 2.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  testWidgets('Generate splash icon PNG', (WidgetTester tester) async {
    await tester.binding.setSurfaceSize(const Size(512, 512));

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          backgroundColor: Colors.transparent,
          body: SplashIconGenerator(),
        ),
      ),
    );

    await expectLater(
      find.byType(SplashIconGenerator),
      matchesGoldenFile('../assets/icons/priorise_splash_icon.png'),
    );
  });
}
