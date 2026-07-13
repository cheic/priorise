import 'package:isar/isar.dart';
import 'package:priorise/core/models/enums.dart';

part 'ai_provider_model.g.dart';

/// Écran "Paramètres" du mockup — section Intelligence artificielle.
///
/// SÉCURITÉ : ce modèle ne contient JAMAIS la clé API en clair. `apiKeySecureRef`
/// n'est qu'une référence (l'identifiant de l'entrée) vers flutter_secure_storage,
/// résolue uniquement au moment de l'appel réseau par AiService — jamais gardée
/// en mémoire plus longtemps que nécessaire. Voir BOUSSOLE_BUILD_AGENT.md /
/// PRIORISE_BUILD_AGENT.md, section Sécurité des clés API.
@collection
class AiProviderConfig {
  Id id = Isar.autoIncrement;

  @Enumerated(EnumType.name)
  @Index(unique: true, replace: true)
  late AiProviderId providerId;

  String model = '';

  /// Référence opaque vers flutter_secure_storage — jamais la clé elle-même.
  /// Null pour Ollama, qui ne nécessite aucune clé.
  String? apiKeySecureRef;

  /// URL de l'hôte local, uniquement pertinent quand providerId == ollama
  /// (ex. "http://localhost:11434").
  String? ollamaHostUrl;

  /// Un seul provider actif à la fois — c'est celui utilisé par AiService.
  /// Le repository doit désactiver les autres lors de l'activation de celui-ci.
  bool isActive = false;

  DateTime? lastTestedAt;
  bool? lastTestSucceeded;
}
