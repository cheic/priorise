# Priorise

Une application Flutter de gestion de tâches (Task Management) axée sur la priorisation par rôles et par matrice d'importance/urgence.

## Fonctionnalités Principales
- **Gestion des Rôles** : Catégorisez vos tâches par rôle (ex. Travail, Personnel, Santé) et donnez un "Big Rock" (objectif principal) pour chaque rôle.
- **Matrice de Priorité** : Triez vos tâches selon leur urgence et importance (Stratégique, Planifier, Déléguer, Éliminer).
- **Thème Dynamique** : Support complet du mode Clair / Sombre, avec synchronisation native au niveau de l'OS (Android 12+ et iOS 13+).
- **Localisation** : Application multi-lingue (Support du Français et de l'Anglais).
- **Vue Aujourd'hui** : Restez concentré(e) sur ce qui compte grâce au widget Focus et au suivi quotidien.

## Architecture
Le projet suit les principes de **Clean Architecture** et utilise **Cubit / Bloc** pour la gestion d'état.

### Structure des dossiers (`lib/`)
- `core/` : Composants transverses (thème, typographie, couleurs, configuration routeur, injection de dépendances).
- `features/` : Les fonctionnalités isolées de l'application (ex: `roles/`, `tasks/`, `today/`).
- `l10n/` : Fichiers de localisation et de traduction (`.arb`).

## Démarrage (Getting Started)

1. Assurez-vous d'avoir [Flutter](https://flutter.dev) installé sur votre machine.
2. Clonez ce dépôt.
3. Exécutez `flutter pub get` pour installer les dépendances.
4. (Optionnel) Si vous ajoutez de nouvelles traductions dans les fichiers `.arb`, lancez un build ou `flutter gen-l10n`.
5. Exécutez le projet avec `flutter run`.


