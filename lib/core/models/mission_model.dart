import 'package:isar/isar.dart';

part 'mission_model.g.dart';

/// Écran "Mission" du mockup.
/// Singleton logique : l'app ne doit jamais en créer qu'une seule instance
/// (voir MissionRepository.getOrCreate() côté data layer) — on ne force pas
/// ça au niveau du modèle Isar lui-même pour rester simple, mais c'est une
/// invariant métier à respecter dans le repository.
@collection
class Mission {
  Id id = Isar.autoIncrement;

  /// Le texte de la déclaration de mission, tel qu'affiché dans la
  /// mission-card du mockup (police Fraunces italique).
  late String statement;

  DateTime lastEditedAt = DateTime.now();

  /// Réponses aux questions guides — conservées séparément du texte final
  /// pour permettre de les rouvrir lors d'une prochaine révision, sans
  /// perdre le raisonnement qui a mené à la déclaration actuelle.
  String? whoQuestion; // "Qui voulez-vous être ?"
  String? whatQuestion; // "Que voulez-vous accomplir, et pour qui ?"
  String? principlesQuestion; // "Sur quels principes refusez-vous de transiger ?"
}
