import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../di/injection.dart';
import '../services/secure_storage_service.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  static const _themeChannel = MethodChannel('sn.smapp.priorise/theme');

  ThemeCubit() : super(ThemeMode.system) {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final storage = getIt<SecureStorageService>();
    final themeStr = await storage.readThemeMode();
    if (themeStr == 'dark') {
      emit(ThemeMode.dark);
    } else if (themeStr == 'light') {
      emit(ThemeMode.light);
    } else {
      emit(ThemeMode.system);
    }
    _syncNativeTheme(themeStr ?? 'system');
  }

  Future<void> setTheme(ThemeMode mode) async {
    emit(mode);
    final storage = getIt<SecureStorageService>();
    String val = 'system';
    if (mode == ThemeMode.dark) val = 'dark';
    if (mode == ThemeMode.light) val = 'light';
    await storage.saveThemeMode(val);
    _syncNativeTheme(val);
  }

  Future<void> _syncNativeTheme(String theme) async {
    try {
      await _themeChannel.invokeMethod('setTheme', {'theme': theme});
    } catch (e) {
      debugPrint('Failed to sync native theme: $e');
    }
  }
}
