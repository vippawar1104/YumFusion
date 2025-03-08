import 'package:flutter/material.dart';
import 'package:foodapp/themes/dark_mode.dart';
import 'package:foodapp/themes/light_mode.dart';

class ThemeProvider with ChangeNotifier {
  // Initialize the theme to light mode by default
  ThemeData _themeData = lightMode;

  // Getter to retrieve the current theme data
  ThemeData get currentTheme => _themeData;

  // A boolean to check if the current theme is dark mode
  bool get isDarkMode => _themeData == darkMode;

  // Setter to update the theme data and notify listeners
  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  // Toggle between light and dark mode
  void toggleTheme() {
    if (_themeData == lightMode) {
      themeData = darkMode;
    } else {
      themeData = lightMode;
    }
  }
}
