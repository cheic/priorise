import 'package:isar/isar.dart';
import '../../core/models/app_settings_model.dart';
import '../../core/services/database_service.dart';
import '../../domain/repositories/settings_repository.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final DatabaseService _db;
  SettingsRepositoryImpl(this._db);

  @override
  Future<AppSettings> getSettings() async {
    final settings = await _db.isar.appSettings.where().findFirst();
    if (settings != null) return settings;
    
    final newSettings = AppSettings();
    await _db.isar.writeTxn(() async {
      await _db.isar.appSettings.put(newSettings);
    });
    return newSettings;
  }

  @override
  Future<void> saveSettings(AppSettings settings) async {
    await _db.isar.writeTxn(() async {
      await _db.isar.appSettings.put(settings);
    });
  }

  @override
  Stream<void> watchSettings() => _db.isar.appSettings.watchLazy();
}
