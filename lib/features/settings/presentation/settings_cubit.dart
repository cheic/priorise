import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/models/app_settings_model.dart';
import '../../../core/di/injection.dart';
import '../../../core/services/ai_service.dart';
import '../../../domain/usecases/settings_usecases.dart';

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
  final GetSettingsUseCase getSettingsUseCase;
  final SaveSettingsUseCase saveSettingsUseCase;

  SettingsCubit({
    required this.getSettingsUseCase,
    required this.saveSettingsUseCase,
  }) : super(const SettingsState()) {
    _initSettings();
  }

  Future<void> _initSettings() async {
    final settings = await getSettingsUseCase();
    emit(state.copyWith(settings: settings));
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
    await saveSettingsUseCase(newSettings);
    emit(state.copyWith(settings: newSettings));
  }

  Future<void> updateAiSuggestions(bool enabled) async {
    final current = state.settings;
    if (current == null) return;

    final newSettings = _cloneSettings(current)..aiSuggestionsEnabled = enabled;
    await saveSettingsUseCase(newSettings);
    emit(state.copyWith(settings: newSettings));
  }

  Future<void> updateAiProvider(String provider) async {
    final current = state.settings;
    if (current == null) return;
    if (current.aiProvider == provider) return;

    final newSettings = _cloneSettings(current)
      ..aiProvider = provider
      ..aiApiKey = '';
    await saveSettingsUseCase(newSettings);
    emit(state.copyWith(settings: newSettings));
  }

  Future<void> updateAiApiKey(String apiKey) async {
    final current = state.settings;
    if (current == null) return;

    final newSettings = _cloneSettings(current)..aiApiKey = apiKey;
    await saveSettingsUseCase(newSettings);
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
