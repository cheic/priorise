import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isar/isar.dart';
import '../../../core/models/role_model.dart';
import '../../../core/models/enums.dart';
import '../../../core/services/widget_service.dart';

class RolesState {
  final List<LifeRole> roles;
  final bool isLoading;

  const RolesState({
    this.roles = const [],
    this.isLoading = true,
  });

  RolesState copyWith({
    List<LifeRole>? roles,
    bool? isLoading,
  }) {
    return RolesState(
      roles: roles ?? this.roles,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class RolesCubit extends Cubit<RolesState> {
  final Isar isar;

  RolesCubit(this.isar) : super(const RolesState()) {
    loadRoles();
  }

  Future<void> loadRoles() async {
    emit(state.copyWith(isLoading: true));
    final roles = await isar.lifeRoles.where().findAll();
    emit(state.copyWith(roles: roles, isLoading: false));
  }

  Future<void> addRole(String name, RoleAccent accent, String iconKey) async {
    final role = LifeRole()
      ..name = name
      ..iconKey = iconKey
      ..accent = accent;

    await isar.writeTxn(() async {
      await isar.lifeRoles.put(role);
    });
    
    await loadRoles();
    WidgetService.updateAllWidgets();
  }

  Future<void> updateRole(int id, String name, RoleAccent accent, String iconKey) async {
    final role = await isar.lifeRoles.get(id);
    if (role != null) {
      role
        ..name = name
        ..iconKey = iconKey
        ..accent = accent;

      await isar.writeTxn(() async {
        await isar.lifeRoles.put(role);
      });
      
      await loadRoles();
      WidgetService.updateAllWidgets();
    }
  }

  Future<void> deleteRole(int id) async {
    await isar.writeTxn(() async {
      await isar.lifeRoles.delete(id);
    });
    await loadRoles();
    WidgetService.updateAllWidgets();
  }
}
