import '../../core/models/app_settings_model.dart';
import '../repositories/settings_repository.dart';

class GetSettingsUseCase {
  final SettingsRepository repository;
  GetSettingsUseCase(this.repository);
  Future<AppSettings> call() => repository.getSettings();
}

class SaveSettingsUseCase {
  final SettingsRepository repository;
  SaveSettingsUseCase(this.repository);
  Future<void> call(AppSettings settings) => repository.saveSettings(settings);
}
