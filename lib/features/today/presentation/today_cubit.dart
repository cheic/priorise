// today_cubit.dart — état de l'écran Aujourd'hui.
//
// Gère : chargement des rôles, résumé de la journée, liste des tâches du jour.
// Modèle LifeRole : weeklyBigRock est un String? unique (non négociable).
// Aucune clé API, aucun print() de données sensibles.
import 'package:flutter_bloc/flutter_bloc.dart';

// ── Modèles légers (seront remplacés par les entités Isar en phase 2) ──────

class LifeRole {
  const LifeRole({
    required this.id,
    required this.name,
    required this.colorToken,
    this.weeklyBigRock, // String? unique — contrainte non négociable
    this.icon,
  });

  final String id;
  final String name;

  /// Token couleur : 'brass', 'sage', 'clay' — jamais une valeur hex brute.
  final String colorToken;

  /// Une seule grosse pierre par rôle et par semaine.
  final String? weeklyBigRock;

  final String? icon;
}

class DailyTask {
  const DailyTask({
    required this.id,
    required this.title,
    required this.roleId,
    this.isDone = false,
    this.isStrategic = false,
  });

  final String id;
  final String title;
  final String roleId;
  final bool isDone;

  /// Vrai si la tâche est Stratégique (importante, non urgente).
  final bool isStrategic;

  DailyTask copyWith({bool? isDone}) =>
      DailyTask(
        id: id,
        title: title,
        roleId: roleId,
        isDone: isDone ?? this.isDone,
        isStrategic: isStrategic,
      );
}

// ── State ──────────────────────────────────────────────────────────────────

sealed class TodayState {}

class TodayLoading extends TodayState {}

class TodayLoaded extends TodayState {
  TodayLoaded({
    required this.roles,
    required this.tasks,
    required this.selectedRoleId,
  });

  final List<LifeRole> roles;
  final List<DailyTask> tasks;
  final String? selectedRoleId;

  List<DailyTask> get visibleTasks => selectedRoleId == null
      ? tasks
      : tasks.where((t) => t.roleId == selectedRoleId).toList();

  int get doneCount => tasks.where((t) => t.isDone).length;
  int get totalCount => tasks.length;

  TodayLoaded copyWith({
    List<LifeRole>? roles,
    List<DailyTask>? tasks,
    String? selectedRoleId,
    bool clearRoleFilter = false,
  }) =>
      TodayLoaded(
        roles: roles ?? this.roles,
        tasks: tasks ?? this.tasks,
        selectedRoleId: clearRoleFilter ? null : (selectedRoleId ?? this.selectedRoleId),
      );
}

class TodayError extends TodayState {
  TodayError(this.message);
  final String message;
}

// ── Cubit ──────────────────────────────────────────────────────────────────

class TodayCubit extends Cubit<TodayState> {
  TodayCubit() : super(TodayLoading()) {
    _load();
  }

  Future<void> _load() async {
    // TODO(phase-2) : remplacer par IsarRepository.watchTodayTasks()
    // Simulation synchrone pour la phase 1 (données en mémoire).
    await Future.delayed(const Duration(milliseconds: 120));

    emit(TodayLoaded(
      roles: _seedRoles,
      tasks: _seedTasks,
      selectedRoleId: null,
    ));
  }

  void filterByRole(String? roleId) {
    final current = state;
    if (current is! TodayLoaded) return;
    if (current.selectedRoleId == roleId) {
      // Double-tap : retire le filtre
      emit(current.copyWith(clearRoleFilter: true));
    } else {
      emit(current.copyWith(selectedRoleId: roleId));
    }
  }

  void toggleTask(String taskId) {
    final current = state;
    if (current is! TodayLoaded) return;

    final updated = current.tasks.map((t) {
      return t.id == taskId ? t.copyWith(isDone: !t.isDone) : t;
    }).toList();
    emit(current.copyWith(tasks: updated));
  }

  void addTask(String title, String roleId, {bool important = false, bool urgent = false}) {
    final current = state;
    if (current is! TodayLoaded) return;
    
    final newTask = DailyTask(
      id: 'task_${DateTime.now().millisecondsSinceEpoch}',
      title: title,
      roleId: roleId,
      isStrategic: important && !urgent,
    );
    emit(current.copyWith(tasks: [...current.tasks, newTask]));
  }

  void deleteTask(String taskId) {
    final current = state;
    if (current is! TodayLoaded) return;
    
    final updated = current.tasks.where((t) => t.id != taskId).toList();
    emit(current.copyWith(tasks: updated));
  }

  Future<void> refresh() => _load();
}

// ── Données de seed (phase 1) ──────────────────────────────────────────────

const _seedRoles = <LifeRole>[
  LifeRole(
    id: 'role_pro',
    name: 'Professionnel',
    colorToken: 'brass',
    weeklyBigRock: 'Terminer le rapport Q3',
    icon: '💼',
  ),
  LifeRole(
    id: 'role_famille',
    name: 'Famille',
    colorToken: 'clay',
    weeklyBigRock: 'Planifier le weekend avec les enfants',
    icon: '🏠',
  ),
  LifeRole(
    id: 'role_sante',
    name: 'Santé',
    colorToken: 'sage',
    weeklyBigRock: '3 séances de sport cette semaine',
    icon: '🌿',
  ),
  LifeRole(
    id: 'role_apprentissage',
    name: 'Apprentissage',
    colorToken: 'brass',
    weeklyBigRock: null,
    icon: '📚',
  ),
];

const _seedTasks = <DailyTask>[
  DailyTask(
    id: 't1',
    title: 'Rédiger l\'introduction du rapport',
    roleId: 'role_pro',
    isStrategic: true,
  ),
  DailyTask(
    id: 't2',
    title: 'Répondre aux emails urgents',
    roleId: 'role_pro',
    isStrategic: false,
  ),
  DailyTask(
    id: 't3',
    title: 'Appeler maman',
    roleId: 'role_famille',
    isStrategic: true,
  ),
  DailyTask(
    id: 't4',
    title: 'Course à pied 30min',
    roleId: 'role_sante',
    isStrategic: true,
  ),
  DailyTask(
    id: 't5',
    title: 'Lire 20 pages',
    roleId: 'role_apprentissage',
    isStrategic: true,
  ),
];
