import 'package:flutter/material.dart';

class AppThemes {
  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    canvasColor: Color(0xFFE8DED5),
    primaryColor:  Color(0xFF3A6B8A),
    textTheme: const TextTheme(
      displayLarge: TextStyle(color: Color(0xFF3A6B8A), fontSize: 48, fontFamily: 'AlumniSans'),
      displayMedium: TextStyle(color: Color(0xFF3A6B8A), fontSize: 30, fontFamily: 'AlumniSans'),
      displaySmall: TextStyle(color: Color(0xFF3A6B8A), fontSize: 22, fontFamily: 'AlumniSans'),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: Color(0xFF1B3C53),
    primaryColor: Color(0xFFF9F3EF),

    canvasColor: Color(0xFF456882),
    textTheme: const TextTheme(
      displayLarge: TextStyle(color: Color(0xFFF9F3EF), fontSize: 48, fontFamily: 'AlumniSans'),
      displayMedium: TextStyle(color: Color(0xFFF9F3EF), fontSize: 30, fontFamily: 'AlumniSans'),
      displaySmall: TextStyle(color: Color(0xFFF9F3EF), fontSize: 22, fontFamily: 'AlumniSans'),
    ),
  );
}
