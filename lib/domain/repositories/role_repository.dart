import '../../../core/models/role_model.dart';

abstract class RoleRepository {
  Future<List<LifeRole>> getAllRoles();
  Future<void> saveRole(LifeRole role);
  Future<void> deleteRole(int id);
  Stream<void> watchRoles();
}
