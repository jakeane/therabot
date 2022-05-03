import 'package:flutter/material.dart';

class NotifProvider extends ChangeNotifier {
  String? _notificationBody;
  String? getNotificationBody() => _notificationBody;
  void setBody(String body) {
    _notificationBody = body;
    notifyListeners();
  }
}
