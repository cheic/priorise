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
  static const onBrass = Color(0xFF1B140B); // encre sombre sur fond brass

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

  static const ocean = Color(0xFF5C8899);
  static const oceanDim = Color(0x2E5C8899);

  static const sand = Color(0xFFC4AB87);
  static const sandDim = Color(0x2EC4AB87);

  static const rose = Color(0xFFB57D8A);
  static const roseDim = Color(0x2EB57D8A);

  static const pine = Color(0xFF5A7A6B);
  static const pineDim = Color(0x2E5A7A6B);
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
  static const onBrass = Color(0xFF1B140B);

  // Sage/clay adaptés au thème clair avec opacité augmentée à 20% (0x33) pour lisibilité au soleil
  static const sage = Color(0xFF5C7566);
  static const sageDim = Color(0x335C7566); // rgba 20%
  static const clay = Color(0xFF9B5847);
  static const clayDim = Color(0x339B5847); 

  static const slate = Color(0xFF4E5F70);
  static const slateDim = Color(0x334E5F70);

  static const amethyst = Color(0xFF6D5E7A);
  static const amethystDim = Color(0x336D5E7A);

  static const moss = Color(0xFF506342);
  static const mossDim = Color(0x33506342);

  static const ocean = Color(0xFF466B7A);
  static const oceanDim = Color(0x33466B7A);

  static const sand = Color(0xFF9E8665);
  static const sandDim = Color(0x339E8665);

  static const rose = Color(0xFF945F6D);
  static const roseDim = Color(0x33945F6D);

  static const pine = Color(0xFF445E51);
  static const pineDim = Color(0x33445E51);

  static const border = Color(0x1A202B34);
  static const borderStrong = Color(0x2D202B34);
}

/// ThemeExtension M3 pour industrialiser le mapping des couleurs
/// et permettre l'interpolation fluide (lerp) lors des transitions de thème.
class AppColorsTheme extends ThemeExtension<AppColorsTheme> {
  final Color ink;
  final Color surface;
  final Color surfaceRaised;
  final Color surfaceParchment;
  final Color textPrimary;
  final Color textSecondary;
  final Color textTertiary;
  final Color textOnParchment;
  final Color brass;
  final Color brassBright;
  final Color brassGlow;
  final Color onBrass;
  final Color sage;
  final Color sageDim;
  final Color clay;
  final Color clayDim;
  final Color slate;
  final Color slateDim;
  final Color amethyst;
  final Color amethystDim;
  final Color moss;
  final Color mossDim;
  final Color ocean;
  final Color oceanDim;
  final Color sand;
  final Color sandDim;
  final Color rose;
  final Color roseDim;
  final Color pine;
  final Color pineDim;
  final Color error;
  final Color border;
  final Color borderStrong;

  const AppColorsTheme({
    required this.ink,
    required this.surface,
    required this.surfaceRaised,
    required this.surfaceParchment,
    required this.textPrimary,
    required this.textSecondary,
    required this.textTertiary,
    required this.textOnParchment,
    required this.brass,
    required this.brassBright,
    required this.brassGlow,
    required this.onBrass,
    required this.sage,
    required this.sageDim,
    required this.clay,
    required this.clayDim,
    required this.slate,
    required this.slateDim,
    required this.amethyst,
    required this.amethystDim,
    required this.moss,
    required this.mossDim,
    required this.ocean,
    required this.oceanDim,
    required this.sand,
    required this.sandDim,
    required this.rose,
    required this.roseDim,
    required this.pine,
    required this.pineDim,
    required this.error,
    required this.border,
    required this.borderStrong,
  });

  factory AppColorsTheme.dark() => const AppColorsTheme(
        ink: AppColorsDark.ink,
        surface: AppColorsDark.surface,
        surfaceRaised: AppColorsDark.surfaceRaised,
        surfaceParchment: AppColorsDark.surfaceParchment,
        textPrimary: AppColorsDark.textPrimary,
        textSecondary: AppColorsDark.textSecondary,
        textTertiary: AppColorsDark.textTertiary,
        textOnParchment: AppColorsDark.textOnParchment,
        brass: AppColorsDark.brass,
        brassBright: AppColorsDark.brassBright,
        brassGlow: AppColorsDark.brassGlow,
        onBrass: AppColorsDark.onBrass,
        sage: AppColorsDark.sage,
        sageDim: AppColorsDark.sageDim,
        clay: AppColorsDark.clay,
        clayDim: AppColorsDark.clayDim,
        slate: AppColorsDark.slate,
        slateDim: AppColorsDark.slateDim,
        amethyst: AppColorsDark.amethyst,
        amethystDim: AppColorsDark.amethystDim,
        moss: AppColorsDark.moss,
        mossDim: AppColorsDark.mossDim,
        ocean: AppColorsDark.ocean,
        oceanDim: AppColorsDark.oceanDim,
        sand: AppColorsDark.sand,
        sandDim: AppColorsDark.sandDim,
        rose: AppColorsDark.rose,
        roseDim: AppColorsDark.roseDim,
        pine: AppColorsDark.pine,
        pineDim: AppColorsDark.pineDim,
        error: AppColorsDark.clay,
        border: AppColorsDark.border,
        borderStrong: AppColorsDark.borderStrong,
      );

  factory AppColorsTheme.light() => const AppColorsTheme(
        ink: AppColorsLight.bg,
        surface: AppColorsLight.surface,
        surfaceRaised: AppColorsLight.surfaceRaised,
        surfaceParchment: AppColorsLight.surfaceParchment,
        textPrimary: AppColorsLight.textPrimary,
        textSecondary: AppColorsLight.textSecondary,
        textTertiary: AppColorsLight.textTertiary,
        textOnParchment: Color(0xFF2A2115),
        brass: AppColorsLight.brass,
        brassBright: AppColorsLight.brassBright,
        brassGlow: AppColorsLight.brassGlow,
        onBrass: AppColorsLight.onBrass,
        sage: AppColorsLight.sage,
        sageDim: AppColorsLight.sageDim,
        clay: AppColorsLight.clay,
        clayDim: AppColorsLight.clayDim,
        slate: AppColorsLight.slate,
        slateDim: AppColorsLight.slateDim,
        amethyst: AppColorsLight.amethyst,
        amethystDim: AppColorsLight.amethystDim,
        moss: AppColorsLight.moss,
        mossDim: AppColorsLight.mossDim,
        ocean: AppColorsLight.ocean,
        oceanDim: AppColorsLight.oceanDim,
        sand: AppColorsLight.sand,
        sandDim: AppColorsLight.sandDim,
        rose: AppColorsLight.rose,
        roseDim: AppColorsLight.roseDim,
        pine: AppColorsLight.pine,
        pineDim: AppColorsLight.pineDim,
        error: AppColorsLight.clay,
        border: AppColorsLight.border,
        borderStrong: AppColorsLight.borderStrong,
      );

  @override
  AppColorsTheme copyWith({
    Color? ink,
    Color? surface,
    Color? surfaceRaised,
    Color? surfaceParchment,
    Color? textPrimary,
    Color? textSecondary,
    Color? textTertiary,
    Color? textOnParchment,
    Color? brass,
    Color? brassBright,
    Color? brassGlow,
    Color? onBrass,
    Color? sage,
    Color? sageDim,
    Color? clay,
    Color? clayDim,
    Color? slate,
    Color? slateDim,
    Color? amethyst,
    Color? amethystDim,
    Color? moss,
    Color? mossDim,
    Color? ocean,
    Color? oceanDim,
    Color? sand,
    Color? sandDim,
    Color? rose,
    Color? roseDim,
    Color? pine,
    Color? pineDim,
    Color? error,
    Color? border,
    Color? borderStrong,
  }) {
    return AppColorsTheme(
      ink: ink ?? this.ink,
      surface: surface ?? this.surface,
      surfaceRaised: surfaceRaised ?? this.surfaceRaised,
      surfaceParchment: surfaceParchment ?? this.surfaceParchment,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      textTertiary: textTertiary ?? this.textTertiary,
      textOnParchment: textOnParchment ?? this.textOnParchment,
      brass: brass ?? this.brass,
      brassBright: brassBright ?? this.brassBright,
      brassGlow: brassGlow ?? this.brassGlow,
      onBrass: onBrass ?? this.onBrass,
      sage: sage ?? this.sage,
      sageDim: sageDim ?? this.sageDim,
      clay: clay ?? this.clay,
      clayDim: clayDim ?? this.clayDim,
      slate: slate ?? this.slate,
      slateDim: slateDim ?? this.slateDim,
      amethyst: amethyst ?? this.amethyst,
      amethystDim: amethystDim ?? this.amethystDim,
      moss: moss ?? this.moss,
      mossDim: mossDim ?? this.mossDim,
      ocean: ocean ?? this.ocean,
      oceanDim: oceanDim ?? this.oceanDim,
      sand: sand ?? this.sand,
      sandDim: sandDim ?? this.sandDim,
      rose: rose ?? this.rose,
      roseDim: roseDim ?? this.roseDim,
      pine: pine ?? this.pine,
      pineDim: pineDim ?? this.pineDim,
      error: error ?? this.error,
      border: border ?? this.border,
      borderStrong: borderStrong ?? this.borderStrong,
    );
  }

  @override
  AppColorsTheme lerp(ThemeExtension<AppColorsTheme>? other, double t) {
    if (other is! AppColorsTheme) return this;
    return AppColorsTheme(
      ink: Color.lerp(ink, other.ink, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      surfaceRaised: Color.lerp(surfaceRaised, other.surfaceRaised, t)!,
      surfaceParchment: Color.lerp(surfaceParchment, other.surfaceParchment, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      textTertiary: Color.lerp(textTertiary, other.textTertiary, t)!,
      textOnParchment: Color.lerp(textOnParchment, other.textOnParchment, t)!,
      brass: Color.lerp(brass, other.brass, t)!,
      brassBright: Color.lerp(brassBright, other.brassBright, t)!,
      brassGlow: Color.lerp(brassGlow, other.brassGlow, t)!,
      onBrass: Color.lerp(onBrass, other.onBrass, t)!,
      sage: Color.lerp(sage, other.sage, t)!,
      sageDim: Color.lerp(sageDim, other.sageDim, t)!,
      clay: Color.lerp(clay, other.clay, t)!,
      clayDim: Color.lerp(clayDim, other.clayDim, t)!,
      slate: Color.lerp(slate, other.slate, t)!,
      slateDim: Color.lerp(slateDim, other.slateDim, t)!,
      amethyst: Color.lerp(amethyst, other.amethyst, t)!,
      amethystDim: Color.lerp(amethystDim, other.amethystDim, t)!,
      moss: Color.lerp(moss, other.moss, t)!,
      mossDim: Color.lerp(mossDim, other.mossDim, t)!,
      ocean: Color.lerp(ocean, other.ocean, t)!,
      oceanDim: Color.lerp(oceanDim, other.oceanDim, t)!,
      sand: Color.lerp(sand, other.sand, t)!,
      sandDim: Color.lerp(sandDim, other.sandDim, t)!,
      rose: Color.lerp(rose, other.rose, t)!,
      roseDim: Color.lerp(roseDim, other.roseDim, t)!,
      pine: Color.lerp(pine, other.pine, t)!,
      pineDim: Color.lerp(pineDim, other.pineDim, t)!,
      error: Color.lerp(error, other.error, t)!,
      border: Color.lerp(border, other.border, t)!,
      borderStrong: Color.lerp(borderStrong, other.borderStrong, t)!,
    );
  }
}

/// Extension pratique pour lire les tokens depuis le contexte via ThemeExtension.
extension AppColorsX on BuildContext {
  AppColorsTheme get _colors =>
      Theme.of(this).extension<AppColorsTheme>() ??
      (Theme.of(this).brightness == Brightness.dark
          ? AppColorsTheme.dark()
          : AppColorsTheme.light());

  Color get cInk => _colors.ink;
  Color get cSurface => _colors.surface;
  Color get cSurfaceRaised => _colors.surfaceRaised;
  Color get cSurfaceParchment => _colors.surfaceParchment;
  Color get cTextPrimary => _colors.textPrimary;
  Color get cTextSecondary => _colors.textSecondary;
  Color get cTextTertiary => _colors.textTertiary;
  Color get cTextOnParchment => _colors.textOnParchment;
  Color get cBrass => _colors.brass;
  Color get cBrassBright => _colors.brassBright;
  Color get cBrassGlow => _colors.brassGlow;
  Color get cOnBrass => _colors.onBrass;
  Color get cSage => _colors.sage;
  Color get cSageDim => _colors.sageDim;
  Color get cClay => _colors.clay;
  Color get cClayDim => _colors.clayDim;
  Color get cSlate => _colors.slate;
  Color get cSlateDim => _colors.slateDim;
  Color get cAmethyst => _colors.amethyst;
  Color get cAmethystDim => _colors.amethystDim;
  Color get cMoss => _colors.moss;
  Color get cMossDim => _colors.mossDim;
  Color get cOcean => _colors.ocean;
  Color get cOceanDim => _colors.oceanDim;
  Color get cSand => _colors.sand;
  Color get cSandDim => _colors.sandDim;
  Color get cRose => _colors.rose;
  Color get cRoseDim => _colors.roseDim;
  Color get cPine => _colors.pine;
  Color get cPineDim => _colors.pineDim;
  Color get cError => _colors.error;
  Color get cBorder => _colors.border;
  Color get cBorderStrong => _colors.borderStrong;
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
      case RoleAccent.ocean: return context.cOcean;
      case RoleAccent.sand: return context.cSand;
      case RoleAccent.rose: return context.cRose;
      case RoleAccent.pine: return context.cPine;
    }
  }
}
