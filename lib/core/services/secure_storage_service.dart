// Service de stockage sécurisé — clés API exclusivement via flutter_secure_storage.
// Préférences légères (firstLaunch, thème) via flutter_secure_storage également
// pour centraliser en un seul endroit sans dépendance supplémentaire.
// Règle : jamais de clé API dans les logs, jamais de print() sur les secrets.
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract final class StorageKeys {
  static const firstLaunch = 'first_launch';
  // Clés API — ne jamais lire en clair dans les logs
  static const aiApiKey = 'ai_api_key';
  static const themeMode = 'theme_mode';
  static const missionRevisionInterval = 'mission_revision_interval';
  static const lastGreetingTime = 'last_greeting_time';
}

class SecureStorageService {
  SecureStorageService(this._storage);

  final FlutterSecureStorage _storage;

  static const _androidOptions = AndroidOptions();

  Future<bool> isFirstLaunch() async {
    try {
      final raw = await _storage.read(
        key: StorageKeys.firstLaunch,
        aOptions: _androidOptions,
      );
      // Null → jamais écrit → premier lancement
      return raw == null || raw == 'true';
    } catch (e) {
      // En cas de corruption KeyStore ou exception Android/iOS, réinitialisation de secours
      // pour empêcher un crash fatal au démarrage (boucle de crash).
      try {
        await _storage.deleteAll(aOptions: _androidOptions);
      } catch (_) {}
      return true;
    }
  }

  Future<void> setFirstLaunchDone() async {
    try {
      await _storage.write(
        key: StorageKeys.firstLaunch,
        value: 'false',
        aOptions: _androidOptions,
      );
    } catch (_) {}
  }

  /// Stockage d'une clé API — ne retourne jamais la valeur dans un log.
  Future<void> saveApiKey(String key) async {
    try {
      await _storage.write(
        key: StorageKeys.aiApiKey,
        value: key,
        aOptions: _androidOptions,
      );
    } catch (_) {}
  }

  /// Lecture sécurisée d'une clé API — à n'utiliser que dans le provider IA.
  Future<String?> readApiKey() async {
    try {
      return await _storage.read(
        key: StorageKeys.aiApiKey,
        aOptions: _androidOptions,
      );
    } catch (_) {
      return null;
    }
  }

  Future<String?> readThemeMode() async {
    try {
      return await _storage.read(
        key: StorageKeys.themeMode,
        aOptions: _androidOptions,
      );
    } catch (_) {
      return null;
    }
  }

  Future<void> saveThemeMode(String mode) async {
    try {
      await _storage.write(
        key: StorageKeys.themeMode,
        value: mode,
        aOptions: _androidOptions,
      );
    } catch (_) {}
  }

  Future<String?> readMissionRevisionInterval() async {
    try {
      return await _storage.read(
        key: StorageKeys.missionRevisionInterval,
        aOptions: _androidOptions,
      );
    } catch (_) {
      return null;
    }
  }

  Future<void> saveMissionRevisionInterval(String interval) async {
    try {
      await _storage.write(
        key: StorageKeys.missionRevisionInterval,
        value: interval,
        aOptions: _androidOptions,
      );
    } catch (_) {}
  }

  Future<String?> readLastGreetingTime() async {
    try {
      return await _storage.read(
        key: StorageKeys.lastGreetingTime,
        aOptions: _androidOptions,
      );
    } catch (_) {
      return null;
    }
  }

  Future<void> saveLastGreetingTime(String time) async {
    try {
      await _storage.write(
        key: StorageKeys.lastGreetingTime,
        value: time,
        aOptions: _androidOptions,
      );
    } catch (_) {}
  }
}
