import 'package:flutter/material.dart';

enum Mode {
  trial,
  prod,
  dev,
  prompt
}
class ConfigProvider extends ChangeNotifier {
  Mode mode = Mode.prompt;

  Mode getMode() => mode;
}
