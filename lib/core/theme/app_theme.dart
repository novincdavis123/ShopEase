import 'package:flutter/material.dart';

class AppTheme {
  /// Returns the light theme for the application.
  static ThemeData lightTheme() {
    return ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue);
  }

  /// Returns the dark theme for the application.
  static ThemeData darkTheme() {
    return ThemeData(
      brightness: Brightness.dark,
      useMaterial3: true,
      colorSchemeSeed: Colors.blue,
    );
  }
}
