// jar_painter.dart — CustomPainter du bocal Priorise.
//
// TOKENS UTILISÉS :
//   brass #B8935B, brassGlow rgba(184,147,91,0.22),
//   surface #1B2A38, border rgba(237,230,214,0.10)
//
// COMPORTEMENT RESPONSIVE :
//   Tous les points, rayons et tracés sont calculés proportionnellement à
//   `size.width` / `size.height` reçus du CustomPaint parent.
//   À 80×80 (icône), 160×160 (widget sidebar), 220×220 (page Today) :
//   le rendu est identique en proportions — aucune coordonnée absolue du mockup.
//
// DESCRIPTION VISUELLE :
//   Bocal cylindrique avec couvercle, rempli à 60% de "pierres" symboliques
//   (ellipses brass de tailles variées) et de "sable" (fond dégradé).
//   Une grande pierre est mise en évidence (la "Big Rock" de la semaine).
import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../core/tokens/app_colors.dart';
import '../../core/tokens/app_spacing.dart';

class JarPainter extends CustomPainter {
  const JarPainter({
    this.fillRatio = 0.6,
    this.bigRockColor = AppColorsDark.brass,
    this.stoneColor = AppColorsDark.brassBright,
    this.sandColor = AppColorsDark.brassGlow,
    this.jarColor = AppColorsDark.surface,
    this.borderColor = AppColorsDark.borderStrong,
  });

  /// 0.0–1.0 : proportion de remplissage du bocal.
  final double fillRatio;
  final Color bigRockColor;
  final Color stoneColor;
  final Color sandColor;
  final Color jarColor;
  final Color borderColor;

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // ── Dimensions proportionnelles ──────────────────────────────────────
    final lidH = h * 0.10;
    final lidW = w * 0.72;
    final lidX = (w - lidW) / 2;
    final bodyX = w * 0.10;
    final bodyW = w * 0.80;
    final bodyTop = lidH + h * 0.02;
    final bodyH = h - bodyTop - h * 0.04;
    final bodyR = AppSpacing.radiusS * (w / 160); // rayon adapté à la taille

    // Niveau de remplissage (y depuis le bas du bocal)
    final fillY = bodyTop + bodyH * (1 - fillRatio);

    // ── Bocal — fond ──────────────────────────────────────────────────────
    final bodyRect =
        RRect.fromRectAndRadius(
      Rect.fromLTWH(bodyX, bodyTop, bodyW, bodyH),
      Radius.circular(bodyR),
    );
    canvas.drawRRect(
      bodyRect,
      Paint()..color = jarColor,
    );

    // ── Zone de remplissage (sable + pierres) ─────────────────────────────
    final fillClip = RRect.fromRectAndRadius(
      Rect.fromLTWH(bodyX, fillY, bodyW, bodyH - (fillY - bodyTop)),
      Radius.circular(bodyR),
    );
    canvas.save();
    canvas.clipRRect(fillClip);

    // Sable (fond dégradé brass→transparent)
    final sandPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
        colors: [sandColor, sandColor.withAlpha(0)],
      ).createShader(Rect.fromLTWH(bodyX, fillY, bodyW, bodyH - (fillY - bodyTop)));
    canvas.drawRRect(fillClip, sandPaint);

    // Pierres secondaires (petites, semi-transparentes)
    final smallR = _SeedRandom(42);
    final stonePaint = Paint()..color = stoneColor.withAlpha(180);
    for (int i = 0; i < 8; i++) {
      final cx = bodyX + bodyW * 0.15 + smallR.next() * bodyW * 0.70;
      final cy = fillY + h * 0.03 + smallR.next() * (bodyH - (fillY - bodyTop) - h * 0.06);
      final rx = w * (0.05 + smallR.next() * 0.06);
      final ry = rx * (0.5 + smallR.next() * 0.3);
      canvas.drawOval(
        Rect.fromCenter(center: Offset(cx, cy), width: rx * 2, height: ry * 2),
        stonePaint,
      );
    }

    // Grande pierre (Big Rock) : ellipse proéminente centrée en bas du bocal
    final bigRx = w * 0.22;
    final bigRy = h * 0.10;
    final bigCx = bodyX + bodyW * 0.50;
    final bigCy = bodyTop + bodyH - bigRy - h * 0.04;
    canvas.drawOval(
      Rect.fromCenter(
          center: Offset(bigCx, bigCy), width: bigRx * 2, height: bigRy * 2),
      Paint()..color = bigRockColor,
    );
    // Reflet sur la grande pierre
    canvas.drawOval(
      Rect.fromCenter(
          center: Offset(bigCx - bigRx * 0.20, bigCy - bigRy * 0.25),
          width: bigRx * 0.5,
          height: bigRy * 0.35),
      Paint()..color = Colors.white.withAlpha(30),
    );

    canvas.restore();

    // ── Bordure du bocal ──────────────────────────────────────────────────
    canvas.drawRRect(
      bodyRect,
      Paint()
        ..color = borderColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = math.max(1, w * 0.012),
    );

    // ── Couvercle ─────────────────────────────────────────────────────────
    final lidRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(lidX, 0, lidW, lidH),
      Radius.circular(math.min(bodyR * 0.7, lidH / 2)),
    );
    canvas.drawRRect(lidRect, Paint()..color = jarColor);
    canvas.drawRRect(
      lidRect,
      Paint()
        ..color = borderColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = math.max(1, w * 0.012),
    );
  }

  @override
  bool shouldRepaint(JarPainter oldDelegate) =>
      oldDelegate.fillRatio != fillRatio ||
      oldDelegate.bigRockColor != bigRockColor;
}

/// Générateur pseudo-aléatoire déterministe pour placer les pierres de façon
/// reproductible sans état externe.
class _SeedRandom {
  _SeedRandom(int seed) : _state = seed;
  int _state;

  double next() {
    _state = (_state * 1664525 + 1013904223) & 0xFFFFFFFF;
    return (_state & 0x7FFFFFFF) / 0x7FFFFFFF;
  }
}


