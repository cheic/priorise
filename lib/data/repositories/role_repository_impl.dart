import 'package:isar/isar.dart';
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
