import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:therabot/navigation/app.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const App());
}
