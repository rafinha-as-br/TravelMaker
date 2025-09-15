import 'package:flutter/material.dart';

/// The user settings that chan be changed
class AppSettings {
  /// theme mode of the app
  final ThemeMode themeMode;

  /// locale for language
  final Locale locale;

  ///
  AppSettings({required this.themeMode, required this.locale});
}