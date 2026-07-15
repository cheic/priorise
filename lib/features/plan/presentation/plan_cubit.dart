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
  final bool isLoading;

  const PlanState({
    this.roles = const [],
    this.roleTasks = const {},
    this.isLoading = true,
  });

  PlanState copyWith({
    List<LifeRole>? roles,
    Map<int, Task>? roleTasks,
    bool? isLoading,
  }) {
    return PlanState(
      roles: roles ?? this.roles,
      roleTasks: roleTasks ?? this.roleTasks,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class PlanCubit extends Cubit<PlanState> {
  final GetAllRolesUseCase getAllRoles;
  final GetAllTasksUseCase getTasks;
  final AddTaskUseCase addTask;
  final UpdateTaskUseCase updateTask;
  final DeleteTaskUseCase deleteTask;
  Timer? _debounceTimer;

  PlanCubit({
    required this.getAllRoles,
    required this.getTasks,
    required this.addTask,
    required this.updateTask,
    required this.deleteTask,
  }) : super(const PlanState());

  Future<void> loadPlan() async {
    emit(state.copyWith(isLoading: true));

    final roles = await getAllRoles();
    final tasks = await getTasks();
    final strategicTasks = tasks.where((t) => t.important == true && t.urgent == false && t.done == false);
    
    final Map<int, Task> roleTasks = {};
    for (final task in strategicTasks) {
      if (!roleTasks.containsKey(task.roleId)) {
        roleTasks[task.roleId] = task;
      }
    }

    emit(state.copyWith(
      roles: roles,
      roleTasks: roleTasks,
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
        await deleteTask(existingTask.id);
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

  @override
  Future<void> close() {
    _debounceTimer?.cancel();
    return super.close();
  }
}
