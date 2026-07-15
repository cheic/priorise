import '../../../core/models/task_model.dart';

abstract class TaskRepository {
  Future<List<Task>> getAllTasks();
  Future<List<Task>> getTasksForDate(DateTime startOfDay, DateTime endOfDay);
  Future<List<Task>> getPendingTasks();
  Future<Task?> getTaskById(int id);
  Future<void> saveTask(Task task);
  Future<void> deleteTask(int id);
  Stream<void> watchTasks();
}
