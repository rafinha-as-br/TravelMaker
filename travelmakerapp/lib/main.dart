import 'package:flutter/material.dart';
import 'package:travelmakerapp/presentation/page/createTravelScreen.dart';
import 'package:travelmakerapp/presentation/page/homeScreen.dart';
import 'package:travelmakerapp/presentation/page/startScreen.dart';
import 'package:travelmakerapp/presentation/page/stopScreen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(myApp());
}

class myApp extends StatelessWidget {
  const myApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: HomeScreen.routeName,

      routes: {
        StartScreen.routeName: (context) => StartScreen(),
        HomeScreen.routeName: (context) => HomeScreen(),
        CreateTravelScreen.routeName: (context) => CreateTravelScreen(),
        StopScreen.routeName: (context) => StopScreen(),
      },
    );
  }
}
