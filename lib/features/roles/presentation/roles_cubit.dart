import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/role_usecases.dart';
import '../../../core/models/role_model.dart';
import '../../../core/models/enums.dart';

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
  final GetAllRolesUseCase getAllRoles;
  final AddRoleUseCase addRoleUseCase;
  final UpdateRoleUseCase updateRoleUseCase;
  final DeleteRoleUseCase deleteRoleUseCase;

  RolesCubit({
    required this.getAllRoles,
    required this.addRoleUseCase,
    required this.updateRoleUseCase,
    required this.deleteRoleUseCase,
  }) : super(const RolesState()) {
    loadRoles();
  }

  Future<void> loadRoles() async {
    emit(state.copyWith(isLoading: true));
    try {
      final roles = await getAllRoles();
      emit(state.copyWith(roles: roles, isLoading: false));
    } catch (e) {
      // Handle error if needed
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> addRole(String name, RoleAccent accent, String iconKey) async {
    await addRoleUseCase(name, accent, iconKey);
    loadRoles();
  }

  Future<void> updateRole(int id, String name, RoleAccent accent, String iconKey) async {
    await updateRoleUseCase(id, name, accent, iconKey);
    loadRoles();
  }

  Future<void> deleteRole(int id) async {
    await deleteRoleUseCase(id);
    loadRoles();
  }
}
