import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isar/isar.dart';
import '../../../core/models/task_model.dart';

class MatrixState {
  final List<Task> urgentImportantTasks; // Urgent & Important
  final List<Task> strategicTasks; // Important, Not Urgent
  final List<Task> distractionTasks; // Urgent, Not Important
  final List<Task> uselessTasks; // Not Urgent, Not Important
  final bool isLoading;

  const MatrixState({
    this.urgentImportantTasks = const [],
    this.strategicTasks = const [],
    this.distractionTasks = const [],
    this.uselessTasks = const [],
    this.isLoading = true,
  });

  MatrixState copyWith({
    List<Task>? urgentImportantTasks,
    List<Task>? strategicTasks,
    List<Task>? distractionTasks,
    List<Task>? uselessTasks,
    bool? isLoading,
  }) {
    return MatrixState(
      urgentImportantTasks: urgentImportantTasks ?? this.urgentImportantTasks,
      strategicTasks: strategicTasks ?? this.strategicTasks,
      distractionTasks: distractionTasks ?? this.distractionTasks,
      uselessTasks: uselessTasks ?? this.uselessTasks,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class MatrixCubit extends Cubit<MatrixState> {
  final Isar isar;
  StreamSubscription<void>? _tasksSubscription;

  MatrixCubit(this.isar) : super(const MatrixState()) {
    loadTasks();
    _startWatchingTasks();
  }

  void _startWatchingTasks() {
    _tasksSubscription = isar.tasks.watchLazy().listen((_) {
      loadTasks();
    });
  }

  @override
  Future<void> close() {
    _tasksSubscription?.cancel();
    return super.close();
  }

  Future<void> loadTasks() async {
    emit(state.copyWith(isLoading: true));
    
    // We only want active (not done) tasks, maybe for the current week?
    // Let's just fetch all not done tasks.
    final tasks = await isar.tasks.where().filter().doneEqualTo(false).findAll();

    final urgentImportant = <Task>[];
    final strategic = <Task>[];
    final distraction = <Task>[];
    final useless = <Task>[];

    for (final t in tasks) {
      if (t.important && t.urgent) {
        urgentImportant.add(t);
      } else if (t.important && !t.urgent) {
        strategic.add(t);
      } else if (!t.important && t.urgent) {
        distraction.add(t);
      } else {
        useless.add(t);
      }
    }

    emit(state.copyWith(
      urgentImportantTasks: urgentImportant,
      strategicTasks: strategic,
      distractionTasks: distraction,
      uselessTasks: useless,
      isLoading: false,
    ));
  }
}
