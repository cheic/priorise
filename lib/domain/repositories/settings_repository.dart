import '../../../core/models/app_settings_model.dart';

abstract class SettingsRepository {
  Future<AppSettings> getSettings();
  Future<void> saveSettings(AppSettings settings);
  Stream<void> watchSettings();
}
