import 'package:flutter/material.dart';

const cPrimaryColor = Color(0xFF22BB9C);
TextStyle cHeadLine = const TextStyle(
    fontWeight: FontWeight.bold, fontFamily: "Cairo", color: Color(0xFF212121));
TextStyle cBodyText =
    const TextStyle(fontWeight: FontWeight.normal, fontFamily: "Cairo");

//provider

class ThemesProvider extends ChangeNotifier {
  bool _isDarkTheme;

  ThemesProvider({required bool darkTheme}) : _isDarkTheme = darkTheme;

  bool get isDarkTheme => _isDarkTheme;

  void changeTheme() {
    _isDarkTheme = !_isDarkTheme;

    notifyListeners();
  }

  ThemeData get themeData => _darkTheme();

  static _darkTheme() {
    return ThemeData(
      primarySwatch: Colors.green,
      fontFamily: "Cairo",
      /*   colorScheme: const ColorScheme.dark(
          primary: cPrimaryColor,
          secondary: Color(0xFF38353F),
          background: Color(0xFF181A20),
          brightness: Brightness.dark),*/

      //  elevatedButtonTheme: ElevatedButtonThemeData(style: ButtonStyle()),
      colorScheme: const ColorScheme.light(
          primary: cPrimaryColor,
          secondary: Color(0xFF616161),
          background: Color(0xFFFFFFFF),
          brightness: Brightness.light),
      textTheme: TextTheme(
          headline1:
              cHeadLine.copyWith(fontSize: 24, fontWeight: FontWeight.w900),
          headline2: cHeadLine.copyWith(fontSize: 20),
          headline3: cHeadLine.copyWith(fontSize: 20, color: cPrimaryColor),
          headline4: cHeadLine.copyWith(fontSize: 20, color: Colors.blueGrey),
          bodyText1: cBodyText.copyWith(fontSize: 18),
          bodyText2: cBodyText.copyWith(fontSize: 16)),
    );
  }
}
