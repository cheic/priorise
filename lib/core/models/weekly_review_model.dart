import 'package:isar/isar.dart';

part 'weekly_review_model.g.dart';

/// Écran "Bilan de la semaine" du mockup.
///
/// Deux natures de données bien distinctes dans ce modèle — c'est le point
/// qui prêtait à confusion dans le mockup HTML, corrigé ici explicitement :
///
/// 1. `whatWorked` / `whatSlipped` / `aiSynthesis` : SAISIE LIBRE de
///    l'utilisateur (les `<textarea>` du mockup). Restent en local, ne sont
///    jamais lues automatiquement par quoi que ce soit — `aiSynthesis` n'est
///    remplie que si l'utilisateur appuie explicitement sur "Synthétiser
///    avec l'IA" ET a activé les suggestions IA dans Paramètres.
///
/// 2. `attentionByRole` : CALCULÉ, jamais saisi par l'utilisateur. Recalculé
///    par `AttentionCalculator.compute(weekStart)` à partir des `Task.done`
///    et `BigRock.achieved` de la semaine — voir
///    core/services/attention_calculator.dart (à créer côté data layer).
@collection
class WeeklyReview {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late DateTime weekStart;

  // ---- Journal libre (saisie utilisateur) ----
  String? whatWorked;
  String? whatSlipped;

  /// Généré uniquement à la demande explicite, jamais en tâche de fond.
  String? aiSynthesis;
  DateTime? aiSynthesisGeneratedAt;

  // ---- Données calculées (jamais saisies) ----
  List<RoleAttention> attentionByRole = [];
}

/// `daysOfAttention` va de 0 à 3 — volontairement pas un pourcentage ni une
/// note sur 10 : c'est un signal doux ("miroir, pas jugement"), jamais un
/// score qu'on pourrait afficher en rouge/vert.
@embedded
class RoleAttention {
  int roleId = 0;
  int daysOfAttention = 0;
}
