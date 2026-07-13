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
}

class SecureStorageService {
  SecureStorageService(this._storage);

  final FlutterSecureStorage _storage;

  static const _androidOptions = AndroidOptions(
    encryptedSharedPreferences: true,
  );

  Future<bool> isFirstLaunch() async {
    final raw = await _storage.read(
      key: StorageKeys.firstLaunch,
      aOptions: _androidOptions,
    );
    // Null → jamais écrit → premier lancement
    return raw == null || raw == 'true';
  }

  Future<void> setFirstLaunchDone() async {
    await _storage.write(
      key: StorageKeys.firstLaunch,
      value: 'false',
      aOptions: _androidOptions,
    );
  }

  /// Stockage d'une clé API — ne retourne jamais la valeur dans un log.
  Future<void> saveApiKey(String key) async {
    await _storage.write(
      key: StorageKeys.aiApiKey,
      value: key,
      aOptions: _androidOptions,
    );
  }

  /// Lecture sécurisée d'une clé API — à n'utiliser que dans le provider IA.
  Future<String?> readApiKey() async {
    return _storage.read(
      key: StorageKeys.aiApiKey,
      aOptions: _androidOptions,
    );
  }

  Future<String?> readThemeMode() async {
    return _storage.read(
      key: StorageKeys.themeMode,
      aOptions: _androidOptions,
    );
  }

  Future<void> saveThemeMode(String mode) async {
    await _storage.write(
      key: StorageKeys.themeMode,
      value: mode,
      aOptions: _androidOptions,
    );
  }
}
