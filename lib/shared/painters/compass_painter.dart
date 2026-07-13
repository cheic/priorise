// compass_painter.dart — CustomPainter du repère (mark) Priorise.
//
// Compass — deux modes de rendu :
//
// SMALL MODE (showGlow: false) — marque/splash :
//   Cercle + axes subtils (opacity ~0.45) + point plein en haut-gauche.
//   Inspiré du SVG splash :
//     <circle cx="12" cy="12" r="9" stroke="currentColor" stroke-width="1.3"/>
//     <path d="M12 3v18M3 12h18" stroke="currentColor" stroke-width="1" opacity="0.45"/>
//     <circle cx="8.3" cy="8.3" r="2.3" fill="currentColor"/>
//
// FULL MODE (showGlow: true) — écran matrice :
//   Cercle extérieur (brass), cercle intérieur (border), wedge stratégique (brassGlow),
//   axes (borderStrong), aiguille centre→zone stratégique (brassBright), dot centre,
//   dot stratégique, dots de tâches dispersés dans les différentes zones.
//
// Tous les rayons/épaisseurs sont dérivés de size — aucune valeur fixe.
import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../core/tokens/app_colors.dart';
import '../../core/tokens/app_typography.dart';

class CompassTask {
  final double x; // -1 to 1 (left to right)
  final double y; // -1 to 1 (top to bottom)
  final Color color;
  const CompassTask(this.x, this.y, this.color);
}

class CompassPainter extends CustomPainter {
  const CompassPainter({
    this.isDark = true,
    this.showGlow = false,
    this.strokeScaleFactor = 1.0,
    this.tasks = const [],
  });

  final bool isDark;
  final bool showGlow;
  final double strokeScaleFactor;
  final List<CompassTask> tasks;

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final cx = w / 2;
    final cy = h / 2;

    if (showGlow) {
      _paintFull(canvas, w, h);
    } else {
      _paintSmall(canvas, w, h, cx, cy);
    }
  }

  // ── SMALL MODE — brand mark ───────────────────────────────────────────
  void _paintSmall(Canvas canvas, double w, double h, double cx, double cy) {
    final outerR = w * 0.375; // ~r=9 on viewBox 24
    final circleStroke = math.max(1.0, w * 0.054) * strokeScaleFactor; // ~1.3/24
    final axisStroke = math.max(0.8, w * 0.042) * strokeScaleFactor; // ~1/24

    // ── Circle ──
    canvas.drawCircle(
      Offset(cx, cy),
      outerR,
      Paint()
        ..color = isDark ? AppColorsDark.brass : AppColorsLight.brass
        ..style = PaintingStyle.stroke
        ..strokeWidth = circleStroke,
    );

    // ── Axes (subtle, opacity ~0.45) ──
    final axisPaint = Paint()
      ..color = (isDark ? AppColorsDark.brass : AppColorsLight.brass).withAlpha(115) // 0.45 * 255 ≈ 115
      ..strokeWidth = axisStroke
      ..strokeCap = StrokeCap.round;

    // Horizontal axis — spans inside circle
    canvas.drawLine(
      Offset(cx - outerR, cy),
      Offset(cx + outerR, cy),
      axisPaint,
    );
    // Vertical axis
    canvas.drawLine(
      Offset(cx, cy - outerR),
      Offset(cx, cy + outerR),
      axisPaint,
    );

    // ── Dot stratégique (top-left zone) ──
    // Position: ~(8.3, 8.3) on viewBox 24 → offset from center = -(12-8.3)/12 * outerR
    final dotOffset = outerR * 0.411; // (3.7/9)
    final dotR = math.max(2.0, w * 0.096); // ~2.3/24
    canvas.drawCircle(
      Offset(cx - dotOffset, cy - dotOffset),
      dotR,
      Paint()..color = isDark ? AppColorsDark.brass : AppColorsLight.brass,
    );
  }

  // ── FULL MODE — matrix page ───────────────────────────────────────────
  void _paintFull(Canvas canvas, double w, double h) {
    final s = w / 230.0;
    final cx = 115.0 * s;
    final cy = 115.0 * s;

    // Outer circle
    canvas.drawCircle(
      Offset(cx, cy),
      98 * s,
      Paint()
        ..color = isDark ? AppColorsDark.borderStrong : AppColorsLight.borderStrong
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1 * s,
    );

    // Inner circle
    canvas.drawCircle(
      Offset(cx, cy),
      65 * s,
      Paint()
        ..color = isDark ? AppColorsDark.border : AppColorsLight.border
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1 * s,
    );

    // Wedge stratégique glow (top-left)
    final wedgePath = Path()
      ..moveTo(cx, cy)
      ..lineTo(cx, cy - 98 * s)
      ..arcTo(
        Rect.fromCircle(center: Offset(cx, cy), radius: 98 * s),
        -math.pi / 2,
        -math.pi / 2,
        false,
      )
      ..close();

    canvas.drawPath(
      wedgePath,
      Paint()..color = isDark ? AppColorsDark.brassGlow : AppColorsLight.brassGlow,
    );

    // Axes
    final axisPaint = Paint()
      ..color = isDark ? AppColorsDark.borderStrong : AppColorsLight.borderStrong
      ..strokeWidth = 1 * s;

    canvas.drawLine(Offset(17 * s, cy), Offset(213 * s, cy), axisPaint);
    canvas.drawLine(Offset(cx, 17 * s), Offset(cx, 213 * s), axisPaint);

    // Needle
    canvas.drawLine(
      Offset(cx, cy),
      Offset(72 * s, 72 * s),
      Paint()
        ..color = isDark ? AppColorsDark.brassBright : AppColorsLight.brassBright
        ..strokeWidth = 2.4 * s
        ..strokeCap = StrokeCap.round,
    );

    // Center dot
    canvas.drawCircle(
      Offset(cx, cy),
      4.5 * s,
      Paint()..color = isDark ? AppColorsDark.brassBright : AppColorsLight.brassBright,
    );

    // Needle dot
    canvas.drawCircle(
      Offset(72 * s, 72 * s),
      3.5 * s,
      Paint()..color = isDark ? AppColorsDark.brassBright : AppColorsLight.brassBright,
    );

    // Task dots
    if (tasks.isEmpty) {
      // Dummy dots if no tasks
      canvas.drawCircle(Offset(90 * s, 90 * s), 4 * s, Paint()..color = isDark ? AppColorsDark.sage : AppColorsLight.sage);
      canvas.drawCircle(Offset(150 * s, 60 * s), 4 * s, Paint()..color = isDark ? AppColorsDark.clay : AppColorsLight.clay);
      canvas.drawCircle(Offset(165 * s, 160 * s), 4 * s, Paint()..color = isDark ? AppColorsDark.textTertiary : AppColorsLight.textTertiary);
      canvas.drawCircle(Offset(55 * s, 150 * s), 4 * s, Paint()..color = isDark ? AppColorsDark.brass : AppColorsLight.brass);
    } else {
      final radius = 98 * s;
      for (final t in tasks) {
        final tx = cx + (t.x * radius * 0.8);
        final ty = cy + (t.y * radius * 0.8);
        canvas.drawCircle(Offset(tx, ty), 4 * s, Paint()..color = t.color);
      }
    }

    // Texts
    final textStyle = AppTypography.mono(
      size: 9 * s,
      color: isDark ? AppColorsDark.textTertiary : AppColorsLight.textTertiary,
    );
    
    final importText = TextPainter(
      text: TextSpan(text: 'IMPORTANCE ↑', style: textStyle),
      textDirection: TextDirection.ltr,
    )..layout();
    
    final urgenceText = TextPainter(
      text: TextSpan(text: 'URGENCE →', style: textStyle),
      textDirection: TextDirection.ltr,
    )..layout();

    // IMPORTANCE centered at the top
    // Positioned horizontally centered above the compass
    importText.paint(
      canvas,
      Offset(cx - importText.width / 2, cy - (98 * s) - importText.height - (4 * s)),
    );

    // URGENCE positioned on the right horizontal line
    // Vertically centered perfectly on the line
    urgenceText.paint(
      canvas,
      Offset(cx + (98 * s) - urgenceText.width, cy - urgenceText.height / 2),
    );
  }

  @override
  bool shouldRepaint(CompassPainter oldDelegate) =>
      oldDelegate.isDark != isDark ||
      oldDelegate.showGlow != showGlow ||
      oldDelegate.strokeScaleFactor != strokeScaleFactor ||
      oldDelegate.tasks != tasks;
}
