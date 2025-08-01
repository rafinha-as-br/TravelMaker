import 'dart:ui';

import 'package:flutter/material.dart';

import '../sharedPreferences/sharedPreferencesInstance.dart';
import 'appThemes.dart';

// return witch theme is active
// this function is used to get de boolean value to see witch theme is active

bool getActiveTheme(){
  final sharedPreferences = SharedPreferencesInstance().preferences;
  bool darkTheme = sharedPreferences.getBool('darkTheme') ?? false;
  return darkTheme;
}


/// these functions return witch theme is active

// return primaryColor
Color getPrimaryColor(){
  bool darkTheme = getActiveTheme();
  Color primaryColor = darkTheme ? AppThemes.darkTheme.primaryColor : AppThemes.lightTheme.primaryColor;
  return primaryColor;
}

// return canvasColor
Color getCanvasColor(){
  bool darkTheme = getActiveTheme();
  Color canvasColor = darkTheme ? AppThemes.darkTheme.canvasColor : AppThemes.lightTheme.canvasColor;
  return canvasColor;
}

Color getAlternativeCanvasColor(){
  bool darkTheme = getActiveTheme();
  Color canvasColor = darkTheme ? AppThemes.darkTheme.scaffoldBackgroundColor : AppThemes.lightTheme.scaffoldBackgroundColor;
  return canvasColor;
}

// return themeMode
ThemeMode getThemeMode(){
  bool darkTheme = getActiveTheme();
  ThemeMode themeMode = darkTheme ? ThemeMode.dark : ThemeMode.light;
  return themeMode;
}

// return iconData theme
IconData getIconTheme(){
  bool darkTheme = getActiveTheme();
  IconData icon = darkTheme ? Icons.dark_mode_outlined : Icons.light_mode_outlined;
  return icon;
}
