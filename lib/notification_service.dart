import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notifications =
  FlutterLocalNotificationsPlugin();

  /// 🔗 CALLBACK FOR CLICK
  static Function(String payload)? onNotificationClick;

  static Future<void> init() async {
    tz.initializeTimeZones();

    const androidSettings =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    const settings = InitializationSettings(
      android: androidSettings,
    );

    await _notifications.initialize(
      settings,

      /// ✅ HANDLE NOTIFICATION CLICK
      onDidReceiveNotificationResponse: (response) {
        final payload = response.payload;

        if (payload != null && onNotificationClick != null) {
          onNotificationClick!(payload);
        }
      },
    );
  }

  /// 🔔 ANDROID 13 PERMISSION
  static Future<void> requestPermission() async {
    final androidImplementation =
    _notifications.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();

    await androidImplementation?.requestNotificationsPermission();
  }

  /// 🔔 SCHEDULE NOTIFICATION WITH PAYLOAD
  static Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledTime,
    required String payload, // ✅ ADDED
  }) async {
    await _notifications.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(scheduledTime, tz.local),

      const NotificationDetails(
        android: AndroidNotificationDetails(
          'pet_channel',
          'Pet Appointments',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),

      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,

      androidScheduleMode:
      AndroidScheduleMode.exactAllowWhileIdle,

      payload: payload, // ✅ IMPORTANT
    );
  }
}