import 'package:flutter/material.dart';
import 'package:travelmakerapp/entities/validator.dart';

abstract class SettingsRepository{
  Future<void> removeSettingsSharedPreferences();
  Future<Validator> saveThemeSharedPreferences(ThemeMode theme);
  Future<Validator> saveLocaleSharedPrefences(Locale locale);
  (Validator, ThemeMode?) getCurrentTheme();
  (Validator, Locale?) getCurrentLocale();


}