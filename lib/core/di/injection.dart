// GetIt service locator — injection de dépendances.
// Enregistre tous les singletons au démarrage.
// Règle : aucune clé API passée comme argument ici, le service la lit lui-même.
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import '../services/secure_storage_service.dart';
import '../services/database_service.dart';
import '../services/notification_service.dart';
import '../services/ai_service.dart';
import '../../domain/repositories/task_repository.dart';
import '../../data/repositories/task_repository_impl.dart';
import '../../domain/repositories/role_repository.dart';
import '../../data/repositories/role_repository_impl.dart';
import '../../domain/repositories/mission_repository.dart';
import '../../data/repositories/mission_repository_impl.dart';
import '../../domain/repositories/plan_repository.dart';
import '../../data/repositories/plan_repository_impl.dart';
import '../../domain/repositories/review_repository.dart';
import '../../data/repositories/review_repository_impl.dart';
import '../../domain/repositories/settings_repository.dart';
import '../../data/repositories/settings_repository_impl.dart';

import '../../domain/usecases/task_usecases.dart';
import '../../domain/usecases/role_usecases.dart';
import '../../domain/usecases/mission_usecases.dart';
import '../../domain/usecases/plan_usecases.dart';
import '../../domain/usecases/review_usecases.dart';
import '../../domain/usecases/settings_usecases.dart';

final getIt = GetIt.instance;

Future<void> setupDependencies() async {
  // Storage
  getIt.registerLazySingleton<FlutterSecureStorage>(
    () => const FlutterSecureStorage(),
  );

  getIt.registerLazySingleton<SecureStorageService>(
    () => SecureStorageService(getIt<FlutterSecureStorage>()),
  );

  // Database (Isar)
  final databaseService = DatabaseService();
  await databaseService.init();
  getIt.registerSingleton<DatabaseService>(databaseService);

  // Repositories
  getIt.registerLazySingleton<TaskRepository>(() => TaskRepositoryImpl(getIt()));
  getIt.registerLazySingleton<RoleRepository>(() => RoleRepositoryImpl(getIt()));
  getIt.registerLazySingleton<MissionRepository>(() => MissionRepositoryImpl(getIt()));
  getIt.registerLazySingleton<PlanRepository>(() => PlanRepositoryImpl(getIt()));
  getIt.registerLazySingleton<ReviewRepository>(() => ReviewRepositoryImpl(getIt()));
  getIt.registerLazySingleton<SettingsRepository>(() => SettingsRepositoryImpl(getIt()));

  // Notifications
  final notificationService = NotificationService();
  await notificationService.init();
  getIt.registerSingleton<NotificationService>(notificationService);

  // AI Service
  getIt.registerLazySingleton<AiService>(() => AiService());

  // UseCases
  // Task
  getIt.registerLazySingleton(() => GetAllTasksUseCase(getIt()));
  getIt.registerLazySingleton(() => GetTodayTasksUseCase(getIt()));
  getIt.registerLazySingleton(() => GetPendingTasksUseCase(getIt()));
  getIt.registerLazySingleton(() => ToggleTaskUseCase(getIt()));
  getIt.registerLazySingleton(() => AddTaskUseCase(getIt()));
  getIt.registerLazySingleton(() => UpdateTaskUseCase(getIt()));
  getIt.registerLazySingleton(() => DeleteTaskUseCase(getIt()));
  getIt.registerLazySingleton(() => WatchTasksUseCase(getIt()));
  
  // Role
  getIt.registerLazySingleton(() => GetAllRolesUseCase(getIt()));
  getIt.registerLazySingleton(() => AddRoleUseCase(getIt()));
  getIt.registerLazySingleton(() => UpdateRoleUseCase(getIt()));
  getIt.registerLazySingleton(() => DeleteRoleUseCase(getIt()));
  
  // Mission
  getIt.registerLazySingleton(() => GetMissionUseCase(getIt()));
  getIt.registerLazySingleton(() => SaveMissionUseCase(getIt()));
  
  // Plan
  getIt.registerLazySingleton(() => GetCurrentPlanUseCase(getIt()));
  getIt.registerLazySingleton(() => SavePlanUseCase(getIt()));
  
  // Review
  getIt.registerLazySingleton(() => GetAllReviewsUseCase(getIt()));
  getIt.registerLazySingleton(() => GetReviewByDateUseCase(getIt()));
  getIt.registerLazySingleton(() => SaveReviewUseCase(getIt()));
  
  // Settings
  getIt.registerLazySingleton(() => GetSettingsUseCase(getIt()));
  getIt.registerLazySingleton(() => SaveSettingsUseCase(getIt()));
}
