import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

import 'package:therabot/navigation/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await _initializeNotifications();
  await _createTherabotNotification();
  _createTherabotNotificationListener();

  runApp(const App());
}

Future<void> _initializeNotifications() async {
  AwesomeNotifications notifications = AwesomeNotifications();
  await notifications.initialize(null, [
    NotificationChannel(
      channelKey: 'TherabotNotifs',
      channelDescription: 'Therabot notifications',
      channelName: 'Therabot Notifications',
      importance: NotificationImportance.High,
      playSound: true,
      onlyAlertOnce: true,
    )
  ]);

  await notifications.isNotificationAllowed().then((isAllowed) async {
    if (!isAllowed) {
      await AwesomeNotifications().requestPermissionToSendNotifications();
    }
  });
}

Future<void> _createTherabotNotification() async {
  AwesomeNotifications notifications = AwesomeNotifications();

  await notifications.initialize(null, [
    NotificationChannel(
      channelKey: 'TherabotNotifs',
      channelDescription: 'Therabot notifications',
      channelName: 'Therabot Notifications',
      importance: NotificationImportance.High,
      playSound: true,
      onlyAlertOnce: true,
    )
  ]);

  NotificationCalendar notificationSchedule;
  String localTimeZone = await notifications.getLocalTimeZoneIdentifier();

  notificationSchedule = NotificationCalendar(
    timeZone: localTimeZone,
    hour: 17,
    minute: 42,
    second: 0,
    allowWhileIdle: true,
    repeats: true,
  );

  notifications.createNotification(
    content: NotificationContent(
        channelKey: 'TherabotNotifs',
        id: 10,
        title: 'Test notif',
        body:
            "Hi text will go hereheererasiflasje hi it will be a sentence long hi hi hi hi !"),
    actionButtons: [
      NotificationActionButton(
        buttonType: ActionButtonType.Default,
        label: 'Test',
        key: 'test_button',
        enabled: true,
      )
    ],
    schedule: notificationSchedule,
  );
}

void _createTherabotNotificationListener() async {
  AwesomeNotifications().actionStream.listen((receivedNotification) {
    log("RECEIVED NOTIF");
  });
}
