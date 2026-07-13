// Enums partagés entre plusieurs features.
// Isar sérialise les enums par nom via @Enumerated(EnumType.name) —
// ne jamais réordonner les valeurs existantes en production (ça ne casse
// rien avec EnumType.name, contrairement à EnumType.ordinal, mais autant
// prendre la bonne habitude dès le départ).

/// Les 4 cases de la matrice de priorité.
/// `planifier` (Important, non urgent) est la zone que l'app pousse à privilégier.
enum PriorityLevel { agir, planifier, deleguer, laisserFiler }

extension PriorityLevelX on PriorityLevel {
  /// Dérive le niveau de priorité à partir des deux booléens du modèle Task.
  static PriorityLevel from({required bool important, required bool urgent}) {
    if (important && urgent) return PriorityLevel.agir;
    if (important && !urgent) return PriorityLevel.planifier;
    if (!important && urgent) return PriorityLevel.deleguer;
    return PriorityLevel.laisserFiler;
  }
}

/// Couleur d'accent d'un rôle de vie — reprend les tokens du design system
/// (voir core/theme/tokens.dart), jamais de rouge saturé.
enum RoleAccent { brass, sage, clay, slate, amethyst, moss }

/// Fournisseurs IA supportés par l'écran Paramètres.
enum AiProviderId { claude, gemini, openai, kimi, qwen, ollama }

extension AiProviderIdX on AiProviderId {
  /// Ollama tourne en local — aucune clé API n'est jamais requise.
  bool get requiresApiKey => this != AiProviderId.ollama;

  String get displayName => switch (this) {
        AiProviderId.claude => 'Claude',
        AiProviderId.gemini => 'Gemini',
        AiProviderId.openai => 'GPT',
        AiProviderId.kimi => 'Kimi',
        AiProviderId.qwen => 'Qwen',
        AiProviderId.ollama => 'Local (Ollama)',
      };
}

enum AppThemeMode { dark, light, system }

enum AppLocale { fr, en }
