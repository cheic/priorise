import 'package:isar/isar.dart';
import 'package:priorise/core/models/enums.dart';

part 'task_model.g.dart';

/// Tâches affichées sur l'écran Aujourd'hui ("Le reste de la semaine") et
/// positionnées sur l'écran Matrice.
///
/// Volontairement PAS de champ `priority: high/medium/low` — le couple
/// `important`/`urgent` force le passage par la matrice plutôt qu'un tri
/// arbitraire. C'est le point de design le plus important de ce modèle :
/// ne jamais céder à la tentation d'ajouter un champ de priorité à côté.
@collection
class Task {
  Id id = Isar.autoIncrement;

  late String title;

  @Index()
  late int roleId; // référence LifeRole.id

  bool important = false;
  bool urgent = false;

  bool done = false;
  DateTime createdAt = DateTime.now();
  DateTime? doneAt;
  DateTime? dueDate;

  /// Sous-tâches générées par l'IA à la demande (jamais automatiquement) —
  /// voir AiProvider.decomposeTask(). Null tant que l'utilisateur n'a pas
  /// explicitement demandé une décomposition.
  String? aiDecomposition;

  /// Semaine à laquelle cette tâche est rattachée pour l'affichage sur
  /// Aujourd'hui/Matrice — indépendant de `dueDate`, qui reste optionnel.
  @Index()
  late DateTime weekStart;

  @ignore
  PriorityLevel get priorityLevel => PriorityLevelX.from(important: important, urgent: urgent);
}
