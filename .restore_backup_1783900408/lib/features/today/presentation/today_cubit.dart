// today_cubit.dart — état de l'écran Aujourd'hui.
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isar/isar.dart';
import '../../../core/services/database_service.dart';
import '../../../core/models/task_model.dart' as isar_models;
import '../../../core/models/role_model.dart' as isar_models;
import '../../../core/models/enums.dart';
import '../../../core/di/injection.dart';
import 'dart:async';

// ── Modèles légers pour la vue ──────

class LifeRole {
  const LifeRole({
    required this.id,
    required this.name,
    required this.colorToken,
    required this.accent,
    this.weeklyBigRock,
    this.icon,
  });

  final int id;
  final String name;
  final String colorToken;
  final RoleAccent accent;
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

  final int id;
  final String title;
  final int roleId;
  final bool isDone;
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
  final int? selectedRoleId;

  List<DailyTask> get visibleTasks => selectedRoleId == null
      ? tasks
      : tasks.where((t) => t.roleId == selectedRoleId).toList();

  int get doneCount => tasks.where((t) => t.isDone).length;
  int get totalCount => tasks.length;

  TodayLoaded copyWith({
    List<LifeRole>? roles,
    List<DailyTask>? tasks,
    int? selectedRoleId,
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
    _db = getIt<DatabaseService>();
    _load();
    _setupWatchers();
  }

  late final DatabaseService _db;
  StreamSubscription<void>? _tasksSub;
  StreamSubscription<void>? _rolesSub;

  void _setupWatchers() {
    final isar = _db.isar;
    _tasksSub = isar.tasks.watchLazy().listen((_) => _load());
    _rolesSub = isar.lifeRoles.watchLazy().listen((_) => _load());
  }

  @override
  Future<void> close() {
    _tasksSub?.cancel();
    _rolesSub?.cancel();
    return super.close();
  }

  Future<void> _load() async {
    final isar = _db.isar;
    
    // Seed roles if empty
    if (await isar.lifeRoles.count() == 0) {
      await isar.writeTxn(() async {
        await isar.lifeRoles.putAll([
          isar_models.LifeRole()..name = 'Professionnel'..iconKey = 'work'..accent = RoleAccent.brass,
          isar_models.LifeRole()..name = 'Famille'..iconKey = 'home'..accent = RoleAccent.clay,
          isar_models.LifeRole()..name = 'Santé'..iconKey = 'favorite'..accent = RoleAccent.sage,
          isar_models.LifeRole()..name = 'Apprentissage'..iconKey = 'book'..accent = RoleAccent.brass,
        ]);
      });
    }

    final dbRoles = await isar.lifeRoles.where().findAll();

    // Seed tasks if empty
    if (await isar.tasks.count() == 0 && dbRoles.isNotEmpty) {
      await isar.writeTxn(() async {
        final proId = dbRoles.firstWhere((r) => r.name == 'Professionnel', orElse: () => dbRoles.first).id;
        final familleId = dbRoles.firstWhere((r) => r.name == 'Famille', orElse: () => dbRoles.first).id;
        final santeId = dbRoles.firstWhere((r) => r.name == 'Santé', orElse: () => dbRoles.first).id;
        final appId = dbRoles.firstWhere((r) => r.name == 'Apprentissage', orElse: () => dbRoles.first).id;
        
        await isar.tasks.putAll([
          isar_models.Task()..title = 'Rédiger l\'introduction du rapport'..roleId = proId..important = true..urgent = false..weekStart = DateTime.now(),
          isar_models.Task()..title = 'Répondre aux emails urgents'..roleId = proId..important = false..urgent = true..weekStart = DateTime.now(),
          isar_models.Task()..title = 'Appeler maman'..roleId = familleId..important = true..urgent = false..weekStart = DateTime.now(),
          isar_models.Task()..title = 'Course à pied 30min'..roleId = santeId..important = true..urgent = false..weekStart = DateTime.now(),
          isar_models.Task()..title = 'Lire 20 pages'..roleId = appId..important = true..urgent = false..weekStart = DateTime.now(),
        ]);
      });
    }

    final dbTasks = await isar.tasks.where().findAll();

    final uiRoles = dbRoles.map((r) => LifeRole(
      id: r.id,
      name: r.name,
      colorToken: r.accent.name,
      accent: r.accent,
      weeklyBigRock: null, // Need WeeklyPlan for this later
      icon: r.iconKey,
    )).toList();

    final uiTasks = dbTasks.map((t) => DailyTask(
      id: t.id,
      title: t.title,
      roleId: t.roleId,
      isDone: t.done,
      isStrategic: t.important && !t.urgent,
    )).toList();

    emit(TodayLoaded(
      roles: uiRoles,
      tasks: uiTasks,
      selectedRoleId: null,
    ));
  }

  void filterByRole(int? roleId) {
    final current = state;
    if (current is! TodayLoaded) return;
    if (current.selectedRoleId == roleId) {
      emit(current.copyWith(clearRoleFilter: true));
    } else {
      emit(current.copyWith(selectedRoleId: roleId));
    }
  }

  Future<void> toggleTask(int taskId) async {
    final current = state;
    if (current is! TodayLoaded) return;

    final isar = _db.isar;
    await isar.writeTxn(() async {
      final task = await isar.tasks.get(taskId);
      if (task != null) {
        task.done = !task.done;
        task.doneAt = task.done ? DateTime.now() : null;
        await isar.tasks.put(task);
      }
    });

    await _load();
  }

  Future<void> addTask(String title, int roleId, {bool important = false, bool urgent = false}) async {
    final current = state;
    if (current is! TodayLoaded) return;

    final isar = _db.isar;
    await isar.writeTxn(() async {
      final task = isar_models.Task()
        ..title = title
        ..roleId = roleId
        ..important = important
        ..urgent = urgent
        ..done = false
        ..weekStart = DateTime.now();
      await isar.tasks.put(task);
    });

    await _load();
  }

  Future<void> refresh() => _load();

  Future<void> deleteTask(int taskId) async {
    final current = state;
    if (current is! TodayLoaded) return;

    final isar = _db.isar;
    await isar.writeTxn(() async {
      await isar.tasks.delete(taskId);
    });

    await _load();
  }
}
