import os

# Create directories
dirs = [
    'lib/domain/repositories',
    'lib/domain/usecases',
    'lib/data/repositories',
]
for d in dirs:
    os.makedirs(d, exist_ok=True)

# 1. TASK REPOSITORY
with open('lib/domain/repositories/task_repository.dart', 'w') as f:
    f.write('''import '../../../core/models/task_model.dart';

abstract class TaskRepository {
  Future<List<Task>> getAllTasks();
  Future<List<Task>> getTasksForDate(DateTime startOfDay, DateTime endOfDay);
  Future<List<Task>> getPendingTasks();
  Future<Task?> getTaskById(int id);
  Future<void> saveTask(Task task);
  Future<void> deleteTask(int id);
  Stream<void> watchTasks();
}
''')

with open('lib/data/repositories/task_repository_impl.dart', 'w') as f:
    f.write('''import 'package:isar/isar.dart';
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
''')

# 2. ROLE REPOSITORY
with open('lib/domain/repositories/role_repository.dart', 'w') as f:
    f.write('''import '../../../core/models/role_model.dart';

abstract class RoleRepository {
  Future<List<LifeRole>> getAllRoles();
  Future<void> saveRole(LifeRole role);
  Future<void> deleteRole(int id);
  Stream<void> watchRoles();
}
''')

with open('lib/data/repositories/role_repository_impl.dart', 'w') as f:
    f.write('''import 'package:isar/isar.dart';
import '../../core/models/role_model.dart';
import '../../core/services/database_service.dart';
import '../../domain/repositories/role_repository.dart';

class RoleRepositoryImpl implements RoleRepository {
  final DatabaseService _db;
  RoleRepositoryImpl(this._db);

  @override
  Future<List<LifeRole>> getAllRoles() => _db.isar.lifeRoles.where().findAll();

  @override
  Future<void> saveRole(LifeRole role) async {
    await _db.isar.writeTxn(() async {
      await _db.isar.lifeRoles.put(role);
    });
  }

  @override
  Future<void> deleteRole(int id) async {
    await _db.isar.writeTxn(() async {
      await _db.isar.lifeRoles.delete(id);
    });
  }

  @override
  Stream<void> watchRoles() => _db.isar.lifeRoles.watchLazy();
}
''')

