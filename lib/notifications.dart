import 'dart:async';
import 'dart:developer';
import 'dart:math' as math;

import 'package:collection/collection.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'package:therabot/widgets/chatbot/core/chat_window.dart';

AwesomeNotifications notifications = AwesomeNotifications();
StreamSubscription<ReceivedNotification>? receivedNotificationStream;
StreamSubscription<ReceivedAction>? receivedActionStream;

// Map<String, int> globalNotificationScheduleMap = {'hour': 17, 'minute': 0, 'second': 0};
Map<int, Map<String, int>> globalNotificationScheduleMaps = {
  0: {'minute': 0, 'second': 0},
  1: {'minute': 10, 'second': 0},
  2: {'minute': 20, 'second': 0},
  3: {'minute': 30, 'second': 0},
  4: {'minute': 40, 'second': 0},
  5: {'minute': 50, 'second': 0}
};
// Map<int, Map<String, int>> globalNotificationScheduleMaps = {
//   0: {'hour': 16, 'minute': 0, 'second': 0},
//   1: {'hour': 17, 'minute': 0, 'second': 0},
//   2: {'hour': 18, 'minute': 0, 'second': 0},
//   3: {'hour': 19, 'minute': 0, 'second': 0},
// };

String notificationGroupKey = 'therabot_prompt_group';
String notificationChannelKey = 'therabot_notifications';
Duration cancelDuration = const Duration(minutes: 5);

Future<void> initializeAndCreateTherabotNotification() async {
  await _initializeNotifications();
  _createTherabotNotificationListeners();
  bool shouldCreate = await _shouldCreate();
  if (!shouldCreate) return;

  Map<String, int>? scheduleMap = _getInitialScheduleMap();
  log("INITIAL SCHEDULE: $scheduleMap");
  await _createTherabotNotification(0, _getRandomPrompt(), scheduleMap);
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
        onlyAlertOnce: false,
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

Future<bool> _shouldCreate() async {
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

  return shouldCreate;
}

Map<String, int>? _getInitialScheduleMap() {
  for (int id in globalNotificationScheduleMaps.keys) {
    Map<String, int> scheduleMap = globalNotificationScheduleMaps[id]!;
    DateTime scheduleTime = _notifScheduleToDateTime(scheduleMap, init: true);
    log("HERE: $scheduleTime");

    // Initial notification time should be the next occurring time
    if (scheduleTime.isAfter(DateTime.now())) {
      return globalNotificationScheduleMaps[id];
    }
  }
  // If all notification times have already occurred, schedule for the next unit of time
  return globalNotificationScheduleMaps[0];
}

int _getInitialScheduleMapInd() {
  for (int id in globalNotificationScheduleMaps.keys) {
    Map<String, int> scheduleMap = globalNotificationScheduleMaps[id]!;
    DateTime scheduleTime = _notifScheduleToDateTime(scheduleMap, init: true);
    log("HERE: $scheduleTime");

    // Initial notification time should be the next occurring time
    if (scheduleTime.isAfter(DateTime.now())) {
      return id;
    }
  }
  // If all notification times have already occurred, schedule for the next unit of time
  return 0;
}

Future<void> _createTherabotNotification(int id, String notificationBody,
    [Map<String, int>? scheduleMap]) async {
  NotificationCalendar notificationSchedule = scheduleMap != null
      ? await _createNotificationCalendar(scheduleMap)
      : await _createNotificationCalendar(globalNotificationScheduleMaps[0]!);

  bool created = await notifications.createNotification(
    content: NotificationContent(
        groupKey: notificationGroupKey,
        channelKey: notificationChannelKey,
        id: id,
        title: 'Therabot',
        body: notificationBody),
    schedule: notificationSchedule,
  );

  log("CREATED NOTIFICATION! $created");
  await _logScheduledNotifs();
}

Future<void> _logScheduledNotifs() async {
  List<NotificationModel> notifs =
      await notifications.listScheduledNotifications();
  log("$notifs");
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

void _createTherabotNotificationListeners() async {
  if (receivedNotificationStream != null) {
    // Only create listeners if not listening already
    return;
  }
  bool dismissed =
      false; // Used to determined whether we can reset the ids on subsequent notifications

  receivedNotificationStream ??=
      notifications.displayedStream.listen((receivedNotification) async {
    log("${receivedNotification.id}: ${receivedNotification.body}, ${receivedNotification.groupKey}");

    int? idPrev = receivedNotification.id;
    if (idPrev != null) {
      bool result = await InternetConnectionChecker().hasConnection;
      if (result == true) {
        log('YAY! Free cute dog pics!');
      } else {
        log('No internet :( Reason:');
      }

      if (!result) {
        //TODO LO: Check connectivity
        await notifications.dismiss(idPrev);
        log("DISMISSED!");
        int schedule = _getInitialScheduleMapInd();
        await _delayNotification(receivedNotification.id!.toInt(),
            receivedNotification.body!, schedule);
        await notifications.cancelSchedule(idPrev);
        return;
      }

      await notifications.cancelSchedule(
          idPrev); // Remove the notification schedule to prevent clutter
      if (dismissed) {
        // If notifications were dismissed, reset the ids on subsequent notifications
        await _createTherabotNotification(0, _getRandomPrompt());
        dismissed = false;
      } else {
        await _createTherabotNotification(idPrev + 1, _getRandomPrompt());
      }
    }
    // FirebaseDbService.addMessageData(receivedNotification.body); //TODO
  });

  receivedActionStream ??=
      notifications.actionStream.listen((receivedAction) async {
    // Dismiss all notifications if one is selected
    log("ACTION!");
    notifications.dismissNotificationsByGroupKey(notificationGroupKey);
    dismissed = true;
  });
}

Future<void> checkDelayNextNotification(DateTime lastInteractionTime) async {
  NotificationModel model = (await notifications.listScheduledNotifications())
      .firstWhere(
          (element) => element.content?.groupKey == notificationGroupKey,
          orElse: () => NotificationModel(content: null));
  log("MODEL: $model");
  if (model.content != null &&
      model.schedule != null &&
      model.content!.id != null &&
      model.content!.body != null) {
    NotificationSchedule schedule = model.schedule!;
    int id = model.content!.id!;
    String body = model.content!.body!;

    DateTime scheduleTime = _notifScheduleToDateTime(schedule.toMap());
    log("NOW: ${DateTime.now()}, SCHED: $scheduleTime");
    if (scheduleTime.difference(lastInteractionTime) <= cancelDuration) {
      log("SHOULD DELAY");
      await _delayNotification(id, body, _getNextScheduleMapInd(schedule));
    }
  }
}

Future<void> _delayNotification(int id, String body, int scheduleInd) async {
  notifications.cancelSchedule(id);
  String newBody = scheduleInd == 0 ? _getRandomPrompt() : body;

  await _createTherabotNotification(
      id, newBody, globalNotificationScheduleMaps[scheduleInd]);
}

int _getNextScheduleMapInd(NotificationSchedule schedule) {
  Map<String, dynamic> scheduleMapFromNotif = schedule.toMap();
  int? scheduleInd = _getScheduleIndex(scheduleMapFromNotif);
  return scheduleInd! < globalNotificationScheduleMaps.length - 1
      ? scheduleInd + 1
      : 0;
}

int? _getScheduleIndex(Map<String, dynamic> scheduleMapFromNotif) {
  const mapEquals = MapEquality();
  Map<String, int> scheduleMap = Map.fromEntries(scheduleMapFromNotif.entries
      .map((entry) => ['day', 'hour', 'minute', 'second'].contains(entry.key) &&
              entry.value != null
          ? MapEntry(entry.key, entry.value as int)
          : null)
      .whereNotNull());

  log('SCHEDULE MAP (INT): $scheduleMap');
  for (int id in globalNotificationScheduleMaps.keys) {
    if (mapEquals.equals(globalNotificationScheduleMaps[id], scheduleMap)) {
      return id;
    }
  }
}

DateTime _notifScheduleToDateTime(Map<String, dynamic> notificationSchedule,
    {bool init = false}) {
  DateTime now = DateTime.now();
  DateTime scheduled = DateTime(
    now.year,
    now.month,
    notificationSchedule.containsKey('day') &&
            notificationSchedule['day'] != null
        ? notificationSchedule['day']
        : now.day,
    notificationSchedule.containsKey('hour') &&
            notificationSchedule['hour'] != null
        ? notificationSchedule['hour']
        : now.hour,
    notificationSchedule.containsKey('minute') &&
            notificationSchedule['minute'] != null
        ? notificationSchedule['minute']
        : now.minute,
    notificationSchedule.containsKey('second') &&
            notificationSchedule['second'] != null
        ? notificationSchedule['second']
        : now.second,
  );

  if (init) {
    return scheduled;
  }
  if (scheduled.isBefore(now)) {
    if (!(notificationSchedule.containsKey('minute') &&
        notificationSchedule['minute'] != null)) {
      return scheduled.add(const Duration(minutes: 1));
    } else if (!(notificationSchedule.containsKey('hour') &&
        notificationSchedule['hour'] != null)) {
      return scheduled.add(const Duration(hours: 1));
    }
  }
  return scheduled;
}

String _getRandomPrompt() {
  var rng = math.Random();
  return "random prompt: ${rng.nextInt(100)}";
}
