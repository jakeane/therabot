import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:therabot/navigation/app.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const App());

  await SentryFlutter.init(
    (options) {
      options.dsn =
          'https://92daf88b6f67453292f1e9f092c250ee@o987702.ingest.sentry.io/6419269';
    },
    appRunner: () => runApp(const App()),
  );
}
