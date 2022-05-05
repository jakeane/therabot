import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:therabot/navigation/app.dart';
import 'package:therabot/notifications.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await initializeTherabotNotification();

  runApp(const App());
}
