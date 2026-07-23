# Priorise

Une application Flutter minimaliste de gestion de temps et d'objectifs, axée sur la priorisation par rôles de vie et la **Matrice d'Eisenhower**. Contrairement aux to-do lists classiques, *Priorise* ne gère pas votre temps par le calendrier, mais par l'impact de vos actions.

## 🧠 La Philosophie "Priorise" (À lire avant de coder)

Si vous revenez sur ce projet après un an, souvenez-vous de cette philosophie centrale qui dicte toute l'interface et les modèles de données :

1. **Les Rôles de Vie** : Vous n'êtes pas qu'un employé. Vous êtes un parent, un ami, un sportif, etc. Chaque tâche appartient à un Rôle pour garantir l'équilibre.
2. **Les Grosses Pierres (Big Rocks)** : Ce sont les objectifs majeurs de la semaine pour chaque Rôle (Planifiés via la vue *Plan*). Ils représentent la direction.
3. **Le Gravier (Tâches Ponctuelles)** : Les petites choses du quotidien. **Volontairement**, ces tâches n'ont pas d'heure ni de date d'échéance dans l'interface. Le but est de vider votre charge mentale en les notant, pas de jouer à Tetris avec votre agenda.
4. **La Matrice d'Eisenhower** : Le moteur de l'application. Plutôt que de dire *quand* faire une chose, on définit si elle est **Importante** et/ou **Urgente**. C'est la Matrice qui dicte ce que l'on doit faire dans la vue *Aujourd'hui*, en poussant l'utilisateur à se concentrer sur l'Important / Non-Urgent (la progression).
5. **Pas de micro-management de Notifications** : L'application n'envoie qu'une seule alerte quotidienne à 9h00 (Rappel en douceur) pour vous recentrer sur votre mission et vos Grosses Pierres. Elle ne sonne pas pour les tâches ponctuelles.

*(Note technique : le modèle `Task` dans le code possède un champ `dueDate`, mais il est intentionnellement ignoré par l'interface UI pour respecter cette philosophie).*

---

## 🏗️ Architecture et Codebase (Pour s'y retrouver dans 1 an)

Le projet suit les principes de la **Clean Architecture** (orientée *Feature-first*). 

### Stack Technique :
- **Framework** : Flutter / Dart.
- **State Management** : `flutter_bloc` (Cubit). Chaque écran complexe a son propre Cubit.
- **Base de données** : `Isar Database` (NoSQL, ultra rapide, locale). Les modèles sont générés via `build_runner`.
- **Injection de dépendances** : `get_it` (initialisé dans `core/di/injection.dart`).

### Structure des dossiers (`lib/`) :

- `core/` : Le cœur technique de l'application.
  - `di/` : Injection de dépendances (`get_it`).
  - `models/` : Modèles Isar (`mission_model.dart`, `task_model.dart`, etc.). C'est ici que sont définies les tables de la DB. **Attention : si vous modifiez ces fichiers, lancez `dart run build_runner build`**.
  - `services/` : Services externes (Base de données, Notifications locales, Stockage sécurisé).
  - `themes/` et `tokens/` : Le Design System (couleurs, espacements, typographie).
- `features/` : Les fonctionnalités (découpées par écrans).
  - `mission/`, `plan/`, `roles/`, `settings/`, `shell/`, `today/`.
  - Dans chaque feature, vous trouverez un dossier `presentation/` contenant l'UI (`_screen.dart`) et la logique (`_cubit.dart`).
- `l10n/` : Fichiers de traduction (`.arb`). Le texte affiché dans l'UI se trouve ici.

---

## 🚀 Aide-mémoire pour la maintenance

1. **Où est la logique de sauvegarde ?**
   Tout passe par les *Services* injectés via GetIt (ex: `DatabaseService`). Les Cubits appellent ces services.
2. **Comment relancer la génération Isar (modèles de DB) ?**
   Si vous modifiez un fichier dans `core/models/`, exécutez dans le terminal :
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```
3. **Le clignotement / Flash UI**
   La base de code évite de reconstruire entièrement un écran lors d'une sauvegarde pour éviter l'effet de flash. Les Cubits émettent directement des états chargés (Loaded) plutôt que de repasser par (Loading) pour des opérations rapides en base locale.

## Démarrage rapide

1. Clonez ce dépôt.
2. Exécutez `flutter pub get`.
3. Lancez le générateur de code (si les fichiers `.g.dart` sont absents) : `dart run build_runner build`.
4. Exécutez le projet avec `flutter run`.


