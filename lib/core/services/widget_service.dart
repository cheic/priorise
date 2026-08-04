import 'dart:async';
import 'package:home_widget/home_widget.dart';
import 'package:isar/isar.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import '../di/injection.dart';
import '../services/database_service.dart';
import '../models/task_model.dart';
import '../models/role_model.dart';

/// Service qui synchronise les données Isar vers les widgets Android
/// via home_widget (SharedPreferences bridge).
class WidgetService {
  static Timer? _debounceTimer;
  static bool _isUpdating = false;

  /// Met à jour TOUS les widgets d'un coup (avec debounce pour préserver l'énergie et l'IPC natif).
  /// Appelé après chaque modification de tâche/rôle.
  static Future<void> updateAllWidgets({Duration debounce = const Duration(milliseconds: 500)}) async {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(debounce, () async {
      if (_isUpdating) return;
      _isUpdating = true;
      try {
        await _performUpdate();
      } finally {
        _isUpdating = false;
      }
    });
  }

  static Future<void> _performUpdate() async {
    try {
      final db = getIt<DatabaseService>();
      final now = DateTime.now();
      final startOfDay = DateTime(now.year, now.month, now.day);
      final endOfDay = DateTime(now.year, now.month, now.day, 23, 59, 59);
      final monday = DateTime(now.year, now.month, now.day).subtract(Duration(days: now.weekday - 1));
      final endOfWeek = monday.add(const Duration(days: 6, hours: 23, minutes: 59, seconds: 59));

      // Récupérer les tâches pertinentes (non terminées, ou terminées aujourd'hui)
      final allTasks = await db.isar.tasks
        .filter()
        .doneEqualTo(false)
        .or()
        .doneAtBetween(startOfDay, endOfDay)
        .findAll();
      final tasks = allTasks.where((t) => t.weekStart.isBefore(endOfWeek) || t.weekStart.isAtSameMomentAs(endOfWeek)).toList();

      final roles = await db.isar.lifeRoles.where().findAll();

      // === FOCUS WIDGET ===
      // Trouver la priorité du jour (Grosse Pierre Q2 non faite)
      final focusTask = tasks.where((t) => t.important && !t.urgent && !t.done).toList();
      if (focusTask.isNotEmpty) {
        final ft = focusTask.first;
        final role = roles.where((r) => r.id == ft.roleId).firstOrNull;
        await HomeWidget.saveWidgetData<String>('focus_title', ft.title);
        await HomeWidget.saveWidgetData<String>('focus_role', role?.name ?? '');
        await HomeWidget.saveWidgetData<bool>('focus_has_task', true);
      } else {
        await HomeWidget.saveWidgetData<String>('focus_title', '');
        await HomeWidget.saveWidgetData<String>('focus_role', '');
        await HomeWidget.saveWidgetData<bool>('focus_has_task', false);
      }

      // === MATRIX WIDGET ===
      final pendingTasks = tasks.where((t) => !t.done).toList();
      final q1 = pendingTasks.where((t) => t.important && t.urgent).length;
      final q2 = pendingTasks.where((t) => t.important && !t.urgent).length;
      final q3 = pendingTasks.where((t) => !t.important && t.urgent).length;
      final q4 = pendingTasks.where((t) => !t.important && !t.urgent).length;
      await HomeWidget.saveWidgetData<int>('matrix_q1', q1);
      await HomeWidget.saveWidgetData<int>('matrix_q2', q2);
      await HomeWidget.saveWidgetData<int>('matrix_q3', q3);
      await HomeWidget.saveWidgetData<int>('matrix_q4', q4);

      // === LIST WIDGET ===
      // Max 5 tâches pour le widget
      final listTasks = tasks.take(5).toList();
      await HomeWidget.saveWidgetData<int>('list_count', listTasks.length);
      for (var i = 0; i < 5; i++) {
        if (i < listTasks.length) {
          final t = listTasks[i];
          await HomeWidget.saveWidgetData<String>('list_title_$i', t.title);
          await HomeWidget.saveWidgetData<bool>('list_done_$i', t.done);
          await HomeWidget.saveWidgetData<int>('list_id_$i', t.id);
        } else {
          await HomeWidget.saveWidgetData<String>('list_title_$i', '');
          await HomeWidget.saveWidgetData<bool>('list_done_$i', false);
          await HomeWidget.saveWidgetData<int>('list_id_$i', 0);
        }
      }

      // === STATS WIDGET (pour info globale) ===
      final totalTasks = tasks.length;
      final doneTasks = tasks.where((t) => t.done).length;
      await HomeWidget.saveWidgetData<int>('stats_total', totalTasks);
      await HomeWidget.saveWidgetData<int>('stats_done', doneTasks);

      // Rafraîchir les 4 widgets Android
      await HomeWidget.updateWidget(
        name: 'FocusWidgetProvider',
        androidName: 'FocusWidgetProvider',
        qualifiedAndroidName: 'sn.smapp.priorise.FocusWidgetProvider',
      );
      await HomeWidget.updateWidget(
        name: 'MatrixWidgetProvider',
        androidName: 'MatrixWidgetProvider',
        qualifiedAndroidName: 'sn.smapp.priorise.MatrixWidgetProvider',
      );

      await HomeWidget.updateWidget(
        name: 'ListWidgetProvider',
        androidName: 'ListWidgetProvider',
        qualifiedAndroidName: 'sn.smapp.priorise.ListWidgetProvider',
      );
    } on MissingPluginException {
      // Le plugin peut être indisponible au hot-restart / sur plateforme non supportée.
      debugPrint('home_widget plugin unavailable, widget sync skipped.');
    }
  }
}
