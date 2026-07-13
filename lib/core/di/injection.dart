// GetIt service locator — injection de dépendances.
// Enregistre tous les singletons au démarrage.
// Règle : aucune clé API passée comme argument ici, le service la lit lui-même.
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import '../services/secure_storage_service.dart';
import '../services/database_service.dart';
import '../services/notification_service.dart';

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

  // Notifications
  final notificationService = NotificationService();
  await notificationService.init();
  getIt.registerSingleton<NotificationService>(notificationService);
}
