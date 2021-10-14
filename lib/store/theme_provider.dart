import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Theme Schema:
//  Color Palette:
//    Accent -> User message bubble and send button -> colorScheme.primary
//    Bot bubbles -> colorScheme.primaryVariant
//    Light Message / Message -> User message text -> textTheme.bodyText1.color
//    Dark Message / Message -> Bot message text -> textTheme.bodyText2.color
//    Background -> backgroundColor
//    Dividers & Settings -> dividerColor
//    Input -> colorScheme.secondary
//    Feedback -> colorScheme.secondaryVariant
//  Typography:
//    Messages (User) -> textTheme.bodyText1
//    Messages (Bot) -> textTheme.bodyText2
//    Input -> textTheme.caption
//    Feedback Buttons -> textTheme.button

class ThemeProvider extends ChangeNotifier {
  static bool _isDark = true;
  bool _initTheme = false;

  bool fetchTheme() {
    if (_initTheme) {
      return false;
    } else {
      _initTheme = true;
      return true;
    }
  }

  void resetTheme() {
    _isDark = true;
    _initTheme = false;
    // notifyListeners();
  }

  ThemeData getTheme() => _isDark ? _themeDark : _themeLight;

  static ThemeData getThemeStatic() => _isDark ? _themeDark : _themeLight;

  ThemeData getDark() => _themeDark;
  ThemeData getLight() => _themeLight;

  bool getIsDark() => _isDark;

  void toggleTheme() {
    _isDark = !_isDark;
    notifyListeners();
  }

  void setTheme(bool isDark) {
    _isDark = isDark;
    notifyListeners();
  }

  static final _themeDark = ThemeData.dark().copyWith(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    dividerColor: const Color(0xFF3D403F),
    backgroundColor: const Color(0xFF161A19),
    colorScheme: const ColorScheme.dark(
        primary: Color(0xFF50BFA4),
        primaryVariant: Color(0xFF5E6665),
        secondary: Color(0xFF9CA6A4),
        secondaryVariant: Color(0xFF5E6665)),
    textTheme: TextTheme(
      bodyText1: GoogleFonts.mulish(
          color: const Color(0xFFF1F5F4), fontSize: 16, fontWeight: FontWeight.w400),
      bodyText2: GoogleFonts.mulish(
          color: const Color(0xFFF1F5F4), fontSize: 16, fontWeight: FontWeight.w400),
      caption: GoogleFonts.mulish(
          color: const Color(0xFF9CA6A4), fontSize: 14, fontWeight: FontWeight.w300),
      button: GoogleFonts.mulish(
          color: const Color(0xFF5E6665), fontSize: 20, fontWeight: FontWeight.w700),
    ),
  );

  static final _themeLight = ThemeData.light().copyWith(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    dividerColor: const Color(0xFFD2D9D7),
    backgroundColor: const Color(0xFFF5F5F5),
    colorScheme: const ColorScheme.dark(
        primary: Color(0xFF50BFA4),
        primaryVariant: Color(0xFFE3E5E5),
        secondary: Color(0xFF9FA6A4),
        secondaryVariant: Color(0xFF9FA6A4)),
    textTheme: TextTheme(
      bodyText1: GoogleFonts.mulish(
          color: const Color(0xFFF5F5F5), fontSize: 16, fontWeight: FontWeight.w400),
      bodyText2: GoogleFonts.mulish(
          color: const Color(0xFF202625), fontSize: 16, fontWeight: FontWeight.w400),
      caption: GoogleFonts.mulish(
          color: const Color(0xFF9FA6A4), fontSize: 14, fontWeight: FontWeight.w300),
      button: GoogleFonts.mulish(
          color: const Color(0xFF9FA6A4), fontSize: 20, fontWeight: FontWeight.w700),
    ),
  );
}
