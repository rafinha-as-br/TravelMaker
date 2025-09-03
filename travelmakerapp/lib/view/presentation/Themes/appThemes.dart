import 'package:flutter/material.dart';

class AppThemes {
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: false,
    scaffoldBackgroundColor: Colors.white,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    hoverColor: Colors.transparent,
    canvasColor: Color(0xFFB2EBF2),
    primaryColor: Color(0xFF1B3C53),
    colorScheme: const ColorScheme.light(
      primary: Color(0xFF1B3C53),
      onPrimary: Colors.white,
      secondary: Color(0xFF4DD0E1),
      onSecondary: Colors.white,
      surface: Color(0xFFE8DED5),
      onSurface: Color(0xFF3A6B8A),
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(color: Color(0xFF1B3C53), fontSize: 48, fontFamily: 'AlumniSans', height: 1),
      displayMedium: TextStyle(color: Color(0xFF1B3C53), fontSize: 30, fontFamily: 'AlumniSans', height: 1),
      displaySmall: TextStyle(color: Color(0xFF1B3C53), fontSize: 22, fontFamily: 'AlumniSans', height: 1),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: false,
    scaffoldBackgroundColor: Color(0xFF1B3C53),
    primaryColor: Color(0xFFF9F3EF),
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    hoverColor: Colors.transparent,
    canvasColor: Color(0xFF456882),
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFFF9F3EF),
      onPrimary: Color(0xFF1B3C53),
      secondary: Color(0xFF107BCA),
      onSecondary: Colors.white,
      surface: Color(0xFF456882),
      onSurface: Color(0xFFF9F3EF),
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(color: Color(0xFFF9F3EF), fontSize: 48, fontFamily: 'AlumniSans', height: 1),
      displayMedium: TextStyle(color: Color(0xFFF9F3EF), fontSize: 30, fontFamily: 'AlumniSans', height: 1),
      displaySmall: TextStyle(color: Color(0xFFF9F3EF), fontSize: 22, fontFamily: 'AlumniSans', height: 1),
    ),
  );
}
