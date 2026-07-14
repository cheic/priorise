import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/services/database_service.dart';
import '../../../core/models/app_settings_model.dart';
import '../../../core/di/injection.dart';
import '../../../core/services/ai_service.dart';

class SettingsState {
  final AppSettings? settings;
  final bool isTestingConnection;

  const SettingsState({this.settings, this.isTestingConnection = false});

  SettingsState copyWith({AppSettings? settings, bool? isTestingConnection}) {
    return SettingsState(
      settings: settings ?? this.settings,
      isTestingConnection: isTestingConnection ?? this.isTestingConnection,
    );
  }
}

class SettingsCubit extends Cubit<SettingsState> {
  final DatabaseService _db;

  SettingsCubit() : _db = getIt<DatabaseService>(), super(const SettingsState()) {
    _initSettings();
  }

  Future<void> _initSettings() async {
    final settings = await _db.isar.appSettings.get(AppSettings.singletonId);
    if (settings != null) {
      emit(state.copyWith(settings: settings));
    } else {
      final newSettings = AppSettings()
        ..id = AppSettings.singletonId
        ..gentleRemindersEnabled = false
        ..aiSuggestionsEnabled = false;
      
      await _db.isar.writeTxn(() async {
        await _db.isar.appSettings.put(newSettings);
      });
      emit(state.copyWith(settings: newSettings));
    }
  }

  AppSettings _cloneSettings(AppSettings current) {
    return AppSettings()
      ..id = current.id
      ..themeMode = current.themeMode
      ..locale = current.locale
      ..gentleRemindersEnabled = current.gentleRemindersEnabled
      ..aiSuggestionsEnabled = current.aiSuggestionsEnabled
      ..aiProvider = current.aiProvider
      ..aiApiKey = current.aiApiKey
      ..firstLaunchCompleted = current.firstLaunchCompleted;
  }

  Future<void> updateNotifications(bool enabled) async {
    final current = state.settings;
    if (current == null) return;

    final newSettings = _cloneSettings(current)..gentleRemindersEnabled = enabled;
    await _db.isar.writeTxn(() async {
      await _db.isar.appSettings.put(newSettings);
    });
    emit(state.copyWith(settings: newSettings));
  }

  Future<void> updateAiSuggestions(bool enabled) async {
    final current = state.settings;
    if (current == null) return;

    final newSettings = _cloneSettings(current)..aiSuggestionsEnabled = enabled;
    await _db.isar.writeTxn(() async {
      await _db.isar.appSettings.put(newSettings);
    });
    emit(state.copyWith(settings: newSettings));
  }

  Future<void> updateAiProvider(String provider) async {
    final current = state.settings;
    if (current == null) return;

    final newSettings = _cloneSettings(current)..aiProvider = provider;
    await _db.isar.writeTxn(() async {
      await _db.isar.appSettings.put(newSettings);
    });
    emit(state.copyWith(settings: newSettings));
  }

  Future<void> updateAiApiKey(String apiKey) async {
    final current = state.settings;
    if (current == null) return;

    final newSettings = _cloneSettings(current)..aiApiKey = apiKey;
    await _db.isar.writeTxn(() async {
      await _db.isar.appSettings.put(newSettings);
    });
    emit(state.copyWith(settings: newSettings));
  }

  Future<bool> testAiConnection() async {
    final current = state.settings;
    if (current == null) return false;

    emit(state.copyWith(isTestingConnection: true));
    try {
      final aiService = getIt<AiService>();
      final success = await aiService.testConnection(
        provider: current.aiProvider,
        apiKey: current.aiApiKey,
      );
      return success;
    } catch (e) {
      return false;
    } finally {
      emit(state.copyWith(isTestingConnection: false));
    }
  }
}
