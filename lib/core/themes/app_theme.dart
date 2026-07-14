// ThemeData Priorise — sombre et clair.
// Tokens appliqués à tous les composants Material par défaut.
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../tokens/app_colors.dart';
import '../tokens/app_spacing.dart';
import '../tokens/app_typography.dart';

// Défini hors de la classe pour éviter une ambiguïté de résolution de scope
// de l'analyseur Dart avec les abstract final class.
// Flutter 3.44+ : CupertinoPageTransitionsBuilder supprimé — on utilise
// ZoomPageTransitionsBuilder (Material 3 default) sur toutes les plateformes.
final _pageTransitions = PageTransitionsTheme(
  builders: {
    TargetPlatform.android: ZoomPageTransitionsBuilder(),
    TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
  },
);

abstract final class AppTheme {
  // ── Thème sombre ──────────────────────────────────────────────────────────
  static ThemeData dark() {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColorsDark.ink,
      colorScheme: const ColorScheme.dark(
        surface: AppColorsDark.surface,
        primary: AppColorsDark.brass,
        onPrimary: AppColorsDark.ink,
        secondary: AppColorsDark.sage,
        onSecondary: AppColorsDark.ink,
        tertiary: AppColorsDark.clay,
        onTertiary: AppColorsDark.ink,
        onSurface: AppColorsDark.textPrimary,
        outline: AppColorsDark.border,
        outlineVariant: AppColorsDark.borderStrong,
      ),
      textTheme: _buildTextTheme(
          AppColorsDark.textPrimary, AppColorsDark.textSecondary),
      cardTheme: CardThemeData(
        color: AppColorsDark.surface,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusM),
          side: const BorderSide(color: AppColorsDark.border),
        ),
        elevation: 0,
        margin: EdgeInsets.zero,
      ),
      inputDecorationTheme: _inputTheme(
        AppColorsDark.surfaceRaised,
        AppColorsDark.border,
        AppColorsDark.brass,
        AppColorsDark.textPrimary,
        AppColorsDark.textSecondary,
      ),
      elevatedButtonTheme:
          _elevatedButtonTheme(AppColorsDark.brass, AppColorsDark.ink),
      filledButtonTheme:
          _filledButtonTheme(AppColorsDark.brass, AppColorsDark.ink),
      outlinedButtonTheme: _outlinedButtonTheme(
          AppColorsDark.brass, AppColorsDark.textPrimary),
      textButtonTheme: _textButtonTheme(AppColorsDark.brass),
      dividerTheme:
          const DividerThemeData(color: AppColorsDark.border, thickness: 1),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColorsDark.ink,
        foregroundColor: AppColorsDark.textPrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        titleTextStyle:
            AppTypography.displaySmall(color: AppColorsDark.textPrimary),
      ),
      pageTransitionsTheme: _pageTransitions,
      useMaterial3: true,
    );
  }

  // ── Thème clair ───────────────────────────────────────────────────────────
  static ThemeData light() {
    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColorsLight.bg,
      colorScheme: const ColorScheme.light(
        surface: AppColorsLight.surface,
        primary: AppColorsLight.brass,
        onPrimary: Colors.white,
        secondary: AppColorsLight.sage,
        onSecondary: Colors.white,
        tertiary: AppColorsLight.clay,
        onTertiary: Colors.white,
        onSurface: AppColorsLight.textPrimary,
        outline: AppColorsLight.border,
        outlineVariant: AppColorsLight.borderStrong,
      ),
      textTheme: _buildTextTheme(
          AppColorsLight.textPrimary, AppColorsLight.textSecondary),
      cardTheme: CardThemeData(
        color: AppColorsLight.surface,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusM),
          side: const BorderSide(color: AppColorsLight.border),
        ),
        elevation: 0,
        margin: EdgeInsets.zero,
      ),
      inputDecorationTheme: _inputTheme(
        AppColorsLight.surfaceRaised,
        AppColorsLight.border,
        AppColorsLight.brass,
        AppColorsLight.textPrimary,
        AppColorsLight.textSecondary,
      ),
      elevatedButtonTheme:
          _elevatedButtonTheme(AppColorsLight.brass, Colors.white),
      filledButtonTheme:
          _filledButtonTheme(AppColorsLight.brass, Colors.white),
      outlinedButtonTheme: _outlinedButtonTheme(
          AppColorsLight.brass, AppColorsLight.textPrimary),
      textButtonTheme: _textButtonTheme(AppColorsLight.brass),
      dividerTheme:
          const DividerThemeData(color: AppColorsLight.border, thickness: 1),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColorsLight.bg,
        foregroundColor: AppColorsLight.textPrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        titleTextStyle:
            AppTypography.displaySmall(color: AppColorsLight.textPrimary),
      ),
      pageTransitionsTheme: _pageTransitions,
      useMaterial3: true,
    );
  }

  // ── Helpers privés ────────────────────────────────────────────────────────

  static TextTheme _buildTextTheme(Color primary, Color secondary) => TextTheme(
        displayLarge: AppTypography.displayLarge(color: primary),
        displayMedium: AppTypography.displayMedium(color: primary),
        displaySmall: AppTypography.displaySmall(color: primary),
        bodyLarge: AppTypography.bodyLarge(color: primary),
        bodyMedium: AppTypography.bodyMedium(color: primary),
        bodySmall: AppTypography.bodySmall(color: secondary),
        labelLarge: AppTypography.labelLarge(color: primary),
        labelMedium: AppTypography.labelMedium(color: secondary),
      );

  static InputDecorationTheme _inputTheme(
    Color fill,
    Color border,
    Color focus,
    Color text,
    Color hint,
  ) =>
      InputDecorationTheme(
        filled: true,
        fillColor: fill,
        hintStyle: AppTypography.bodyMedium(color: hint),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.l,
          vertical: AppSpacing.m,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusS),
          borderSide: BorderSide(color: border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusS),
          borderSide: BorderSide(color: border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusS),
          borderSide: BorderSide(color: focus, width: 1.5),
        ),
      );

  static ElevatedButtonThemeData _elevatedButtonTheme(
          Color bg, Color fg) =>
      ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: bg,
          foregroundColor: fg,
          textStyle: AppTypography.buttonText(color: fg),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.radiusS),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.xxl,
            vertical: AppSpacing.m + 2,
          ),
          elevation: 0,
        ),
      );

  static FilledButtonThemeData _filledButtonTheme(Color bg, Color fg) =>
      FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: bg,
          foregroundColor: fg,
          textStyle: AppTypography.buttonText(color: fg),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.radiusS),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.xxl,
            vertical: AppSpacing.m + 2,
          ),
          elevation: 0,
        ),
      );

  static OutlinedButtonThemeData _outlinedButtonTheme(
          Color border, Color fg) =>
      OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: fg,
          side: BorderSide(color: border),
          textStyle: AppTypography.buttonText(color: fg),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.radiusS),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.xxl,
            vertical: AppSpacing.m + 2,
          ),
        ),
      );

  static TextButtonThemeData _textButtonTheme(Color fg) =>
      TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: fg,
          textStyle: AppTypography.labelLarge(color: fg),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.radiusS),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.m,
            vertical: AppSpacing.s,
          ),
        ),
      );
}
