import 'package:flutter/material.dart';

class ThemeChange with ChangeNotifier {
  static final ThemeChange _instance = ThemeChange._internal();
  static ThemeChange get instance => _instance;

  ThemeChange._internal();

  bool _isDarkTheme = false;

  bool get isDarkTheme => _isDarkTheme;

  void changeTheme() {
    _isDarkTheme = !_isDarkTheme;
    notifyListeners();
  }
}

// final lightTheme = ThemeData(
//   primarySwatch: Colors.blue,
//   brightness: Brightness.light,
//   appBarTheme: const AppBarTheme(color: Colors.blue),
// );

// final darkTheme = ThemeData(
//   primarySwatch: Colors.blue,
//   brightness: Brightness.dark,
//   appBarTheme: const AppBarTheme(color: Colors.blueGrey),
// );
