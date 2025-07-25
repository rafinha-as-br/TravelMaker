import 'package:flutter/material.dart';

class AppThemes {
  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    canvasColor: Color(0xFFE8DED5),
    primaryColor:  Colors.lightBlue,
    textTheme: const TextTheme(
      displayLarge: TextStyle(color: Color(0xFF3A6B8A), fontSize: 40, fontFamily: 'AlumniSans'),
      displayMedium: TextStyle(color: Color(0xFF3A6B8A), fontSize: 30, fontFamily: 'AlumniSans'),
      displaySmall: TextStyle(color: Color(0xFF3A6B8A), fontSize: 22, fontFamily: 'AlumniSans'),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: Color(0xFF1B3C53),
    primaryColor: Colors.lightBlue,

    canvasColor: Color(0xFF456882),
    textTheme: const TextTheme(
      displayLarge: TextStyle(color: Color(0xFFF9F3EF), fontSize: 40, fontFamily: 'AlumniSans'),
      displayMedium: TextStyle(color: Color(0xFFF9F3EF), fontSize: 30, fontFamily: 'AlumniSans'),
      displaySmall: TextStyle(color: Color(0xFFF9F3EF), fontSize: 22, fontFamily: 'AlumniSans'),
    ),
  );
}
