// Typographie Priorise.
// display : Fraunces — titres, mission, citations (usage restreint)
// body    : Inter — tout le reste
// mono    : JetBrains Mono — horodatages, tags, labels d'axes
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract final class AppTypography {
  // ── Fraunces (display) ─────────────────────────────────────────────────────
  static TextStyle fraunces({
    double size = 28,
    double weight = 560,
    Color? color,
    double? height,
    double? letterSpacing,
  }) =>
      GoogleFonts.fraunces(
        fontSize: size,
        fontWeight: _fractionalWeight(weight),
        color: color,
        height: height,
        letterSpacing: letterSpacing,
      );

  /// Mappe un poids fractionnaire Fraunces (300/440/560/650) au
  /// FontWeight Flutter le plus proche.
  static FontWeight _fractionalWeight(double w) {
    if (w <= 350) return FontWeight.w300;
    if (w <= 490) return FontWeight.w400;
    if (w <= 600) return FontWeight.w600;
    return FontWeight.w700;
  }

  /// Titre d'écran principal — Fraunces 650, 32 sp.
  static TextStyle displayLarge({Color? color}) =>
      fraunces(size: 32, weight: 650, color: color, height: 1.15);

  /// Titre de section — Fraunces 560, 24 sp.
  static TextStyle displayMedium({Color? color}) =>
      fraunces(size: 24, weight: 560, color: color, height: 1.2);

  /// Titre de card — Fraunces 440, 20 sp.
  static TextStyle displaySmall({Color? color}) =>
      fraunces(size: 20, weight: 440, color: color, height: 1.25);

  // ── Inter (body) ───────────────────────────────────────────────────────────
  static TextStyle inter({
    double size = 16,
    FontWeight weight = FontWeight.w400,
    Color? color,
    double? height,
    double? letterSpacing,
    TextDecoration? decoration,
  }) =>
      GoogleFonts.inter(
        fontSize: size,
        fontWeight: weight,
        color: color,
        height: height,
        letterSpacing: letterSpacing,
        decoration: decoration,
      );

  static TextStyle bodyLarge({Color? color}) =>
      inter(size: 16, weight: FontWeight.w400, color: color, height: 1.5);
  static TextStyle bodyMedium({Color? color}) =>
      inter(size: 14, weight: FontWeight.w400, color: color, height: 1.5);
  static TextStyle bodySmall({Color? color}) =>
      inter(size: 12, weight: FontWeight.w400, color: color, height: 1.5);
  static TextStyle labelLarge({Color? color}) =>
      inter(size: 14, weight: FontWeight.w600, color: color, height: 1.4);
  static TextStyle labelMedium({Color? color}) =>
      inter(size: 12, weight: FontWeight.w600, color: color, height: 1.4);
  static TextStyle buttonText({Color? color}) =>
      inter(size: 15, weight: FontWeight.w600, color: color, height: 1.2);

  // ── JetBrains Mono (mono) ──────────────────────────────────────────────────
  static TextStyle mono({
    double size = 12,
    FontWeight weight = FontWeight.w400,
    Color? color,
    double? letterSpacing,
    bool smallCaps = false,
  }) =>
      GoogleFonts.jetBrainsMono(
        fontSize: size,
        fontWeight: weight,
        color: color,
        letterSpacing: letterSpacing ?? (smallCaps ? 1.4 : 0),
        fontFeatures:
            smallCaps ? const [FontFeature.enable('smcp')] : null,
      );

  static TextStyle monoSmall({Color? color}) =>
      mono(size: 11, color: color, letterSpacing: 0.4);

  static TextStyle tagLabel({Color? color}) =>
      mono(size: 11, weight: FontWeight.w500, color: color, smallCaps: true);
}
