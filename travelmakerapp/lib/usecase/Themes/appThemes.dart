import 'package:flutter/material.dart';

class AppThemes {
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: false,
    scaffoldBackgroundColor: Colors.white,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    hoverColor: Colors.transparent,
    canvasColor: Color(0xFFE8DED5),
    primaryColor:  Color(0xFF3A6B8A),
    textTheme: const TextTheme(
      displayLarge: TextStyle(color: Color(0xFF3A6B8A), fontSize: 48, fontFamily: 'AlumniSans', height: 1),
      displayMedium: TextStyle(color: Color(0xFF3A6B8A), fontSize: 30, fontFamily: 'AlumniSans', height: 1),
      displaySmall: TextStyle(color: Color(0xFF3A6B8A), fontSize: 22, fontFamily: 'AlumniSans', height: 1),
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
    textTheme: const TextTheme(
      displayLarge: TextStyle(color: Color(0xFFF9F3EF), fontSize: 48, fontFamily: 'AlumniSans', height: 1),
      displayMedium: TextStyle(color: Color(0xFFF9F3EF), fontSize: 30, fontFamily: 'AlumniSans', height: 1),
      displaySmall: TextStyle(color: Color(0xFFF9F3EF), fontSize: 22, fontFamily: 'AlumniSans', height: 1),
    ),
  );
}
