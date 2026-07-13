import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/services/database_service.dart';
import '../../../core/models/app_settings_model.dart';
import '../../../core/di/injection.dart';

class SettingsState {
  final AppSettings? settings;
  const SettingsState({this.settings});

  SettingsState copyWith({AppSettings? settings}) {
    return SettingsState(settings: settings ?? this.settings);
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
        ..gentleRemindersEnabled = true
        ..aiSuggestionsEnabled = false;
      
      await _db.isar.writeTxn(() async {
        await _db.isar.appSettings.put(newSettings);
      });
      emit(state.copyWith(settings: newSettings));
    }
  }

  Future<void> updateNotifications(bool enabled) async {
    final current = state.settings;
    if (current == null) return;

    current.gentleRemindersEnabled = enabled;
    await _db.isar.writeTxn(() async {
      await _db.isar.appSettings.put(current);
    });
    emit(state.copyWith(settings: current));
  }

  Future<void> updateAiSuggestions(bool enabled) async {
    final current = state.settings;
    if (current == null) return;

    current.aiSuggestionsEnabled = enabled;
    await _db.isar.writeTxn(() async {
      await _db.isar.appSettings.put(current);
    });
    emit(state.copyWith(settings: current));
  }

  Future<void> updateAiProvider(String provider) async {
    final current = state.settings;
    if (current == null) return;

    current.aiProvider = provider;
    await _db.isar.writeTxn(() async {
      await _db.isar.appSettings.put(current);
    });
    emit(state.copyWith(settings: current));
  }

  Future<void> updateAiApiKey(String apiKey) async {
    final current = state.settings;
    if (current == null) return;

    current.aiApiKey = apiKey;
    await _db.isar.writeTxn(() async {
      await _db.isar.appSettings.put(current);
    });
    emit(state.copyWith(settings: current));
  }
}
