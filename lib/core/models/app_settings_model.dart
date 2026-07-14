import 'package:isar/isar.dart';
import 'package:priorise/core/models/enums.dart';

part 'app_settings_model.g.dart';

/// Réglages globaux — écran "Paramètres" (Apparence, langue) et gestion du
/// parcours de premier lancement (splash → onboarding → app).
///
/// Singleton logique : le repository doit toujours utiliser l'id fixe
/// `AppSettings.singletonId` plutôt que d'appeler `Isar.autoIncrement`, pour
/// garantir qu'une seule ligne existe jamais dans la collection.
@collection
class AppSettings {
  static const int singletonId = 1;

  Id id = Isar.autoIncrement;

  @Enumerated(EnumType.name)
  AppThemeMode themeMode = AppThemeMode.dark;

  @Enumerated(EnumType.name)
  AppLocale locale = AppLocale.fr;

  /// "Une seule notification par jour, jamais plus" — voir mockup Paramètres.
  bool gentleRemindersEnabled = false;

  /// Off par défaut — l'IA est strictement opt-in, jamais activée d'office.
  bool aiSuggestionsEnabled = false;

  /// Le fournisseur d'IA sélectionné.
  String aiProvider = 'Claude';

  /// La clé d'API pour le fournisseur.
  String aiApiKey = '';

  /// Contrôle la redirection Splash → Onboarding vs Splash → Aujourd'hui.
  bool firstLaunchCompleted = false;
}
