import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:priorise/core/tokens/app_colors.dart';
import 'package:priorise/shared/painters/compass_painter.dart';

class AdaptiveForegroundGenerator extends StatelessWidget {
  const AdaptiveForegroundGenerator({super.key});

  @override
  Widget build(BuildContext context) {
    // Increase size from typical to larger (e.g. 340x340 inside 512x512)
    return Container(
      width: 512,
      height: 512,
      color: Colors.transparent, // transparent background for the foreground icon!
      child: Center(
        child: SizedBox(
          width: 330, // INCREASED SIZE for the 4 squares (compass)
          height: 330,
          child: CustomPaint(
            painter: const CompassPainter(
              isDark: true,
              showGlow: false,
              showLabels: false,
            ),
          ),
        ),
      ),
    );
  }
}

class AdaptiveBackgroundGenerator extends StatelessWidget {
  const AdaptiveBackgroundGenerator({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 512,
      height: 512,
      color: AppColorsDark.surface, // The background color FBF8F0 or #1B140B, let's use dark surface
    );
  }
}

class StandardIconGenerator extends StatelessWidget {
  const StandardIconGenerator({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 512,
      height: 512,
      color: AppColorsDark.surface,
      child: Center(
        child: SizedBox(
          width: 330, // Match the enlarged size
          height: 330,
          child: CustomPaint(
            painter: const CompassPainter(
              isDark: true,
              showGlow: false,
              showLabels: false,
            ),
          ),
        ),
      ),
    );
  }
}

void main() {
  testWidgets('Generate adaptive foreground PNG', (WidgetTester tester) async {
    await tester.binding.setSurfaceSize(const Size(512, 512));

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          backgroundColor: Colors.transparent,
          body: AdaptiveForegroundGenerator(),
        ),
      ),
    );

    await expectLater(
      find.byType(AdaptiveForegroundGenerator),
      matchesGoldenFile('../assets/icons/priorise-icon-adaptive-foreground-512.png'),
    );
  });

  testWidgets('Generate adaptive background PNG', (WidgetTester tester) async {
    await tester.binding.setSurfaceSize(const Size(512, 512));

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          backgroundColor: Colors.transparent,
          body: AdaptiveBackgroundGenerator(),
        ),
      ),
    );

    await expectLater(
      find.byType(AdaptiveBackgroundGenerator),
      matchesGoldenFile('../assets/icons/priorise-icon-adaptive-background-512.png'),
    );
  });

  testWidgets('Generate standard icon PNG', (WidgetTester tester) async {
    await tester.binding.setSurfaceSize(const Size(512, 512));

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          backgroundColor: Colors.transparent,
          body: StandardIconGenerator(),
        ),
      ),
    );

    await expectLater(
      find.byType(StandardIconGenerator),
      matchesGoldenFile('../assets/icons/priorise-icon-512.png'),
    );
  });
}
