// ignore_for_file: constant_identifier_names

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationApi {
  static final _notifications = FlutterLocalNotificationsPlugin();
  static final onNotifications = BehaviorSubject<String?>();

  static Future _notificationDetails() async {
    return const NotificationDetails(
        android: AndroidNotificationDetails(
            'channel id',
            'channel name',
            channelDescription: 'channel description',
            importance: Importance.max
        ),
        iOS: IOSNotificationDetails()

    );
  }

  static Future init({bool initSheduled = false}) async {
    const android = AndroidInitializationSettings("@mipmap/ic_launcher");
    const IOs = IOSInitializationSettings();
    const settings = InitializationSettings(android: android, iOS: IOs);
    await _notifications.initialize(settings,
        onSelectNotification: (payload) async {
          onNotifications.add(payload);
        });
  }

  static Future showNotification({
    int id = 0,

    String? title,
    String? body,
    String? payload,

  }) async =>
      _notifications.show(id, title, body, await _notificationDetails(),
          payload: payload);

  static Future showSheduledNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
    required DateTime sheduledDate,
  }) async =>
      _notifications.zonedSchedule(
        id,
        title,
        body,
        tz.TZDateTime.from(sheduledDate,tz.local),
        await _notificationDetails(),
        payload: payload,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime
      );
}
