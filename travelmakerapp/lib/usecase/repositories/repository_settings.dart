import 'package:flutter/material.dart';
import '../../entities/validator.dart';

/// contract repository for settings storage on shared preferences
abstract class SettingsRepository{

  /// to remove settings from sharedPreferences
  Future<void> removeSettingsSharedPreferences();

  /// to save theme on sharedPreferences
  Future<Validator> saveThemeSharedPreferences(ThemeMode theme);

  /// to save the locale on sharedPreferences
  Future<Validator> saveLocaleSharedPrefences(Locale locale);

  /// to getCurrent theme by sharedPreferences
  (Validator, ThemeMode?) getCurrentTheme();

  /// to get current locale by sharedPreferences
  (Validator, Locale?) getCurrentLocale();


}