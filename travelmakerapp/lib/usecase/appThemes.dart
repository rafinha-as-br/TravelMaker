import 'package:flutter/material.dart';

class AppThemes{
  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    textTheme: TextTheme(
      displayLarge: TextStyle(color: Color(0x3A6B8A)),
      displayMedium: TextStyle(color: Color(0x3A6B8A)),
      displaySmall: TextStyle(color: Color(0x3A6B8A))
    )
  );
  static final ThemeData darkTeheme = ThemeData(
    scaffoldBackgroundColor: Color(0x1B3C53),
    textTheme: TextTheme(
      displayLarge: TextStyle(color: Color(0xF9F3EF)),
      displayMedium: TextStyle(color: Color(0xF9F3EF)),
      displaySmall: TextStyle(color: Color(0xF9F3EF))
    )
  );

}