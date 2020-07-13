import 'package:flutter/material.dart';

class ThemeModel extends ChangeNotifier {
  bool _isDark = true;

  Map<String, Color> getTheme() => _isDark ? _themeDark : _themeLight;

  final Map<String, Color> _themeLight = {
    "userBubble": Color(0xFF50BFA4),
    "botBubble": Color(0xFFE3E5E5),
    "userText": Color(0xFFF5F5F5),
    "botText": Color(0xFF202625),
    "sendIcon": Color(0xFF50BFA4),
    "input": Color(0xFF9FA6A4),
    "feedback": Color(0xFF9FA6A4),
    "dividersSettings": Color(0xFFD2D9D7),
    "background": Color(0xFFF5F5F5),
  };
  final Map<String, Color> _themeDark = {
    "userBubble": Color(0xFF5CDDBE),
    "botBubble": Color(0xFF5E6665),
    "userText": Color(0xFFF1F5F4),
    "botText": Color(0xFFF1F5F4),
    "sendIcon": Color(0xFF5CDDBE),
    "input": Color(0xFF9CA6A4),
    "feedback": Color(0xFF5E6665),
    "dividersSettings": Color(0xFF3D403F),
    "background": Color(0xFF161A19),
  };

  void changeTheme() {
    _isDark = !_isDark;
    notifyListeners();
  }
}
