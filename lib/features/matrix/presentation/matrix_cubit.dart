import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isar/isar.dart';
import '../../../core/models/task_model.dart';

class MatrixState {
  final List<Task> q1Tasks; // Urgent & Important
  final List<Task> q2Tasks; // Important, Not Urgent
  final List<Task> q3Tasks; // Urgent, Not Important
  final List<Task> q4Tasks; // Not Urgent, Not Important
  final bool isLoading;

  const MatrixState({
    this.q1Tasks = const [],
    this.q2Tasks = const [],
    this.q3Tasks = const [],
    this.q4Tasks = const [],
    this.isLoading = true,
  });

  MatrixState copyWith({
    List<Task>? q1Tasks,
    List<Task>? q2Tasks,
    List<Task>? q3Tasks,
    List<Task>? q4Tasks,
    bool? isLoading,
  }) {
    return MatrixState(
      q1Tasks: q1Tasks ?? this.q1Tasks,
      q2Tasks: q2Tasks ?? this.q2Tasks,
      q3Tasks: q3Tasks ?? this.q3Tasks,
      q4Tasks: q4Tasks ?? this.q4Tasks,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class MatrixCubit extends Cubit<MatrixState> {
  final Isar isar;

  MatrixCubit(this.isar) : super(const MatrixState()) {
    loadTasks();
  }

  Future<void> loadTasks() async {
    emit(state.copyWith(isLoading: true));
    
    // We only want active (not done) tasks, maybe for the current week?
    // Let's just fetch all not done tasks.
    final tasks = await isar.tasks.where().filter().doneEqualTo(false).findAll();

    final q1 = <Task>[];
    final q2 = <Task>[];
    final q3 = <Task>[];
    final q4 = <Task>[];

    for (final t in tasks) {
      if (t.important && t.urgent) {
        q1.add(t);
      } else if (t.important && !t.urgent) {
        q2.add(t);
      } else if (!t.important && t.urgent) {
        q3.add(t);
      } else {
        q4.add(t);
      }
    }

    emit(state.copyWith(
      q1Tasks: q1,
      q2Tasks: q2,
      q3Tasks: q3,
      q4Tasks: q4,
      isLoading: false,
    ));
  }
}
