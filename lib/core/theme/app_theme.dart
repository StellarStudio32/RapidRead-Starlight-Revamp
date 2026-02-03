import 'package:flutter/material.dart';

/// AppTheme provides a centralized place to manage the application's themes.
/// This follows the Clean Architecture principle of separating UI concerns.
/// By defining themes here, we ensure consistency and make it easy to
/// update the look and feel of the entire app from one place.
class AppTheme {
  // Private constructor to prevent instantiation.
  AppTheme._();

  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: Colors.grey[100],
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.blue,
      foregroundColor: Colors.white,
    ),
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
  );

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: Colors.blue[700],
    scaffoldBackgroundColor: Colors.grey[900],
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.blue[800],
      foregroundColor: Colors.white,
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blue,
      brightness: Brightness.dark,
    ),
  );
}
