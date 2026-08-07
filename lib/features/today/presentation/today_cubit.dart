import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/models/role_model.dart';
import '../../../core/models/task_model.dart';
import '../../../core/models/weekly_plan_model.dart';
import '../../../domain/usecases/task_usecases.dart';
import '../../../core/services/widget_service.dart';
import '../../../domain/usecases/role_usecases.dart';
import '../../../domain/usecases/plan_usecases.dart';
import '../../../core/di/injection.dart';
import '../../../core/services/secure_storage_service.dart';

// ── State ──────────────────────────────────────────────────────────────────

sealed class TodayState {}

class TodayLoading extends TodayState {}

class TodayLoaded extends TodayState {
  TodayLoaded({
    required this.roles,
    required this.tasks,
    required this.selectedRoleId,
    required this.currentPlan,
    this.shouldGreet = false,
    this.isEvening = false,
  });

  final List<LifeRole> roles;
  final List<Task> tasks;
  final int? selectedRoleId;
  final WeeklyPlan? currentPlan;
  final bool shouldGreet;
  final bool isEvening;

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
    bool? shouldGreet,
    bool? isEvening,
    bool clearRoleFilter = false,
  }) =>
      TodayLoaded(
        roles: roles ?? this.roles,
        tasks: tasks ?? this.tasks,
        selectedRoleId: clearRoleFilter ? null : (selectedRoleId ?? this.selectedRoleId),
        currentPlan: currentPlan ?? this.currentPlan,
        shouldGreet: shouldGreet ?? this.shouldGreet,
        isEvening: isEvening ?? this.isEvening,
      );
}

class TodayError extends TodayState {
  TodayError(this.message);
  final String message;
}

// ── Cubit ──────────────────────────────────────────────────────────────────

class TodayCubit extends Cubit<TodayState> {
  TodayCubit({
    required this.getTodayTasks,
    required this.getAllRoles,
    required this.getCurrentPlan,
    required this.toggleTaskUseCase,
    required this.addTaskUseCase,
    required this.updateTaskUseCase,
    required this.deleteTaskUseCase,
    required this.postponeTaskUseCase,
    required this.watchTasksUseCase,
  }) : super(TodayLoading()) {
    _load();
    _subscription = watchTasksUseCase().listen((_) => _load());
  }

  final GetTodayTasksUseCase getTodayTasks;
  final GetAllRolesUseCase getAllRoles;
  final GetCurrentPlanUseCase getCurrentPlan;
  final ToggleTaskUseCase toggleTaskUseCase;
  final AddTaskUseCase addTaskUseCase;
  final UpdateTaskUseCase updateTaskUseCase;
  final DeleteTaskUseCase deleteTaskUseCase;
  final PostponeTaskUseCase postponeTaskUseCase;
  final WatchTasksUseCase watchTasksUseCase;

  StreamSubscription<void>? _subscription;

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }

  Future<void> _load() async {
    try {
      final roles = await getAllRoles();
      final tasks = await getTodayTasks();
      final currentPlan = await getCurrentPlan();

      int? currentSelectedRoleId;
      bool currentShouldGreet = false;
      bool currentIsEvening = false;
      
      if (state is TodayLoaded) {
        final loaded = state as TodayLoaded;
        currentSelectedRoleId = loaded.selectedRoleId;
        currentShouldGreet = loaded.shouldGreet;
        currentIsEvening = loaded.isEvening;
      } else {
        // First load of the session
        final now = DateTime.now();
        currentIsEvening = now.hour >= 17;
        final period = currentIsEvening ? 'evening' : 'morning';
        final currentGreetingKey = '${now.year}-${now.month}-${now.day}-$period';
        
        final storage = getIt<SecureStorageService>();
        final lastGreetingKey = await storage.readLastGreetingTime();
        
        if (lastGreetingKey != currentGreetingKey) {
          currentShouldGreet = true;
          await storage.saveLastGreetingTime(currentGreetingKey);
        }
      }

      emit(TodayLoaded(
        roles: roles,
        tasks: tasks,
        selectedRoleId: currentSelectedRoleId,
        currentPlan: currentPlan,
        shouldGreet: currentShouldGreet,
        isEvening: currentIsEvening,
      ));
    } catch (e) {
      emit(TodayError("Erreur lors du chargement : $e"));
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
    await toggleTaskUseCase(taskId);
    WidgetService.updateAllWidgets().catchError((_) {});
    _load();
  }

  Future<void> addTask(String title, int roleId, {bool important = false, bool urgent = false}) async {
    await addTaskUseCase(title, roleId, important: important, urgent: urgent);
    WidgetService.updateAllWidgets().catchError((_) {});
    _load();
  }

  Future<void> updateTask(int taskId, String title, int roleId, {bool important = false, bool urgent = false}) async {
    await updateTaskUseCase(taskId, title, roleId, important: important, urgent: urgent);
    WidgetService.updateAllWidgets().catchError((_) {});
    _load();
  }

  Future<void> deleteTask(int taskId) async {
    final current = state;
    if (current is TodayLoaded) {
      emit(current.copyWith(tasks: current.tasks.where((t) => t.id != taskId).toList()));
    }
    await deleteTaskUseCase(taskId);
    WidgetService.updateAllWidgets().catchError((_) {});
    _load();
  }

  Future<void> postponeTask(int taskId) async {
    final current = state;
    if (current is TodayLoaded) {
      emit(current.copyWith(tasks: current.tasks.where((t) => t.id != taskId).toList()));
    }
    await postponeTaskUseCase(taskId);
    WidgetService.updateAllWidgets().catchError((_) {});
    _load();
  }

  Future<void> refresh() => _load();
}
