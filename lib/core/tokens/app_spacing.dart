// Espacement et rayons Priorise.
// Grille : multiples de 4dp.
// Padding d'écran : 22dp en référence 375dp, adapté par breakpoint.
// Rayons : s=10, m=16, l=26.
import 'package:flutter/material.dart';

/// Material 3 window size classes alignés sur le brief design.
enum ScreenClass {
  /// < 600dp — téléphone en portrait
  compact,

  /// 600–840dp — tablette portrait / grand phablet
  medium,

  /// > 840dp — tablette paysage / pliable déplié
  expanded,
}

abstract final class AppSpacing {
  // Grille de base
  static const double xs = 4;
  static const double s = 8;
  static const double m = 12;
  static const double l = 16;
  static const double xl = 20;
  static const double xxl = 24;
  static const double xxxl = 32;
  static const double xxxxl = 48;

  // Rayons
  static const double radiusS = 10;
  static const double radiusM = 16;
  static const double radiusL = 26;

  // Padding horizontal d'écran
  static const double _screenPaddingRef = 22; // à 375dp

  /// Padding horizontal de l'écran, adapté au breakpoint.
  /// - compact : 22dp (référence design)
  /// - medium  : 32dp (plus d'espace disponible, marges confortables)
  /// - expanded: 48dp (tablette, layout centré possible)
  static double screenPaddingH(BuildContext context) {
    final sc = screenClass(context);
    return switch (sc) {
      ScreenClass.compact => _screenPaddingRef,
      ScreenClass.medium => 32,
      ScreenClass.expanded => 48,
    };
  }

  /// Padding vertical en haut des écrans.
  static double screenPaddingTop(BuildContext context) {
    final sc = screenClass(context);
    return switch (sc) {
      ScreenClass.compact => 24,
      ScreenClass.medium => 32,
      ScreenClass.expanded => 40,
    };
  }

  /// Nombre de colonnes pour une grille de rôles ou de cards.
  /// compact → 1, medium → 2, expanded → 3 (jamais codé en dur).
  static int gridColumns(BuildContext context) {
    final sc = screenClass(context);
    return switch (sc) {
      ScreenClass.compact => 1,
      ScreenClass.medium => 2,
      ScreenClass.expanded => 3,
    };
  }

  /// Classe d'écran dérivée de la largeur logique du widget le plus proche.
  static ScreenClass screenClass(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    if (w < 600) return ScreenClass.compact;
    if (w < 840) return ScreenClass.medium;
    return ScreenClass.expanded;
  }

  /// Largeur maximale du contenu sur expanded pour éviter des lignes trop longues.
  static double maxContentWidth(BuildContext context) {
    final sc = screenClass(context);
    return switch (sc) {
      ScreenClass.compact => double.infinity,
      ScreenClass.medium => 640,
      ScreenClass.expanded => 840,
    };
  }
}
