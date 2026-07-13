import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isar/isar.dart';
import '../../../core/models/role_model.dart';
import '../../../core/models/task_model.dart';
import '../../../core/models/weekly_plan_model.dart';

// ── State ──────────────────────────────────────────────────────────────────

sealed class TodayState {}

class TodayLoading extends TodayState {}

class TodayLoaded extends TodayState {
  TodayLoaded({
    required this.roles,
    required this.tasks,
    required this.selectedRoleId,
    required this.currentPlan,
  });

  final List<LifeRole> roles;
  final List<Task> tasks;
  final int? selectedRoleId;
  final WeeklyPlan? currentPlan;

  List<Task> get visibleTasks => selectedRoleId == null
      ? tasks
      : tasks.where((t) => t.roleId == selectedRoleId).toList();

  int get doneCount => tasks.where((t) => t.done).length;
  int get totalCount => tasks.length;

  TodayLoaded copyWith({
    List<LifeRole>? roles,
    List<Task>? tasks,
    int? selectedRoleId,
    WeeklyPlan? currentPlan,
    bool clearRoleFilter = false,
  }) =>
      TodayLoaded(
        roles: roles ?? this.roles,
        tasks: tasks ?? this.tasks,
        selectedRoleId: clearRoleFilter ? null : (selectedRoleId ?? this.selectedRoleId),
        currentPlan: currentPlan ?? this.currentPlan,
      );
}

class TodayError extends TodayState {
  TodayError(this.message);
  final String message;
}

// ── Cubit ──────────────────────────────────────────────────────────────────

class TodayCubit extends Cubit<TodayState> {
  TodayCubit(this.isar) : super(TodayLoading()) {
    _load();
  }

  final Isar isar;

  Future<void> _load() async {
    try {
      final now = DateTime.now();
      
      // We consider tasks that are undone OR done today.
      final startOfDay = DateTime(now.year, now.month, now.day);
      final endOfDay = DateTime(now.year, now.month, now.day, 23, 59, 59);

      final roles = await isar.lifeRoles.where().findAll();
      
      // All undone tasks or tasks done today.
      final tasks = await isar.tasks.where()
          .filter()
          .doneEqualTo(false)
          .or()
          .doneAtBetween(startOfDay, endOfDay)
          .findAll();
          
      // Find current weekly plan to get big rocks.
      final currentPlan = await isar.weeklyPlans.where().sortByWeekStartDesc().findFirst();

      emit(TodayLoaded(
        roles: roles,
        tasks: tasks,
        selectedRoleId: null,
        currentPlan: currentPlan,
      ));
    } catch (e) {
      emit(TodayError("Erreur lors du chargement des tâches : $e"));
    }
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

    final task = await isar.tasks.get(taskId);
    if (task == null) return;

    task.done = !task.done;
    if (task.done) {
      task.doneAt = DateTime.now();
    } else {
      task.doneAt = null;
    }

    await isar.writeTxn(() async {
      await isar.tasks.put(task);
    });

    _load();
  }

  Future<void> addTask(String title, int roleId, {bool important = false, bool urgent = false}) async {
    final current = state;
    if (current is! TodayLoaded) return;
    
    final newTask = Task()
      ..title = title
      ..roleId = roleId
      ..important = important
      ..urgent = urgent
      ..weekStart = DateTime.now();

    await isar.writeTxn(() async {
      await isar.tasks.put(newTask);
    });

    _load();
  }

  Future<void> deleteTask(int taskId) async {
    final current = state;
    if (current is! TodayLoaded) return;
    
    await isar.writeTxn(() async {
      await isar.tasks.delete(taskId);
    });

    _load();
  }

  Future<void> refresh() => _load();
}
