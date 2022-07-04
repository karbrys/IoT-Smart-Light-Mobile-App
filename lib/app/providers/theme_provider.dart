import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.dark;

  bool get isDarkMode => themeMode == ThemeMode.dark;

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class AppThemes {
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: Color.fromRGBO(26, 26, 26, 1.0),
    colorScheme: ColorScheme.dark(),
    primaryColor: Color.fromRGBO(48, 48, 48, 1.0),
    appBarTheme: AppBarTheme(
      backgroundColor: Color.fromRGBO(26, 26, 26, 1.0),
    ),
    shadowColor: Color.fromRGBO(45, 45, 45, 0.4),
  );

  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: Color.fromRGBO(249, 249, 249, 1.0),
    colorScheme: ColorScheme.light(),
    primaryColor: Color.fromRGBO(241, 241, 241, 1.0),
    appBarTheme: AppBarTheme(
      backgroundColor: Color.fromRGBO(249, 249, 249, 1.0),
      foregroundColor: Colors.black,
    ),
    shadowColor: Color.fromRGBO(166, 166, 166, 0.4),
  );
}
