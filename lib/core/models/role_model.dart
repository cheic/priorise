import 'package:isar/isar.dart';
import 'package:priorise/core/models/enums.dart';

part 'role_model.g.dart';

/// Écran "Rôles de vie" du mockup.
///
/// Identité stable dans le temps — contrairement à `BigRock` (voir
/// planning/domain/weekly_plan_model.dart), un LifeRole n'est PAS lié à une
/// semaine précise. C'est la structure permanente ; ce qu'on y accroche
/// chaque dimanche est éphémère et vit ailleurs.
@collection
class LifeRole {
  Id id = Isar.autoIncrement;

  @Index()
  late String name; // "Famille", "Professionnel(le)"...

  /// Clé résolue vers une icône du design system (voir shared/widgets/role_icons.dart),
  /// jamais un chemin d'asset en dur.
  late String iconKey;

  @Enumerated(EnumType.name)
  RoleAccent accent = RoleAccent.brass;

  /// Ordre d'affichage dans le role-scroll de l'écran Aujourd'hui et la
  /// grille de l'écran Rôles.
  int sortOrder = 0;

  /// Un rôle archivé disparaît des écrans actifs (Aujourd'hui, Planification)
  /// mais reste résolvable depuis l'historique des WeeklyReview passées —
  /// on ne supprime jamais un rôle en dur pour ne pas casser l'historique.
  bool archived = false;

  DateTime createdAt = DateTime.now();
}
