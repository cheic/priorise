import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/role_usecases.dart';
import '../../../domain/usecases/task_usecases.dart';
import '../../../core/models/role_model.dart';
import '../../../core/models/task_model.dart';
import '../../../core/services/widget_service.dart';
import 'dart:async';

class PlanState {
  final List<LifeRole> roles;
  final Map<int, Task> roleTasks;
  final List<Task> punctualTasks;
  final bool isLoading;

  const PlanState({
    this.roles = const [],
    this.roleTasks = const {},
    this.punctualTasks = const [],
    this.isLoading = true,
  });

  PlanState copyWith({
    List<LifeRole>? roles,
    Map<int, Task>? roleTasks,
    List<Task>? punctualTasks,
    bool? isLoading,
  }) {
    return PlanState(
      roles: roles ?? this.roles,
      roleTasks: roleTasks ?? this.roleTasks,
      punctualTasks: punctualTasks ?? this.punctualTasks,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class PlanCubit extends Cubit<PlanState> {
  final GetAllRolesUseCase getAllRoles;
  final GetAllTasksUseCase getTasks;
  final AddTaskUseCase addTask;
  final UpdateTaskUseCase updateTask;
  final DeleteTaskUseCase deleteTaskUseCase;
  Timer? _debounceTimer;

  PlanCubit({
    required this.getAllRoles,
    required this.getTasks,
    required this.addTask,
    required this.updateTask,
    required DeleteTaskUseCase deleteTask,
  }) : deleteTaskUseCase = deleteTask, super(const PlanState());

  Future<void> loadPlan() async {
    emit(state.copyWith(isLoading: true));

    final roles = await getAllRoles();
    final tasks = await getTasks();
    
    final pendingTasks = tasks.where((t) => t.done == false).toList();
    
    final Map<int, Task> roleTasks = {};
    final List<Task> punctualTasks = [];

    for (final task in pendingTasks) {
      if (task.important == true && task.urgent == false && !roleTasks.containsKey(task.roleId)) {
        roleTasks[task.roleId] = task;
      } else {
        punctualTasks.add(task);
      }
    }

    emit(state.copyWith(
      roles: roles,
      roleTasks: roleTasks,
      punctualTasks: punctualTasks,
      isLoading: false,
    ));
  }

  void updateTaskForRole(int roleId, String text) {
    if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      await _saveTask(roleId, text);
    });
  }

  Future<void> _saveTask(int roleId, String text) async {
    final textTrimmed = text.trim();
    final existingTask = state.roleTasks[roleId];

    if (textTrimmed.isEmpty) {
      if (existingTask != null) {
        await deleteTaskUseCase(existingTask.id);
      }
    } else {
      if (existingTask != null) {
        await updateTask(existingTask.id, textTrimmed, existingTask.roleId, important: true, urgent: false);
      } else {
        await addTask(textTrimmed, roleId, important: true, urgent: false);
      }
    }

    await loadPlan();
    WidgetService.updateAllWidgets();
  }

  Future<void> addPunctualTask(String title, int roleId, {required bool important, required bool urgent}) async {
    await addTask(title, roleId, important: important, urgent: urgent);
    await loadPlan();
    WidgetService.updateAllWidgets();
  }

  Future<void> updatePunctualTask(int taskId, String title, int roleId, {required bool important, required bool urgent}) async {
    await updateTask(taskId, title, roleId, important: important, urgent: urgent);
    await loadPlan();
    WidgetService.updateAllWidgets();
  }

  Future<void> removeTask(int taskId) async {
    await deleteTaskUseCase(taskId);
    await loadPlan();
    WidgetService.updateAllWidgets();
  }

  @override
  Future<void> close() {
    _debounceTimer?.cancel();
    return super.close();
  }
}
