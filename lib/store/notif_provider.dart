// import 'dart:collection';
// import 'dart:convert';
// import 'dart:math';

import 'package:flutter/material.dart';
// import 'package:http/http.dart';

class NotifProvider extends ChangeNotifier {
  String? _notificationBody;
  String? getNotificationBody() => _notificationBody;
  void setBody(String body) {
    _notificationBody = body;
    notifyListeners();
  }
}
