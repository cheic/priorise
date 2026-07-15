import '../../core/models/task_model.dart';
import '../repositories/task_repository.dart';

class GetAllTasksUseCase {
  final TaskRepository repository;
  GetAllTasksUseCase(this.repository);
  Future<List<Task>> call() => repository.getAllTasks();
}

class GetTodayTasksUseCase {
  final TaskRepository repository;
  GetTodayTasksUseCase(this.repository);
  Future<List<Task>> call() {
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day);
    final endOfDay = DateTime(now.year, now.month, now.day, 23, 59, 59);
    return repository.getTasksForDate(startOfDay, endOfDay);
  }
}

class GetPendingTasksUseCase {
  final TaskRepository repository;
  GetPendingTasksUseCase(this.repository);
  Future<List<Task>> call() => repository.getPendingTasks();
}

class ToggleTaskUseCase {
  final TaskRepository repository;
  ToggleTaskUseCase(this.repository);
  Future<void> call(int taskId) async {
    final task = await repository.getTaskById(taskId);
    if (task == null) return;
    task.done = !task.done;
    task.doneAt = task.done ? DateTime.now() : null;
    await repository.saveTask(task);
  }
}

class AddTaskUseCase {
  final TaskRepository repository;
  AddTaskUseCase(this.repository);
  Future<void> call(String title, int roleId, {bool important = false, bool urgent = false}) async {
    final task = Task()
      ..title = title
      ..roleId = roleId
      ..important = important
      ..urgent = urgent
      ..weekStart = DateTime.now();
    await repository.saveTask(task);
  }
}

class UpdateTaskUseCase {
  final TaskRepository repository;
  UpdateTaskUseCase(this.repository);
  Future<void> call(int taskId, String title, int roleId, {bool important = false, bool urgent = false}) async {
    final task = await repository.getTaskById(taskId);
    if (task == null) return;
    task.title = title;
    task.roleId = roleId;
    task.important = important;
    task.urgent = urgent;
    await repository.saveTask(task);
  }
}

class DeleteTaskUseCase {
  final TaskRepository repository;
  DeleteTaskUseCase(this.repository);
  Future<void> call(int taskId) => repository.deleteTask(taskId);
}

class WatchTasksUseCase {
  final TaskRepository repository;
  WatchTasksUseCase(this.repository);
  Stream<void> call() => repository.watchTasks();
}
