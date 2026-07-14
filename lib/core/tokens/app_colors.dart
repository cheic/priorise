// Tokens couleurs Priorise — ne jamais utiliser de valeur en dur ailleurs dans l'app.
// Règle : rouge saturé interdit pour signaler l'urgence. Clay reste désaturé.
import 'package:flutter/material.dart';
import '../models/enums.dart';

/// Thème sombre (défaut, identité de marque).
abstract final class AppColorsDark {
  // Backgrounds
  static const ink = Color(0xFF121D27); // background global
  static const surface = Color(0xFF1B2A38); // cards, écrans
  static const surfaceRaised = Color(0xFF223347); // inputs, cards élevées
  static const surfaceParchment = Color(0xFFEDE6D6); // carte Mission uniquement

  // Texte
  static const textPrimary = Color(0xFFECE5D4);
  static const textSecondary = Color(0xFFAFA792);
  static const textTertiary = Color(0xFF77828F);
  static const textOnParchment = Color(0xFF2A2115); // sur surface-parchment

  // Bordures
  static const border = Color(0x1AEDE6D6); // rgba(237,230,214,0.10)
  static const borderStrong = Color(0x2DEDE6D6); // rgba(237,230,214,0.18)

  // Accent principal : brass
  static const brass = Color(0xFFB8935B);
  static const brassBright = Color(0xFFDBB682);
  static const brassGlow = Color(0x38B8935B); // rgba(184,147,91,0.22)

  // Secondaire : sage
  static const sage = Color(0xFF7E9887);
  static const sageDim = Color(0x2E7E9887); // rgba(126,152,135,0.18)

  // Tertiaire : clay — jamais utilisé comme "erreur" alarmante
  static const clay = Color(0xFFB4705B);
  static const clayDim = Color(0x2EB4705B); // rgba(180,112,91,0.18)

  // Couleurs supplémentaires pour les rôles
  static const slate = Color(0xFF6A7B8C);
  static const slateDim = Color(0x2E6A7B8C);
  
  static const amethyst = Color(0xFF8A7B99);
  static const amethystDim = Color(0x2E8A7B99);

  static const moss = Color(0xFF6B7F5B);
  static const mossDim = Color(0x2E6B7F5B);
}

/// Thème clair.
abstract final class AppColorsLight {
  static const bg = Color(0xFFE7E0CF);
  static const surface = Color(0xFFF8F4E9);
  static const surfaceRaised = Color(0xFFFFFFFF);
  static const surfaceParchment = Color(0xFFFBF8F0);

  static const textPrimary = Color(0xFF202B34);
  static const textSecondary = Color(0xFF4A545F); // Darker gray for better visibility
  static const textTertiary = Color(0xFF697583); // Darker gray for better visibility

  static const brass = Color(0xFF9C7642);
  static const brassBright = Color(0xFFB8935B);
  static const brassGlow = Color(0x389C7642);

  // Sage/clay adaptés au thème clair (valeurs du mockup CSS)
  static const sage = Color(0xFF5C7566);
  static const sageDim = Color(0x245C7566); // rgba(92,117,102,0.14)
  static const clay = Color(0xFF9B5847);
  static const clayDim = Color(0x249B5847); // rgba(155,88,71,0.14)

  static const slate = Color(0xFF4E5F70);
  static const slateDim = Color(0x244E5F70);

  static const amethyst = Color(0xFF6D5E7A);
  static const amethystDim = Color(0x246D5E7A);

  static const moss = Color(0xFF506342);
  static const mossDim = Color(0x24506342);

  static const border = Color(0x1A202B34);
  static const borderStrong = Color(0x2D202B34);
}

/// Extension pratique pour lire les tokens depuis le contexte.
extension AppColorsX on BuildContext {
  bool get _isDark => Theme.of(this).brightness == Brightness.dark;

  Color get cInk =>
      _isDark ? AppColorsDark.ink : AppColorsLight.bg;
  Color get cSurface =>
      _isDark ? AppColorsDark.surface : AppColorsLight.surface;
  Color get cSurfaceRaised =>
      _isDark ? AppColorsDark.surfaceRaised : AppColorsLight.surfaceRaised;
  Color get cSurfaceParchment =>
      _isDark ? AppColorsDark.surfaceParchment : AppColorsLight.surfaceParchment;
  Color get cTextPrimary =>
      _isDark ? AppColorsDark.textPrimary : AppColorsLight.textPrimary;
  Color get cTextSecondary =>
      _isDark ? AppColorsDark.textSecondary : AppColorsLight.textSecondary;
  Color get cTextTertiary =>
      _isDark ? AppColorsDark.textTertiary : AppColorsLight.textTertiary;
  Color get cTextOnParchment =>
      _isDark ? AppColorsDark.textOnParchment : const Color(0xFF2A2115);
  Color get cBrass =>
      _isDark ? AppColorsDark.brass : AppColorsLight.brass;
  Color get cBrassBright =>
      _isDark ? AppColorsDark.brassBright : AppColorsLight.brassBright;
  Color get cBrassGlow =>
      _isDark ? AppColorsDark.brassGlow : AppColorsLight.brassGlow;
  Color get cSage => _isDark ? AppColorsDark.sage : AppColorsLight.sage;
  Color get cSageDim =>
      _isDark ? AppColorsDark.sageDim : AppColorsLight.sageDim;
  Color get cClay => _isDark ? AppColorsDark.clay : AppColorsLight.clay;
  Color get cClayDim =>
      _isDark ? AppColorsDark.clayDim : AppColorsLight.clayDim;
  Color get cSlate => _isDark ? AppColorsDark.slate : AppColorsLight.slate;
  Color get cSlateDim => _isDark ? AppColorsDark.slateDim : AppColorsLight.slateDim;
  Color get cAmethyst => _isDark ? AppColorsDark.amethyst : AppColorsLight.amethyst;
  Color get cAmethystDim => _isDark ? AppColorsDark.amethystDim : AppColorsLight.amethystDim;
  Color get cMoss => _isDark ? AppColorsDark.moss : AppColorsLight.moss;
  Color get cMossDim => _isDark ? AppColorsDark.mossDim : AppColorsLight.mossDim;
  Color get cError => cClay;
  Color get cBorder =>
      _isDark ? AppColorsDark.border : AppColorsLight.border;
  Color get cBorderStrong =>
      _isDark ? AppColorsDark.borderStrong : AppColorsLight.borderStrong;
}

extension RoleAccentColor on RoleAccent {
  Color color(BuildContext context) {
    switch (this) {
      case RoleAccent.brass: return context.cBrass;
      case RoleAccent.sage: return context.cSage;
      case RoleAccent.clay: return context.cClay;
      case RoleAccent.slate: return context.cSlate;
      case RoleAccent.amethyst: return context.cAmethyst;
      case RoleAccent.moss: return context.cMoss;
    }
  }
}
