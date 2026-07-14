import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isar/isar.dart';
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
  final Isar isar;
  Timer? _debounceTimer;

  PlanCubit(this.isar) : super(const PlanState()) {
    _load();
  }

  Future<void> _load() async {
    emit(state.copyWith(isLoading: true));

    final roles = await isar.lifeRoles.where().findAll();
    
    // Find one strategic task (important && !urgent && !done) per role for the current week
    // We'll just fetch all not done tasks and pick the first strategic one per role.
    final tasks = await isar.tasks.where().filter().doneEqualTo(false).importantEqualTo(true).urgentEqualTo(false).findAll();
    
    final Map<int, Task> roleTasks = {};
    for (final task in tasks) {
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

    await isar.writeTxn(() async {
      if (textTrimmed.isEmpty) {
        if (existingTask != null) {
          await isar.tasks.delete(existingTask.id);
        }
      } else {
        if (existingTask != null) {
          existingTask.title = textTrimmed;
          await isar.tasks.put(existingTask);
        } else {
          final newTask = Task()
            ..title = textTrimmed
            ..roleId = roleId
            ..important = true
            ..urgent = false
            ..done = false
            ..weekStart = DateTime.now(); // or week start logic
          await isar.tasks.put(newTask);
        }
      }
    });

    await _load();
    WidgetService.updateAllWidgets();
  }

  @override
  Future<void> close() {
    _debounceTimer?.cancel();
    return super.close();
  }
}
