import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeModel extends ChangeNotifier {
  bool _isDark = true;

  getTheme() => _isDark ? _themeDark : _themeLight;

  setTheme() async {
    _isDark = !_isDark;
    notifyListeners();
  }

  final _themeDark = ThemeData.dark().copyWith(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    dividerColor: Color(0xFF3D403F),
    backgroundColor: Color(0xFF161A19),
    colorScheme: ColorScheme.dark(
        primary: Color(0xFF50BFA4),
        primaryVariant: Color(0xFF5E6665),
        secondary: Color(0xFF9CA6A4),
        secondaryVariant: Color(0xFF5E6665)),
    textTheme: TextTheme(
      bodyText1: GoogleFonts.muli(
          color: Color(0xFFF1F5F4), fontSize: 16, fontWeight: FontWeight.w400),
      bodyText2: GoogleFonts.muli(
          color: Color(0xFFF1F5F4), fontSize: 16, fontWeight: FontWeight.w400),
      caption: GoogleFonts.muli(
          color: Color(0xFF9CA6A4), fontSize: 14, fontWeight: FontWeight.w300),
      button: GoogleFonts.muli(
          color: Color(0xFF5E6665), fontSize: 20, fontWeight: FontWeight.w700),
    ),
  );

  final _themeLight = ThemeData.light().copyWith(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    dividerColor: Color(0xFFD2D9D7),
    backgroundColor: Color(0xFFF5F5F5),
    colorScheme: ColorScheme.dark(
        primary: Color(0xFF50BFA4),
        primaryVariant: Color(0xFFE3E5E5),
        secondary: Color(0xFF9FA6A4),
        secondaryVariant: Color(0xFF9FA6A4)),
    textTheme: TextTheme(
      bodyText1: GoogleFonts.muli(
          color: Color(0xFFF5F5F5), fontSize: 16, fontWeight: FontWeight.w400),
      bodyText2: GoogleFonts.muli(
          color: Color(0xFF202625), fontSize: 16, fontWeight: FontWeight.w400),
      caption: GoogleFonts.muli(
          color: Color(0xFF9FA6A4), fontSize: 14, fontWeight: FontWeight.w300),
      button: GoogleFonts.muli(
          color: Color(0xFF9FA6A4), fontSize: 20, fontWeight: FontWeight.w700),
    ),
  );
}

// class ThemeModel extends ChangeNotifier {
//   bool _isDark = true;

//   ThemeData getTheme() => _isDark ? _themeDark : _themeLight;

//   final _themeDark = ThemeData.dark().copyWith(
//     dividerColor: Color(0xFF3D403F),
//     backgroundColor: Color(0xFF161A19),
//     colorScheme: ColorScheme.dark(
//         primary: Color(0xFF50BFA4),
//         primaryVariant: Color(0xFF5E6665),
//         secondary: Color(0xFF9CA6A4),
//         secondaryVariant: Color(0xFF5E6665)),
//     textTheme: TextTheme(
//       bodyText1: GoogleFonts.muli(
//           color: Color(0xFFF1F5F4), fontSize: 16, fontWeight: FontWeight.w400),
//       bodyText2: GoogleFonts.muli(
//           color: Color(0xFFF1F5F4), fontSize: 16, fontWeight: FontWeight.w400),
//       caption: GoogleFonts.muli(
//           color: Color(0xFF9CA6A4), fontSize: 14, fontWeight: FontWeight.w300),
//       button: GoogleFonts.muli(
//           color: Color(0xFF5E6665), fontSize: 20, fontWeight: FontWeight.w700),
//     ),
//   );

//   final _themeLight = ThemeData.light().copyWith(
//     dividerColor: Color(0xFFD2D9D7),
//     backgroundColor: Color(0xFFF5F5F5),
//     colorScheme: ColorScheme.dark(
//         primary: Color(0xFF50BFA4),
//         primaryVariant: Color(0xFFE3E5E5),
//         secondary: Color(0xFF9FA6A4),
//         secondaryVariant: Color(0xFF9FA6A4)),
//     textTheme: TextTheme(
//       bodyText1: GoogleFonts.muli(
//           color: Color(0xFFF5F5F5), fontSize: 16, fontWeight: FontWeight.w400),
//       bodyText2: GoogleFonts.muli(
//           color: Color(0xFF202625), fontSize: 16, fontWeight: FontWeight.w400),
//       caption: GoogleFonts.muli(
//           color: Color(0xFF9FA6A4), fontSize: 14, fontWeight: FontWeight.w300),
//       button: GoogleFonts.muli(
//           color: Color(0xFF9FA6A4), fontSize: 20, fontWeight: FontWeight.w700),
//     ),
//   );

//   // final Map<String, Color> _themeLight = {
//   //   "userBubble": Color(0xFF50BFA4),
//   //   "botBubble": Color(0xFFE3E5E5),
//   //   "userText": Color(0xFFF5F5F5),
//   //   "botText": Color(0xFF202625),
//   //   "sendIcon": Color(0xFF50BFA4),
//   //   "input": Color(0xFF9FA6A4),
//   //   "feedback": Color(0xFF9FA6A4),
//   //   "dividersSettings": Color(0xFFD2D9D7),
//   //   "background": Color(0xFFF5F5F5),
//   // };
//   // final Map<String, Color> _themeDark = {
//   //   "userBubble": Color(0xFF50BFA4),
//   //   "botBubble": Color(0xFF5E6665),
//   //   "userText": Color(0xFFF1F5F4),
//   //   "botText": Color(0xFFF1F5F4),
//   //   "sendIcon": Color(0xFF50BFA4),
//   //   "input": Color(0xFF9CA6A4),
//   //   "feedback": Color(0xFF5E6665),
//   //   "dividersSettings": Color(0xFF3D403F),
//   //   "background": Color(0xFF161A19),
//   // };

//   void changeTheme() {
//     _isDark = !_isDark;
//     notifyListeners();
//   }
// }
