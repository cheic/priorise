import 'package:isar/isar.dart';

part 'weekly_plan_model.g.dart';

/// Écran "Planification" (bocal aux grosses pierres) du mockup.
///
/// Une instance par semaine calendaire — `weekStart` est toujours normalisé
/// au lundi 00:00 de la semaine concernée, ce qui permet une contrainte
/// d'unicité propre et une résolution simple "semaine courante".
///
/// CONTRAINTE MÉTIER NON NÉGOCIABLE : `bigRocks` ne doit contenir au plus
/// UNE entrée par `roleId`. C'est le repository (WeeklyPlanRepository) qui
/// fait respecter cette règle à l'écriture — Isar ne peut pas l'exprimer
/// nativement sur une liste d'objets embarqués, donc ne JAMAIS insérer de
/// BigRock directement sans passer par
/// `WeeklyPlanRepository.setBigRockForRole(roleId, text)`, qui remplace
/// l'entrée existante au lieu d'en ajouter une seconde.
@collection
class WeeklyPlan {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late DateTime weekStart;

  /// Passe à `true` quand l'utilisateur tape "Valider ma semaine".
  /// Avant validation, l'écran Aujourd'hui affiche la ritual-banner.
  bool validated = false;
  DateTime? validatedAt;

  List<BigRock> bigRocks = [];

  /// Seule la semaine dont `weekStart` correspond au lundi courant est
  /// éditable dans l'UI (voir réponse sur la planification à l'avance) —
  /// cette règle est appliquée côté Cubit/UI, pas ici, mais elle dépend de
  /// ce champ pour être vérifiée.
  @ignore
  bool get isCurrentWeek {
    final now = DateTime.now();
    final mondayNow = now.subtract(Duration(days: now.weekday - 1));
    final normalizedNow = DateTime(mondayNow.year, mondayNow.month, mondayNow.day);
    return weekStart == normalizedNow;
  }
}

/// Une grosse pierre : LA priorité d'un rôle pour une semaine donnée.
/// Objet embarqué — n'existe pas en dehors d'un WeeklyPlan.
@embedded
class BigRock {
  int roleId = 0;
  String text = '';
  bool achieved = false;
}
