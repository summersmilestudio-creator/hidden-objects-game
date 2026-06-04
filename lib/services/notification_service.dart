import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

/// Schedule re-engagement push notifications.
/// Default schedule = every 6 hours (4×/day at 03:00, 09:00, 15:00, 21:00 local).
/// Reschedule on every app open so the chain stays alive.
class NotificationService {
  NotificationService._();
  static final NotificationService instance = NotificationService._();

  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();
  bool _ready = false;

  // Re-engagement notification copy, localized inline (no BuildContext here).
  // Falls back to Romanian (the app's default/template language).
  static const Map<String, String> _titles = {
    'ro': 'Obiecte Ascunse', 'en': 'Hidden Objects', 'es': 'Objetos Ocultos',
    'pt': 'Objetos Ocultos', 'fr': 'Objets Cachés', 'de': 'Versteckte Objekte',
    'it': 'Oggetti Nascosti', 'ru': 'Поиск предметов', 'ja': '隠しオブジェクト',
    'ko': '숨은 그림 찾기', 'zh': '隐藏物品',
  };
  static const Map<String, String> _bodies = {
    'ro': 'Găsește obiectele ascunse! 🔍',
    'en': 'Find the hidden objects! 🔍',
    'es': '¡Encuentra los objetos ocultos! 🔍',
    'pt': 'Encontre os objetos ocultos! 🔍',
    'fr': 'Trouvez les objets cachés ! 🔍',
    'de': 'Finde die versteckten Objekte! 🔍',
    'it': 'Trova gli oggetti nascosti! 🔍',
    'ru': 'Найдите спрятанные предметы! 🔍',
    'ja': '隠れた物を見つけよう！🔍',
    'ko': '숨은 물건을 찾아보세요! 🔍',
    'zh': '快来找出隐藏的物品吧！🔍',
  };

  static String _lang() =>
      PlatformDispatcher.instance.locale.languageCode.toLowerCase();

  static String localizedTitle() => _titles[_lang()] ?? _titles['ro']!;
  static String localizedBody() => _bodies[_lang()] ?? _bodies['ro']!;

  Future<void> init() async {
    if (_ready) return;
    try {
      tzdata.initializeTimeZones();
      try {
        final name = await FlutterTimezone.getLocalTimezone();
        tz.setLocalLocation(tz.getLocation(name));
      } catch (_) {/* falls back to UTC */}

      const android = AndroidInitializationSettings('@mipmap/ic_launcher');
      const ios = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
      );
      await _plugin.initialize(
          const InitializationSettings(android: android, iOS: ios));

      await _plugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.requestNotificationsPermission();
      _ready = true;
    } catch (e) {
      if (kDebugMode) debugPrint('NotificationService init failed: $e');
    }
  }

  /// Backward-compat wrapper — older call sites call this; we now schedule
  /// every 6 hours instead of just once a day. [hour]/[minute] ignored.
  Future<void> scheduleDailyReminder({
    required String title,
    required String body,
    int hour = 19,
    int minute = 0,
  }) =>
      scheduleEvery6Hours(title: title, body: body);

  /// Schedules 4 reminders/day, one every 6 hours, at fixed local times:
  /// 03:00, 09:00, 15:00, 21:00. Stable IDs so re-scheduling on each app
  /// open just updates the same slot, never stacks.
  Future<void> scheduleEvery6Hours({
    required String title,
    required String body,
  }) async {
    await init();
    if (!_ready) return;
    const slots = [
      [3025, 3, 0],
      [9025, 9, 0],
      [15025, 15, 0],
      [21025, 21, 0],
    ];
    for (final s in slots) {
      try {
        await _plugin.zonedSchedule(
          s[0],
          title,
          body,
          _nextInstance(s[1], s[2]),
          const NotificationDetails(
            android: AndroidNotificationDetails(
              'reengagement_6h',
              'Reminders every 6h',
              channelDescription: 'Friendly nudges to come back and play',
              importance: Importance.defaultImportance,
              priority: Priority.defaultPriority,
            ),
            iOS: DarwinNotificationDetails(),
          ),
          androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime,
          matchDateTimeComponents: DateTimeComponents.time,
        );
      } catch (e) {
        if (kDebugMode) debugPrint('scheduleEvery6Hours[$s] failed: $e');
      }
    }
  }

  tz.TZDateTime _nextInstance(int hour, int minute) {
    final now = tz.TZDateTime.now(tz.local);
    var d = tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);
    if (d.isBefore(now)) d = d.add(const Duration(days: 1));
    return d;
  }
}
