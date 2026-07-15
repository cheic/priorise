import '../../core/models/role_model.dart';
import '../../core/models/enums.dart';
import '../repositories/role_repository.dart';

class GetAllRolesUseCase {
  final RoleRepository repository;
  GetAllRolesUseCase(this.repository);
  Future<List<LifeRole>> call() => repository.getAllRoles();
}

class AddRoleUseCase {
  final RoleRepository repository;
  AddRoleUseCase(this.repository);
  Future<void> call(String name, RoleAccent accent, String iconKey) async {
    final role = LifeRole()
      ..name = name
      ..accent = accent
      ..iconKey = iconKey;
    await repository.saveRole(role);
  }
}

class UpdateRoleUseCase {
  final RoleRepository repository;
  UpdateRoleUseCase(this.repository);
  Future<void> call(int id, String name, RoleAccent accent, String iconKey) async {
    final role = LifeRole()
      ..id = id
      ..name = name
      ..accent = accent
      ..iconKey = iconKey;
    await repository.saveRole(role);
  }
}

class DeleteRoleUseCase {
  final RoleRepository repository;
  DeleteRoleUseCase(this.repository);
  Future<void> call(int id) => repository.deleteRole(id);
}
