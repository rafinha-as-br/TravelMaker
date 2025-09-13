

import 'package:flutter/material.dart';
import 'package:travelmakerapp/usecase/repositories/repository_settings.dart';

import '../entities/validator.dart';

// toggles the theme and saves in sharedPreferences

Future<(Validator, ThemeMode?)> toggleThemeUseCase(
    SettingsRepository settingsRepo
    ) async
{
  // get current theme from sharedPreferences
  final currentTheme = settingsRepo.getCurrentTheme();

  
  final isDark = currentTheme.$2 == ThemeMode.dark;
  ThemeMode newTheme = isDark ? ThemeMode.light : ThemeMode.dark;
  
  //save new theme in sharedPrefs
  Validator saveTheme = await settingsRepo.saveThemeSharedPreferences(newTheme);
  if(!saveTheme.success){
    return (saveTheme, null);
  }

  return (Validator(true, null), newTheme);

}