import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

import 'package:therabot/navigation/app.dart';
import 'package:therabot/store/notif_provider.dart';

StreamSubscription<ReceivedNotification>? receivedNotificationStream;
StreamSubscription<ReceivedAction>? receivedActionStream;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await _createTherabotNotification();
  _createTherabotNotificationListener();

  runApp(const App());
}

Future<void> _initializeNotifications(
    AwesomeNotifications notifications) async {
  await notifications.initialize(
    null,
    [
      NotificationChannel(
        channelGroupKey: 'therabot_prompt_group',
        groupAlertBehavior: GroupAlertBehavior.All,
        channelKey: 'TherabotNotifications',
        channelDescription: 'Therabot notifications',
        channelName: 'Therabot notifications',
        importance: NotificationImportance.High,
        onlyAlertOnce: true,
      )
    ],
    channelGroups: [
      NotificationChannelGroup(
          channelGroupkey: 'therabot_prompt_group',
          channelGroupName: 'Therabot prompt group')
    ],
  );

  await notifications.isNotificationAllowed().then((isAllowed) async {
    if (!isAllowed) {
      await AwesomeNotifications().requestPermissionToSendNotifications();
    }
  });
}

Future<void> _createTherabotNotification() async {
  AwesomeNotifications notifications = AwesomeNotifications();
  // notifications.dispose();

  await _initializeNotifications(notifications);
  bool shouldCreate = true;
  var test = await notifications.listScheduledNotifications();
  for (var i in test) {
    if (i.content?.groupKey != null &&
        i.content?.groupKey == 'therabot_prompt_group') {
      shouldCreate = false;
      break;
    }
  }
  if (!shouldCreate) return;

  NotificationCalendar notificationSchedule;
  String localTimeZone = await notifications.getLocalTimeZoneIdentifier();

  notificationSchedule = NotificationCalendar(
    timeZone: localTimeZone,
    // hour: 16,
    // minute: 59,
    second: 0,
    allowWhileIdle: true,
  );

  await notifications.createNotification(
    content: NotificationContent(
        groupKey: 'therabot_prompt_group',
        channelKey: 'TherabotNotifications',
        id: 0,
        title: 'Test notification',
        body: "Initial notification text!"),
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
  AwesomeNotifications notifications = AwesomeNotifications();
  int count = 0;
  int id = 1;

  receivedNotificationStream ??=
      notifications.displayedStream.listen((receivedNotification) async {
    log("${receivedNotification.body}");
    // FirebaseDbService.addMessageData(receivedNotification.body); //TODO
    NotificationCalendar notificationSchedule;
    String localTimeZone = await notifications.getLocalTimeZoneIdentifier();

    notificationSchedule = NotificationCalendar(
      timeZone: localTimeZone,
      // hour: 16,
      // minute: 59,
      second: 0,
      allowWhileIdle: true,
    );

    await notifications.createNotification(
      content: NotificationContent(
          groupKey: 'therabot_prompt_group',
          channelKey: 'TherabotNotifications',
          id: id,
          title: 'Test notif',
          body: "New text + $count"),
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
    count += 1;
    id += 1;
  });

  receivedActionStream ??=
      notifications.actionStream.listen((receivedAction) async {
    notifications.dismissNotificationsByGroupKey('therabot_prompt_group');
    id = 0;

    log("${await notifications.listScheduledNotifications()}");
  });
}
