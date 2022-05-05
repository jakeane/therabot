import 'dart:async';
import 'dart:developer';

import 'package:awesome_notifications/awesome_notifications.dart';

enum Unit { day, hour, minute, second }
AwesomeNotifications notifications = AwesomeNotifications();
StreamSubscription<ReceivedNotification>? receivedNotificationStream;
StreamSubscription<ReceivedAction>? receivedActionStream;

// Map<String, int> globalNotificationScheduleMap = {'hour': 17, 'minute': 0, 'second': 0};
Map<String, int> globalNotificationScheduleMap = {'second': 0};
String notificationGroupKey = 'therabot_prompt_group';
String notificationChannelKey = 'therabot_notifications';
Duration cancelDuration = const Duration(seconds: 30);
Unit timeUnit = Unit.minute;

Future<void> initializeTherabotNotification() async {
  await _initializeNotifications();
  _createTherabotNotificationListeners();

  bool shouldCreate = true;
  List<NotificationModel> scheduledNotifications =
      await notifications.listScheduledNotifications();
  for (NotificationModel notif in scheduledNotifications) {
    if (notif.content?.groupKey != null &&
        notif.content?.groupKey == notificationGroupKey) {
      shouldCreate = false;
      break;
    }
  }
  if (!shouldCreate) return;
  await createTherabotNotification(0, "Initial notification text!");
}

Future<void> createTherabotNotification(int id, String notificationBody,
    [Map<String, int>? notificationScheduleMap]) async {
  NotificationCalendar notificationSchedule = notificationScheduleMap != null
      ? await _createNotificationCalendar(notificationScheduleMap)
      : await _createNotificationCalendar(globalNotificationScheduleMap);

  await notifications.createNotification(
    content: NotificationContent(
        groupKey: notificationGroupKey,
        channelKey: notificationChannelKey,
        id: id,
        title: 'Therabot',
        body: notificationBody),
    schedule: notificationSchedule,
  );
}

Future<NotificationCalendar> _createNotificationCalendar(
    Map<String, int> notificationScheduleMap) async {
  String localTimeZone = await notifications.getLocalTimeZoneIdentifier();
  return NotificationCalendar(
    timeZone: localTimeZone,
    day: notificationScheduleMap.containsKey('day')
        ? notificationScheduleMap['day']
        : null,
    hour: notificationScheduleMap.containsKey('hour')
        ? notificationScheduleMap['hour']
        : null,
    minute: notificationScheduleMap.containsKey('minute')
        ? notificationScheduleMap['minute']
        : null,
    second: notificationScheduleMap.containsKey('second')
        ? notificationScheduleMap['second']
        : null,
    allowWhileIdle: true,
  );
}

Future<void> _initializeNotifications() async {
  await notifications.initialize(
    null,
    [
      NotificationChannel(
        channelGroupKey: notificationGroupKey,
        channelKey: notificationChannelKey,
        channelDescription: 'Therabot notifications',
        channelName: 'Therabot notifications',
        importance: NotificationImportance.High,
        groupAlertBehavior: GroupAlertBehavior.All,
      )
    ],
    channelGroups: [
      NotificationChannelGroup(
          channelGroupkey: notificationGroupKey,
          channelGroupName: 'Therabot prompt group')
    ],
  );

  await notifications.isNotificationAllowed().then((isAllowed) async {
    if (!isAllowed) {
      await notifications.requestPermissionToSendNotifications();
    }
  });
}

void _createTherabotNotificationListeners() async {
  if (receivedNotificationStream != null) return;
  int count = 0;
  bool dismissed = false;

  receivedNotificationStream ??=
      notifications.displayedStream.listen((receivedNotification) async {
    log("${receivedNotification.id}: ${receivedNotification.body}");
    int? idPrev = receivedNotification.id;
    if (dismissed) {
      await createTherabotNotification(0, 'New text + $count');
      dismissed = false;
    } else {
      await createTherabotNotification((idPrev ?? -1) + 1, 'New text + $count');
    }
    // FirebaseDbService.addMessageData(receivedNotification.body); //TODO

    if (idPrev != null) {
      await notifications.cancelSchedule(idPrev);
    }
    count += 1;
  });

  receivedActionStream ??=
      notifications.actionStream.listen((receivedAction) async {
    notifications.dismissNotificationsByGroupKey(notificationGroupKey);
    dismissed = true;
  });
}

Future<void> shouldCancelNextNotification(DateTime lastInteractionTime) async {
  int? id = 0;
  String body = _getRandomPrompt();
  log("${(await notifications.listScheduledNotifications())}");

  NotificationModel model = (await notifications.listScheduledNotifications())
      .firstWhere(
          (element) => element.content?.groupKey == notificationGroupKey,
          orElse: () => NotificationModel(content: null));

  if (model.content != null) {
    NotificationSchedule? schedule = model.schedule;
    if (model.content!.id != null) {
      id = model.content!.id!.toInt();
    }
    if (model.content!.body != null) {
      body = model.content!.body!.toString();
    }
    if (schedule != null) {
      DateTime scheduleTime = notifScheduleToDateTime(schedule.toMap());
      log("SCHED? $scheduleTime");
      if (scheduleTime.difference(lastInteractionTime) <= cancelDuration) {
        log("SHOULD CANCEL");
        notifications.cancelSchedule(id);
        await createTherabotNotification(
            id, body, _getNewScheduleMap(schedule, scheduleTime));
      }
      log('Interaction time: $lastInteractionTime, Schedule: $scheduleTime');
    }
  }
}

Map<String, int>? _getNewScheduleMap(
    NotificationSchedule schedule, DateTime scheduleTime) {
  Map<String, dynamic> scheduleMap = schedule.toMap();

  if (timeUnit == Unit.day) {
    scheduleMap['day'] = scheduleTime.add(const Duration(days: 1)).day;
    return {
      'day': scheduleMap['day'],
      'hour': scheduleMap['hour'],
      'minute': scheduleMap['minute'],
      'second': scheduleMap['second']
    };
  } else if (timeUnit == Unit.hour) {
    scheduleMap['hour'] = scheduleTime.add(const Duration(hours: 1)).hour;
    return {
      'hour': scheduleMap['hour'],
      'minute': scheduleMap['minute'],
      'second': scheduleMap['second']
    };
  } else if (timeUnit == Unit.minute) {
    scheduleMap['minute'] = scheduleTime.add(const Duration(minutes: 1)).minute;
    return {'minute': scheduleMap['minute'], 'second': scheduleMap['second']};
  }
}

DateTime notifScheduleToDateTime(Map<String, dynamic> notificationSchedule) {
  log("NOTIF SCHED: $notificationSchedule");
  if (timeUnit == Unit.day) {
    DateTime now = DateTime.now();
    DateTime scheduled = DateTime(
        now.year,
        now.month,
        notificationSchedule['day'] ?? now.day,
        notificationSchedule['hour'],
        notificationSchedule['minute'],
        notificationSchedule['second']);
    if (scheduled.isBefore(now)) {
      return scheduled.add(const Duration(days: 1));
    } else {
      return scheduled;
    }
  } else if (timeUnit == Unit.hour) {
    DateTime now = DateTime.now();
    DateTime scheduled = DateTime(
        now.year,
        now.month,
        now.day,
        notificationSchedule['hour'] ?? now.hour,
        notificationSchedule['minute'],
        notificationSchedule['second']);
    if (scheduled.isBefore(now)) {
      return scheduled.add(const Duration(hours: 1));
    } else {
      return scheduled;
    }
  } else {
    DateTime now = DateTime.now();
    DateTime scheduled = DateTime(
        now.year,
        now.month,
        now.day,
        now.hour,
        notificationSchedule['minute'] ?? now.minute,
        notificationSchedule['second']);
    if (scheduled.isBefore(now)) {
      return scheduled.add(const Duration(minutes: 1));
    } else {
      return scheduled;
    }
  }
}

String _getRandomPrompt() {
  return "random prompt";
}
