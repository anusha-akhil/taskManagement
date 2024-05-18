// import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:taskmanagementapp/main.dart';
import 'package:taskmanagementapp/pages/noti_details.dart';

import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final FlutterLocalNotificationsPlugin notificationService =
      FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    notificationService
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()!
        .requestNotificationsPermission();
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
            requestAlertPermission: true,
            requestBadgePermission: true,
            requestSoundPermission: true,
            onDidReceiveLocalNotification: onDidReceiveLocalNotification);

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: androidInitializationSettings,
      iOS: initializationSettingsDarwin,
      macOS: initializationSettingsDarwin,
    );

    await notificationService.initialize(initializationSettings,
        onDidReceiveNotificationResponse: onDidReceiveNotificationResponse);
  }

  void onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) {
    print("id-$id");
  }

  void onDidReceiveNotificationResponse(
      NotificationResponse notificationResponse) async {
    final String? payload = notificationResponse.payload;
    if (notificationResponse.payload != null) {
      print('notification payload: $payload');
      await MyApp.navigatorKey.currentState?.push(MaterialPageRoute(
        builder: (context) => Notidetail(
          payload: payload,
        ),
      ));
    }

    // await Navigator.push(
    //   context,
    //   MaterialPageRoute<void>(builder: (context) => Notidetail(payload: payload)),
    // );
  }

  ////////////////////show simple notification

  static Future showSimplenotification(
      {required String title,
      required String body,
      required String payload}) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('notification', 'notification test',
            channelDescription: 'test notification',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');
    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await notificationService.show(0, title, body, notificationDetails,
        payload: payload);
  }

  /////////////////////////////////////////////////
  static Future showSchedulenotification(
      {required String title,
      required String body,
      required String payload,
      required DateTime scheduledNotificationDateTime}) async {
    // final tz.TZDateTime dateTime = tz.TZDateTime.from(
    //   scheduledNotificationDateTime,
    //   tz.local,
    // );
    // final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    // tz.TZDateTime scheduledDate = tz.TZDateTime(tz.local, scheduledNotificationDateTime.year,
    //     scheduledNotificationDateTime.month, scheduledNotificationDateTime.day, scheduledNotificationDateTime.hour, scheduledNotificationDateTime.minute - 5, 30);

    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
            'scheduled notification', 'scheuled notification test',
            channelDescription: 'scheuled test notification',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');
    tz.initializeTimeZones();
    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await notificationService.zonedSchedule(
        1,
        title,
        body,
        payload: payload,
        // tz.TZDateTime.now(tz.local).add(Duration(seconds: 3)),
        tz.TZDateTime.from(
          scheduledNotificationDateTime,
          tz.local,
        ).subtract(Duration(minutes: 10)),
        // scheduledDate,
        notificationDetails,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.wallClockTime,
        // ignore: deprecated_member_use
        androidAllowWhileIdle: true);
  }
}
