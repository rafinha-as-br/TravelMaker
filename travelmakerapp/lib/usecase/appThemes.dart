import 'package:flutter/material.dart';

class AppThemes {
  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    textTheme: const TextTheme(
      displayLarge: TextStyle(color: Color(0xFF3A6B8A), fontSize: 40, fontFamily: 'AlumniSans'),
      displayMedium: TextStyle(color: Color(0xFF3A6B8A), fontSize: 30, fontFamily: 'AlumniSans'),
      displaySmall: TextStyle(color: Color(0xFF3A6B8A), fontSize: 10, fontFamily: 'AlumniSans'),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: Color(0xFF1B3C53),
    textTheme: const TextTheme(
      displayLarge: TextStyle(color: Color(0xFFF9F3EF), height: 700),
      displayMedium: TextStyle(color: Color(0xFFF9F3EF), height: 700),
      displaySmall: TextStyle(color: Color(0xFFF9F3EF), height: 700),
    ),
  );
}
