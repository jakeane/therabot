import 'package:flutter/material.dart';

enum Mode {
  trial,
  prod,
  dev
}
class ConfigProvider extends ChangeNotifier {
  Mode mode = Mode.trial;

  Mode getMode() => mode;
}
