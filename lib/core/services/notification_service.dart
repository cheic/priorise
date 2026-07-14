import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:autostart_settings/autostart_settings.dart';

import '../tokens/app_colors.dart';
import '../tokens/app_spacing.dart';
import '../tokens/app_typography.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  bool _isInitialized = false;

  Future<void> init() async {
    if (_isInitialized) return;

    tz.initializeTimeZones();
    final timeZoneInfo = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneInfo));

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );

    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: _onDidReceiveNotificationResponse,
    );
    _isInitialized = true;
  }

  void _onDidReceiveNotificationResponse(NotificationResponse response) {
    // Handle notification tap
  }

  Future<bool> checkPermission() async {
    if (Platform.isAndroid) {
      final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
          _flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();

      final bool? granted = await androidImplementation?.areNotificationsEnabled();
      return granted ?? false;
    } else if (Platform.isIOS) {
      return false; // Typically we just request it
    }
    return false;
  }

  Future<bool> requestPermissionWithExplanation(BuildContext context) async {
    bool isGranted = await checkPermission();
    if (isGranted) return true;

    if (!context.mounted) return false;
    final bool shouldRequest = await _showExplanationDialog(context);
    if (!shouldRequest) return false;

    // Demander explicitement le AutoStart pour les surcouches restrictives (Xiaomi, Redmi, Oppo...)
    if (Platform.isAndroid) {
      try {
        final canOpen = await AutostartSettings.canOpen(autoStart: true, batterySafer: true);
        if (canOpen) {
          // L'utilisateur sera redirigé vers les paramètres pour autoriser l'autostart
          await AutostartSettings.open(autoStart: true, batterySafer: true);
        }
      } catch (e) {
        // Ignorer si ça échoue (tous les téléphones n'ont pas cette option)
      }
    }

    if (Platform.isAndroid) {
      final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
          _flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();

      final bool? granted = await androidImplementation?.requestNotificationsPermission();
      return granted ?? false;
    } else if (Platform.isIOS) {
      final bool? granted = await _flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
      return granted ?? false;
    }
    return false;
  }

  Future<bool> _showExplanationDialog(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: context.cSurfaceRaised,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSpacing.radiusM)),
          title: Text('Notifications', style: AppTypography.displaySmall(color: context.cTextPrimary)),
          content: Text(
            'Priorise a besoin de vous envoyer des notifications pour vos rappels doux (une fois par jour maximum) et pour votre session de planification hebdomadaire.\n\nAutorisez-vous l\'application à vous envoyer des notifications ?',
            style: AppTypography.bodySmall(color: context.cTextSecondary),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Plus tard', style: AppTypography.labelMedium(color: context.cTextTertiary)),
              onPressed: () => Navigator.of(context).pop(false),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: context.cBrass,
                foregroundColor: context.cInk,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSpacing.radiusS)),
              ),
              child: Text('Autoriser', style: AppTypography.labelMedium()),
              onPressed: () => Navigator.of(context).pop(true),
            ),
          ],
        );
      },
    );
    return result ?? false;
  }

  Future<void> scheduleDailyReminder({required int hour, required int minute}) async {
    await _flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        'Priorité du jour',
        'N\'oubliez pas votre grosse pierre aujourd\'hui.',
        _nextInstanceOfTime(hour, minute),
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'daily_reminder_channel',
            'Rappels Quotidiens',
            channelDescription: 'Rappel pour votre priorité du jour',
            importance: Importance.high,
            priority: Priority.high,
          ),
          iOS: DarwinNotificationDetails(),
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  tz.TZDateTime _nextInstanceOfTime(int hour, int minute) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }
}
