import 'dart:convert';

/// Filet de sécurité manuel en complément d'Android Auto Backup.
///
/// Exporte toutes les données Isar (Mission, LifeRole, WeeklyPlan, Task,
/// WeeklyReview, AppSettings) vers un unique JSON que l'utilisateur choisit
/// où sauvegarder (via share_plus / file_picker — pas d'upload automatique
/// vers un serveur à nous, cohérent avec le principe local-first).
///
/// VOLONTAIREMENT EXCLU de l'export : AiProviderConfig.apiKeySecureRef.
/// Les clés API ne quittent jamais flutter_secure_storage, même dans un
/// export — l'utilisateur les ressaisit après une restauration. C'est un
/// choix de sécurité assumé, pas un oubli.
class BackupService {
  BackupService(this._isar);
  // ignore: unused_field
  final dynamic _isar; // Isar — typé dynamic ici pour ne pas imposer l'import dans ce fichier de référence

  Future<String> exportToJson() async {
    // final missions = await _isar.missions.where().findAll();
    // final roles = await _isar.lifeRoles.where().findAll();
    // final plans = await _isar.weeklyPlans.where().findAll();
    // final tasks = await _isar.tasks.where().findAll();
    // final reviews = await _isar.weeklyReviews.where().findAll();
    //
    // final payload = {
    //   'exportedAt': DateTime.now().toIso8601String(),
    //   'schemaVersion': 1,
    //   'missions': missions.map((m) => m.toJson()).toList(),
    //   'roles': roles.map((r) => r.toJson()).toList(),
    //   'weeklyPlans': plans.map((p) => p.toJson()).toList(),
    //   'tasks': tasks.map((t) => t.toJson()).toList(),
    //   'weeklyReviews': reviews.map((r) => r.toJson()).toList(),
    //   // AiProviderConfig volontairement absent de l'export.
    // };
    // return jsonEncode(payload);
    throw UnimplementedError(
      'Squelette de référence — brancher sur les vraies collections Isar '
      'une fois les .g.dart générés via build_runner.',
    );
  }

  Future<void> importFromJson(String jsonPayload) async {
    final payload = jsonDecode(jsonPayload) as Map<String, dynamic>;
    final schemaVersion = payload['schemaVersion'] as int? ?? 0;
    if (schemaVersion != 1) {
      throw StateError('Version de sauvegarde non supportée : $schemaVersion');
    }
    // Écrire dans une transaction Isar unique, remplacer les collections
    // existantes plutôt que de fusionner (évite les doublons de BigRock
    // qui violeraient la contrainte "une pierre par rôle et par semaine").
    throw UnimplementedError('Squelette de référence — voir exportToJson().');
  }
}
