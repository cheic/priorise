import 'package:isar/isar.dart';
import '../../core/models/task_model.dart';
import '../../core/services/database_service.dart';
import '../../domain/repositories/task_repository.dart';

class TaskRepositoryImpl implements TaskRepository {
  final DatabaseService _db;
  TaskRepositoryImpl(this._db);

  @override
  Future<List<Task>> getAllTasks() => _db.isar.tasks.where().findAll();

  @override
  Future<List<Task>> getTasksForDate(DateTime startOfDay, DateTime endOfDay) async {
    final now = DateTime.now();
    final monday = DateTime(now.year, now.month, now.day).subtract(Duration(days: now.weekday - 1));
    final endOfWeek = monday.add(const Duration(days: 6, hours: 23, minutes: 59, seconds: 59));

    final tasks = await _db.isar.tasks.where()
      .filter()
      .doneEqualTo(false)
      .or()
      .doneAtBetween(startOfDay, endOfDay)
      .findAll();

    return tasks.where((t) => t.weekStart.isBefore(endOfWeek) || t.weekStart.isAtSameMomentAs(endOfWeek)).toList();
  }

  @override
  Future<List<Task>> getPendingTasks() async {
    final now = DateTime.now();
    final monday = DateTime(now.year, now.month, now.day).subtract(Duration(days: now.weekday - 1));
    final endOfWeek = monday.add(const Duration(days: 6, hours: 23, minutes: 59, seconds: 59));

    final tasks = await _db.isar.tasks.filter().doneEqualTo(false).findAll();
    return tasks.where((t) => t.weekStart.isBefore(endOfWeek) || t.weekStart.isAtSameMomentAs(endOfWeek)).toList();
  }

  @override
  Future<Task?> getTaskById(int id) => _db.isar.tasks.get(id);

  @override
  Future<void> saveTask(Task task) async {
    await _db.isar.writeTxn(() async {
      await _db.isar.tasks.put(task);
    });
  }

  @override
  Future<void> deleteTask(int id) async {
    await _db.isar.writeTxn(() async {
      await _db.isar.tasks.delete(id);
    });
  }

  @override
  Stream<void> watchTasks() => _db.isar.tasks.watchLazy();
}
