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
  Future<List<Task>> getTasksForDate(DateTime startOfDay, DateTime endOfDay) {
    return _db.isar.tasks.where()
      .filter()
      .doneEqualTo(false)
      .or()
      .doneAtBetween(startOfDay, endOfDay)
      .findAll();
  }

  @override
  Future<List<Task>> getPendingTasks() {
    return _db.isar.tasks.filter().doneEqualTo(false).findAll();
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
