import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:nour_al_quran/pages/settings/pages/notifications/receive_notification.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

@pragma('vm:entry-point')
void onBackGround(NotificationResponse response) {
  NotificationServices.onNotification.add(response.payload);
}

class NotificationServices {
  static final _notificationPlugin = FlutterLocalNotificationsPlugin();
  static final onNotification = BehaviorSubject<String?>();
  final _dailyNotificationChannel = const AndroidNotificationChannel(
    'daily_notifications',
    'Daily Notifications',
    description: 'Channel for daily notifications',
    importance: Importance.high,
  );

  init() async {
    /// int time zone to get proper time zone and that is use for schedule notification
    await _initTimeZone();

    /// set android local notification setting
    /// other_icon Available in drawable folder of android
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('other_icon');

    /// set Ios local notification setting
    DarwinInitializationSettings iosInitializationSettings =
        DarwinInitializationSettings(
            requestAlertPermission: true,
            requestBadgePermission: true,
            requestSoundPermission: true,
            onDidReceiveLocalNotification: (int? id, String? title,
                String? body, String? payload) async {});

    /// init both settings for android and ios
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: iosInitializationSettings,
    );

    /// when app is Closed and user receive notification
    final appLunchDetails =
        await _notificationPlugin.getNotificationAppLaunchDetails();
    if (appLunchDetails != null && appLunchDetails.didNotificationLaunchApp) {
      print("is Lunch ${appLunchDetails.didNotificationLaunchApp}");
      print(appLunchDetails.notificationResponse!.payload);
      onNotification.add(appLunchDetails.notificationResponse!.payload);
    }

    /// on BackGround in a entry Level Method which is responsable for receiving
    /// background notifications
    await _notificationPlugin.initialize(initializationSettings,
        onDidReceiveBackgroundNotificationResponse: onBackGround,
        onDidReceiveNotificationResponse: _onDidReceiveLocalNotification);

    await _notificationPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(_dailyNotificationChannel);

    if (Platform.isIOS) {
      await _notificationPlugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(alert: true, badge: true, sound: true);
    }
    if (Platform.isAndroid) {
      _notificationPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()!
          .requestPermission();
    }

    /// for ios request notification
    if (Platform.isIOS) {
      await _notificationPlugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
    }

    await checkPendingNotification();
  }

  /// add notification to the stream so other page can subscribe it
  /// and get the notification
  Future _onDidReceiveLocalNotification(
      NotificationResponse notificationResponse) async {
    onNotification.add(notificationResponse.payload!);
  }

  Future checkPendingNotification() async {
    final List<PendingNotificationRequest> pendingNotificationRequests =
        await _notificationPlugin.pendingNotificationRequests();
    return pendingNotificationRequests;
  }

  _initTimeZone() async {
    tz.initializeTimeZones();
    final String location = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(location));
  }

  _notificationDetails(String icon,
      {required String channelId,
      required String channelName,
      required String channelDes}) {
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(channelId, channelName,
            channelDescription: channelDes,
            icon: icon,
            importance: Importance.max,
            priority: Priority.max,
            visibility: NotificationVisibility.public,
            category: AndroidNotificationCategory.reminder);
    DarwinNotificationDetails iosNotificationDetails =
        const DarwinNotificationDetails();
    return NotificationDetails(
        android: androidNotificationDetails, iOS: iosNotificationDetails);
  }

  showNotification() async {
    await _notificationPlugin.show(
        1,
        "Notify ",
        "Notify ",
        _notificationDetails(
          "other_icon",
          channelId: _dailyNotificationChannel.id,
          channelName: _dailyNotificationChannel.name,
          channelDes: _dailyNotificationChannel.description!,
        ),
        payload: "recite");
  }

  Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required String payload,
    required DateTime scheduledDateTime,
  }) async {
    await _notificationPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(scheduledDateTime, tz.local),
      _notificationDetails("other_icon",
          channelId: _dailyNotificationChannel.id,
          channelName: _dailyNotificationChannel.name,
          channelDes: _dailyNotificationChannel.description!),
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      payload: payload,
    );
  }

  Future<void> dailyNotifications(
      {required int id,
      required String title,
      required String body,
      required String payload,
      required TimeOfDay dailyNotifyTime}) async {
    await _notificationPlugin.zonedSchedule(
      id,
      title,
      body,
      _scheduleDaily(dailyNotifyTime),
      _notificationDetails("other_icon",
          channelId: _dailyNotificationChannel.id,
          channelName: _dailyNotificationChannel.name,
          channelDes: _dailyNotificationChannel.description!),
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      payload: payload,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  // tz.TZDateTime _scheduleDaily(Time time) {
  //   final now = tz.TZDateTime.now(tz.local);
  //   final scheduledDate = tz.TZDateTime(tz.local, now.year, now.month, now.day, time.hour,time.minute,time.second);
  //   return scheduledDate.isBefore(now)
  //       ? scheduledDate.add(const Duration(days: 1))
  //       : scheduledDate;
  // }

  tz.TZDateTime _scheduleDaily(TimeOfDay time) {
    final now = tz.TZDateTime.now(tz.local);
    final scheduledDate = tz.TZDateTime(
        tz.local, now.year, now.month, now.day, time.hour, time.minute);
    return scheduledDate.isBefore(now)
        ? scheduledDate.add(const Duration(days: 1))
        : scheduledDate;
  }

  Future<void> cancelAllNotifications() async {
    await _notificationPlugin.cancelAll();
  }

  Future<void> cancelNotifications(int id) async {
    await _notificationPlugin.cancel(id);
  }
}
